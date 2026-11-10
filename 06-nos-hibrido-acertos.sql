-- nós. | Híbrido proporcional: estrutura ADITIVA, sem alteração dos movimentos existentes.
-- Executar APÓS backup. Não classifica movimentos antigos automaticamente.
BEGIN;
CREATE TABLE IF NOT EXISTS public.nos_shared_expenses (
 transaction_id uuid PRIMARY KEY REFERENCES public.nos_transactions(id) ON DELETE CASCADE,
 household_id uuid NOT NULL REFERENCES public.mc_households(id),
 paid_by uuid NOT NULL REFERENCES auth.users(id),
 created_at timestamptz NOT NULL DEFAULT now(),
 FOREIGN KEY (household_id,paid_by) REFERENCES public.mc_household_members(household_id,user_id)
);
CREATE TABLE IF NOT EXISTS public.nos_settlement_payments (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 household_id uuid NOT NULL REFERENCES public.mc_households(id),
 month date NOT NULL CHECK (EXTRACT(DAY FROM month)=1 AND month>=DATE '2026-11-01'),
 from_user uuid NOT NULL REFERENCES auth.users(id),
 to_user uuid NOT NULL REFERENCES auth.users(id),
 amount numeric(14,2) NOT NULL CHECK (amount>0),
 note text,
 created_by uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
 created_at timestamptz NOT NULL DEFAULT now(),
 CHECK(from_user<>to_user),
 FOREIGN KEY (household_id,from_user) REFERENCES public.mc_household_members(household_id,user_id),
 FOREIGN KEY (household_id,to_user) REFERENCES public.mc_household_members(household_id,user_id)
);
CREATE OR REPLACE FUNCTION public.nos_validate_shared_expense() RETURNS trigger
LANGUAGE plpgsql SET search_path = public AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.nos_transactions t WHERE t.id=NEW.transaction_id AND t.household_id=NEW.household_id AND t.kind='expense') THEN
  RAISE EXCEPTION 'A despesa compartilhada precisa pertencer ao mesmo casal e ser do tipo despesa';
 END IF;
 RETURN NEW;
END $$;
DROP TRIGGER IF EXISTS nos_shared_expense_validate ON public.nos_shared_expenses;
CREATE TRIGGER nos_shared_expense_validate BEFORE INSERT OR UPDATE ON public.nos_shared_expenses FOR EACH ROW EXECUTE FUNCTION public.nos_validate_shared_expense();
ALTER TABLE public.nos_shared_expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.nos_settlement_payments ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS nos_shared_select ON public.nos_shared_expenses;
CREATE POLICY nos_shared_select ON public.nos_shared_expenses FOR SELECT TO authenticated USING(public.mc_is_household_member(household_id));
DROP POLICY IF EXISTS nos_shared_insert ON public.nos_shared_expenses;
CREATE POLICY nos_shared_insert ON public.nos_shared_expenses FOR INSERT TO authenticated WITH CHECK(public.mc_is_household_member(household_id));
DROP POLICY IF EXISTS nos_shared_update ON public.nos_shared_expenses;
CREATE POLICY nos_shared_update ON public.nos_shared_expenses FOR UPDATE TO authenticated USING(public.mc_is_household_member(household_id)) WITH CHECK(public.mc_is_household_member(household_id));
DROP POLICY IF EXISTS nos_shared_delete ON public.nos_shared_expenses;
CREATE POLICY nos_shared_delete ON public.nos_shared_expenses FOR DELETE TO authenticated USING(public.mc_is_household_member(household_id));
DROP POLICY IF EXISTS nos_settlement_select ON public.nos_settlement_payments;
CREATE POLICY nos_settlement_select ON public.nos_settlement_payments FOR SELECT TO authenticated USING(public.mc_is_household_member(household_id));
DROP POLICY IF EXISTS nos_settlement_insert ON public.nos_settlement_payments;
CREATE POLICY nos_settlement_insert ON public.nos_settlement_payments FOR INSERT TO authenticated WITH CHECK(public.mc_is_household_member(household_id) AND created_by=auth.uid());
DROP POLICY IF EXISTS nos_settlement_delete ON public.nos_settlement_payments;
CREATE POLICY nos_settlement_delete ON public.nos_settlement_payments FOR DELETE TO authenticated USING(public.mc_is_household_member(household_id) AND created_by=auth.uid());
GRANT SELECT,INSERT,UPDATE,DELETE ON public.nos_shared_expenses TO authenticated;
GRANT SELECT,INSERT,DELETE ON public.nos_settlement_payments TO authenticated;
COMMIT;
