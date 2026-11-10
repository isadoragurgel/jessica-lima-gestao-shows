-- MIGRAÇÃO OPCIONAL, ADITIVA: NÃO EXECUTADA PELO ASSISTENTE.
-- Conferir o backup antes de executar. Não modifica nenhuma tabela existente.
-- Novas tabelas guardam saldos iniciais e aportes/resgates separadamente.
BEGIN;
CREATE TABLE IF NOT EXISTS public.nos_investment_balances (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id uuid NOT NULL REFERENCES public.mc_households(id),
  owner_user_id uuid NULL REFERENCES auth.users(id),
  opening_balance numeric(16,2) NOT NULL DEFAULT 0 CHECK (opening_balance >= 0),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX IF NOT EXISTS nos_investment_balances_person_unique
  ON public.nos_investment_balances(household_id, owner_user_id) WHERE owner_user_id IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS nos_investment_balances_couple_unique
  ON public.nos_investment_balances(household_id) WHERE owner_user_id IS NULL;
CREATE TABLE IF NOT EXISTS public.nos_investment_movements (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id uuid NOT NULL REFERENCES public.mc_households(id),
  created_by uuid NOT NULL REFERENCES auth.users(id),
  owner_user_id uuid NULL REFERENCES auth.users(id),
  account_id uuid NOT NULL REFERENCES public.nos_accounts(id),
  transaction_date date NOT NULL CHECK (transaction_date >= DATE '2026-11-01'),
  description text NOT NULL CHECK (length(trim(description)) > 0),
  movement_type text NOT NULL CHECK (movement_type IN ('deposit','withdrawal')),
  amount numeric(16,2) NOT NULL CHECK (amount > 0),
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS nos_investment_movements_household_date_idx
 ON public.nos_investment_movements(household_id, transaction_date);
ALTER TABLE public.nos_investment_balances ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.nos_investment_movements ENABLE ROW LEVEL SECURITY;
-- Ler: somente membros do próprio espaço.
DROP POLICY IF EXISTS nos_inv_bal_select ON public.nos_investment_balances;
CREATE POLICY nos_inv_bal_select ON public.nos_investment_balances FOR SELECT TO authenticated
 USING (EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_balances.household_id AND m.user_id=(SELECT auth.uid())));
-- Escrever: cada pessoa altera seu saldo inicial; qualquer membro pode gerir o saldo do casal.
DROP POLICY IF EXISTS nos_inv_bal_insert ON public.nos_investment_balances;
CREATE POLICY nos_inv_bal_insert ON public.nos_investment_balances FOR INSERT TO authenticated
 WITH CHECK ((owner_user_id IS NULL OR owner_user_id=(SELECT auth.uid())) AND EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_balances.household_id AND m.user_id=(SELECT auth.uid())));
DROP POLICY IF EXISTS nos_inv_bal_update ON public.nos_investment_balances;
CREATE POLICY nos_inv_bal_update ON public.nos_investment_balances FOR UPDATE TO authenticated
 USING ((owner_user_id IS NULL OR owner_user_id=(SELECT auth.uid())) AND EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_balances.household_id AND m.user_id=(SELECT auth.uid())))
 WITH CHECK ((owner_user_id IS NULL OR owner_user_id=(SELECT auth.uid())) AND EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_balances.household_id AND m.user_id=(SELECT auth.uid())));
DROP POLICY IF EXISTS nos_inv_mov_select ON public.nos_investment_movements;
CREATE POLICY nos_inv_mov_select ON public.nos_investment_movements FOR SELECT TO authenticated
 USING (EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_movements.household_id AND m.user_id=(SELECT auth.uid())));
DROP POLICY IF EXISTS nos_inv_mov_insert ON public.nos_investment_movements;
CREATE POLICY nos_inv_mov_insert ON public.nos_investment_movements FOR INSERT TO authenticated
 WITH CHECK (created_by=(SELECT auth.uid()) AND EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_movements.household_id AND m.user_id=(SELECT auth.uid())) AND EXISTS (SELECT 1 FROM public.nos_accounts a WHERE a.id=account_id AND a.household_id=nos_investment_movements.household_id) AND (owner_user_id IS NULL OR EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_movements.household_id AND m.user_id=owner_user_id)));
DROP POLICY IF EXISTS nos_inv_mov_update ON public.nos_investment_movements;
CREATE POLICY nos_inv_mov_update ON public.nos_investment_movements FOR UPDATE TO authenticated
 USING (EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_movements.household_id AND m.user_id=(SELECT auth.uid())))
 WITH CHECK (EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_movements.household_id AND m.user_id=(SELECT auth.uid())) AND EXISTS (SELECT 1 FROM public.nos_accounts a WHERE a.id=account_id AND a.household_id=nos_investment_movements.household_id) AND (owner_user_id IS NULL OR EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_movements.household_id AND m.user_id=owner_user_id)));
DROP POLICY IF EXISTS nos_inv_mov_delete ON public.nos_investment_movements;
CREATE POLICY nos_inv_mov_delete ON public.nos_investment_movements FOR DELETE TO authenticated
 USING (EXISTS (SELECT 1 FROM public.mc_household_members m WHERE m.household_id=nos_investment_movements.household_id AND m.user_id=(SELECT auth.uid())));
GRANT SELECT, INSERT, UPDATE ON public.nos_investment_balances TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.nos_investment_movements TO authenticated;
COMMIT;
