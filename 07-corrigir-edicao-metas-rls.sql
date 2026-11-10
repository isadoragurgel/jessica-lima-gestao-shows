-- Opcional: executar SOMENTE se a edição de metas continuar bloqueada por RLS.
-- Política restrita aos membros do mesmo espaço. Não apaga nem altera registros.
BEGIN;
DROP POLICY IF EXISTS nos_goals_member_update ON public.mc_goals;
CREATE POLICY nos_goals_member_update ON public.mc_goals
FOR UPDATE TO authenticated
USING (public.mc_is_household_member(household_id))
WITH CHECK (public.mc_is_household_member(household_id));
GRANT SELECT, UPDATE ON public.mc_goals TO authenticated;
COMMIT;
