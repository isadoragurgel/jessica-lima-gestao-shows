-- Fase 3: convites de acesso ao espaço 'nós.'
-- Execute no SQL Editor com privilégios de administrador. Não altera dados antigos.
BEGIN;
CREATE TABLE IF NOT EXISTS public.mc_household_invites (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id uuid NOT NULL REFERENCES public.mc_households(id) ON DELETE CASCADE,
  invited_email text NOT NULL,
  token_hash text NOT NULL UNIQUE,
  invited_by uuid NOT NULL REFERENCES auth.users(id),
  expires_at timestamptz NOT NULL DEFAULT (now() + interval '48 hours'),
  accepted_by uuid REFERENCES auth.users(id),
  accepted_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS mc_household_invites_household_idx ON public.mc_household_invites(household_id);
ALTER TABLE public.mc_household_invites ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.mc_household_invites FROM anon, authenticated;
-- Sem acesso direto à tabela. Convites apenas por funções validadas.
CREATE OR REPLACE FUNCTION public.mc_create_household_invite(p_email text)
RETURNS text LANGUAGE plpgsql SECURITY DEFINER SET search_path TO '' AS $fn$
DECLARE v_user uuid := auth.uid(); v_household uuid; v_email text; v_token text;
BEGIN
 IF v_user IS NULL THEN RAISE EXCEPTION 'Autenticacao necessaria'; END IF;
 v_email := lower(trim(coalesce(p_email,'')));
 IF v_email !~ '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$' OR length(v_email)>254 THEN
   RAISE EXCEPTION 'Email invalido';
 END IF;
 SELECT household_id INTO v_household FROM public.mc_household_members
 WHERE user_id=v_user AND role='owner' LIMIT 1;
 IF v_household IS NULL THEN RAISE EXCEPTION 'Apenas proprietaria pode convidar'; END IF;
 IF EXISTS (SELECT 1 FROM auth.users WHERE id=v_user AND lower(email)=v_email) THEN
   RAISE EXCEPTION 'Nao e possivel convidar o proprio email';
 END IF;
 IF (SELECT count(*) FROM public.mc_household_members WHERE household_id=v_household) >= 2 THEN
   RAISE EXCEPTION 'Este espaco ja tem dois membros';
 END IF;
 v_token := replace(gen_random_uuid()::text,'-','') || replace(gen_random_uuid()::text,'-','');
 INSERT INTO public.mc_household_invites(household_id,invited_email,token_hash,invited_by)
 VALUES(v_household,v_email,md5(v_token),v_user);
 RETURN v_token;
END;$fn$;
CREATE OR REPLACE FUNCTION public.mc_accept_household_invite(p_token text)
RETURNS uuid LANGUAGE plpgsql SECURITY DEFINER SET search_path TO '' AS $fn$
DECLARE v_user uuid := auth.uid(); v_email text; v_inv public.mc_household_invites%ROWTYPE;
BEGIN
 IF v_user IS NULL THEN RAISE EXCEPTION 'Autenticacao necessaria'; END IF;
 SELECT lower(email) INTO v_email FROM auth.users WHERE id=v_user AND email_confirmed_at IS NOT NULL;
 IF v_email IS NULL THEN RAISE EXCEPTION 'Confirme seu email antes de aceitar'; END IF;
 IF p_token IS NULL OR p_token !~ '^[0-9a-f]{64}$' THEN RAISE EXCEPTION 'Convite invalido'; END IF;
 SELECT * INTO v_inv FROM public.mc_household_invites
 WHERE token_hash=md5(p_token) AND accepted_at IS NULL AND expires_at>now()
 FOR UPDATE;
 IF NOT FOUND OR v_inv.invited_email<>v_email THEN RAISE EXCEPTION 'Convite invalido, expirado ou destinado a outro email'; END IF;
 IF EXISTS(SELECT 1 FROM public.mc_household_members WHERE user_id=v_user) THEN
   RAISE EXCEPTION 'Esta conta ja pertence a um espaco';
 END IF;
 -- Bloqueio concorrente para limitar o espaço a dois membros.
 PERFORM 1 FROM public.mc_households WHERE id=v_inv.household_id FOR UPDATE;
 IF (SELECT count(*) FROM public.mc_household_members WHERE household_id=v_inv.household_id)>=2 THEN
   RAISE EXCEPTION 'Este espaco ja tem dois membros';
 END IF;
 INSERT INTO public.mc_household_members(household_id,user_id,role)
 VALUES(v_inv.household_id,v_user,'member');
 INSERT INTO public.mc_member_profiles(household_id,user_id)
 VALUES(v_inv.household_id,v_user);
 UPDATE public.mc_household_invites SET accepted_by=v_user,accepted_at=now() WHERE id=v_inv.id;
 RETURN v_inv.household_id;
END;$fn$;
REVOKE ALL ON FUNCTION public.mc_create_household_invite(text) FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.mc_accept_household_invite(text) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.mc_create_household_invite(text) TO authenticated;
GRANT EXECUTE ON FUNCTION public.mc_accept_household_invite(text) TO authenticated;
COMMIT;
