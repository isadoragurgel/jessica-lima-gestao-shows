-- Rever e executar apenas depois de guardar um backup recuperável.
-- Não altera os saldos existentes; todos continuam incluídos em EUR por padrão.
ALTER TABLE public.nos_investment_balances
  ADD COLUMN IF NOT EXISTS currency text NOT NULL DEFAULT 'EUR',
  ADD COLUMN IF NOT EXISTS include_in_household boolean NOT NULL DEFAULT true;
ALTER TABLE public.nos_investment_balances
  DROP CONSTRAINT IF EXISTS nos_investment_balances_currency_supported;
ALTER TABLE public.nos_investment_balances
  ADD CONSTRAINT nos_investment_balances_currency_supported
  CHECK (currency IN ('EUR','USD','GBP','BRL'));
