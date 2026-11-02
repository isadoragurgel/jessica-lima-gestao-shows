-- Execute uma única vez no Supabase SQL Editor, ANTES de publicar a Fase 3.
-- Não apaga nem altera dados existentes.
ALTER TABLE public.jl_gigs
ADD COLUMN IF NOT EXISTS expected_receipt_month text;

ALTER TABLE public.jl_gigs
DROP CONSTRAINT IF EXISTS jl_gigs_expected_receipt_month_format;
ALTER TABLE public.jl_gigs
ADD CONSTRAINT jl_gigs_expected_receipt_month_format
CHECK (expected_receipt_month IS NULL OR expected_receipt_month ~ '^[0-9]{4}-(0[1-9]|1[0-2])$');
