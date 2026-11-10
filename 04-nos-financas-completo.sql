-- nós. | Fase 4 | Execute apenas depois de backup.
-- Migração aditiva: NÃO altera mc_accounts/mc_transactions antigas nem shows.
BEGIN;
CREATE TABLE IF NOT EXISTS public.nos_accounts (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), household_id uuid NOT NULL REFERENCES public.mc_households(id),
 created_by uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id), name text NOT NULL CHECK(length(trim(name)) BETWEEN 1 AND 100),
 currency text NOT NULL DEFAULT 'EUR', opening_balance numeric(14,2) NOT NULL DEFAULT 0,
 opening_date date NOT NULL DEFAULT '2026-11-01', archived boolean NOT NULL DEFAULT false,
 created_at timestamptz NOT NULL DEFAULT now(), UNIQUE(household_id,id)
);
CREATE TABLE IF NOT EXISTS public.nos_categories (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), household_id uuid NOT NULL REFERENCES public.mc_households(id),
 name text NOT NULL, kind text NOT NULL CHECK(kind IN ('income','expense')),
 icon text NOT NULL DEFAULT '●', archived boolean NOT NULL DEFAULT false,
 created_at timestamptz NOT NULL DEFAULT now(), UNIQUE(household_id,id)
);
CREATE TABLE IF NOT EXISTS public.nos_transactions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), household_id uuid NOT NULL REFERENCES public.mc_households(id),
 created_by uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
 transaction_date date NOT NULL CHECK(transaction_date >= DATE '2026-11-01'),
 kind text NOT NULL CHECK(kind IN ('income','expense','transfer')),
 amount numeric(14,2) NOT NULL CHECK(amount > 0), description text NOT NULL CHECK(length(trim(description)) > 0),
 account_id uuid NOT NULL, destination_account_id uuid,
 category_id uuid, notes text, created_at timestamptz NOT NULL DEFAULT now(),
 updated_at timestamptz NOT NULL DEFAULT now(),
 FOREIGN KEY (household_id,account_id) REFERENCES public.nos_accounts(household_id,id),
 FOREIGN KEY (household_id,destination_account_id) REFERENCES public.nos_accounts(household_id,id),
 FOREIGN KEY (household_id,category_id) REFERENCES public.nos_categories(household_id,id),
 CHECK ((kind='transfer' AND destination_account_id IS NOT NULL AND destination_account_id<>account_id AND category_id IS NULL)
 OR (kind<>'transfer' AND destination_account_id IS NULL))
);
CREATE TABLE IF NOT EXISTS public.nos_budgets (
 household_id uuid NOT NULL REFERENCES public.mc_households(id), month date NOT NULL,
 category_id uuid NOT NULL, amount numeric(14,2) NOT NULL CHECK(amount>=0),
 PRIMARY KEY(household_id,month,category_id),
 FOREIGN KEY (household_id,category_id) REFERENCES public.nos_categories(household_id,id),
 CHECK (EXTRACT(day FROM month)=1)
);
CREATE INDEX IF NOT EXISTS nos_tx_household_date_idx ON public.nos_transactions(household_id,transaction_date DESC);
CREATE INDEX IF NOT EXISTS nos_accounts_household_idx ON public.nos_accounts(household_id);
CREATE INDEX IF NOT EXISTS nos_categories_household_idx ON public.nos_categories(household_id);
ALTER TABLE public.nos_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.nos_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.nos_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.nos_budgets ENABLE ROW LEVEL SECURITY;
-- Todas as contas NOVAS são familiares nesta versão. Não há exposição das tabelas financeiras antigas.
DROP POLICY IF EXISTS nos_accounts_select ON public.nos_accounts;
CREATE POLICY nos_accounts_select ON public.nos_accounts FOR SELECT TO authenticated USING (public.mc_is_household_member(household_id));
DROP POLICY IF EXISTS nos_accounts_insert ON public.nos_accounts;
CREATE POLICY nos_accounts_insert ON public.nos_accounts FOR INSERT TO authenticated WITH CHECK(public.mc_is_household_member(household_id) AND created_by=(SELECT auth.uid()));
DROP POLICY IF EXISTS nos_accounts_update ON public.nos_accounts;
CREATE POLICY nos_accounts_update ON public.nos_accounts FOR UPDATE TO authenticated USING(public.mc_is_household_member(household_id)) WITH CHECK(public.mc_is_household_member(household_id));
DROP POLICY IF EXISTS nos_categories_all ON public.nos_categories;
CREATE POLICY nos_categories_all ON public.nos_categories FOR ALL TO authenticated USING(public.mc_is_household_member(household_id)) WITH CHECK(public.mc_is_household_member(household_id));
DROP POLICY IF EXISTS nos_transactions_all ON public.nos_transactions;
CREATE POLICY nos_transactions_all ON public.nos_transactions FOR ALL TO authenticated USING(public.mc_is_household_member(household_id)) WITH CHECK(public.mc_is_household_member(household_id) AND created_by=(SELECT auth.uid()));
-- O autor é imutável: edições de lançamentos do outro membro são feitas via RPC com validação própria numa etapa futura.
DROP POLICY IF EXISTS nos_budgets_all ON public.nos_budgets;
CREATE POLICY nos_budgets_all ON public.nos_budgets FOR ALL TO authenticated USING(public.mc_is_household_member(household_id)) WITH CHECK(public.mc_is_household_member(household_id));
GRANT SELECT,INSERT,UPDATE ON public.nos_accounts TO authenticated;
GRANT SELECT,INSERT,UPDATE,DELETE ON public.nos_categories,public.nos_transactions,public.nos_budgets TO authenticated;
COMMIT;
