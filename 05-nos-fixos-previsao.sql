-- nós. | Receitas e gastos fixos | executar após a migração da Fase 4
-- Não apaga nem modifica os dados financeiros antigos.
BEGIN;
CREATE TABLE IF NOT EXISTS public.nos_recurring (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 household_id uuid NOT NULL REFERENCES public.mc_households(id),
 created_by uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
 kind text NOT NULL CHECK (kind IN ('income','expense')),
 description text NOT NULL CHECK (length(trim(description)) BETWEEN 1 AND 200),
 amount numeric(14,2) NOT NULL CHECK (amount > 0),
 due_day integer NOT NULL CHECK (due_day BETWEEN 1 AND 31),
 account_id uuid NOT NULL,
 category_id uuid,
 start_month date NOT NULL DEFAULT DATE '2026-11-01',
 end_month date,
 notes text,
 active boolean NOT NULL DEFAULT true,
 created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE (household_id,id),
 FOREIGN KEY (household_id,account_id) REFERENCES public.nos_accounts(household_id,id),
 FOREIGN KEY (household_id,category_id) REFERENCES public.nos_categories(household_id,id),
 CHECK (start_month >= DATE '2026-11-01' AND EXTRACT(DAY FROM start_month)=1),
 CHECK (end_month IS NULL OR (end_month >= start_month AND EXTRACT(DAY FROM end_month)=1))
);
ALTER TABLE public.nos_recurring ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS nos_recurring_select ON public.nos_recurring;
CREATE POLICY nos_recurring_select ON public.nos_recurring FOR SELECT TO authenticated USING (public.mc_is_household_member(household_id));
DROP POLICY IF EXISTS nos_recurring_insert ON public.nos_recurring;
CREATE POLICY nos_recurring_insert ON public.nos_recurring FOR INSERT TO authenticated WITH CHECK (public.mc_is_household_member(household_id) AND created_by=auth.uid());
DROP POLICY IF EXISTS nos_recurring_update ON public.nos_recurring;
CREATE POLICY nos_recurring_update ON public.nos_recurring FOR UPDATE TO authenticated USING (public.mc_is_household_member(household_id) AND created_by=auth.uid()) WITH CHECK (public.mc_is_household_member(household_id) AND created_by=auth.uid());
GRANT SELECT,INSERT,UPDATE ON public.nos_recurring TO authenticated;
ALTER TABLE public.nos_transactions ADD COLUMN IF NOT EXISTS recurring_id uuid;
-- Evita que uma mesma obrigação mensal seja registada duas vezes.
ALTER TABLE public.nos_transactions ADD COLUMN IF NOT EXISTS recurring_month date GENERATED ALWAYS AS (date_trunc('month',transaction_date::timestamp)::date) STORED;
ALTER TABLE public.nos_transactions DROP CONSTRAINT IF EXISTS nos_tx_recurring_household_fk;
ALTER TABLE public.nos_transactions ADD CONSTRAINT nos_tx_recurring_household_fk FOREIGN KEY (household_id,recurring_id) REFERENCES public.nos_recurring(household_id,id) ON DELETE RESTRICT;
CREATE UNIQUE INDEX IF NOT EXISTS nos_tx_recurring_once_per_month ON public.nos_transactions(recurring_id,recurring_month) WHERE recurring_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS nos_recurring_household_idx ON public.nos_recurring(household_id,active);
COMMIT;
