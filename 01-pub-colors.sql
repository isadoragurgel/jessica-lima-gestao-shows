-- Execute uma vez no SQL Editor antes de publicar esta atualização.
begin;
alter table public.jl_venues add column if not exists tag_color text;
do $$
begin
  if not exists (select 1 from pg_constraint where conrelid='public.jl_venues'::regclass and conname='jl_venues_tag_color_check') then
    alter table public.jl_venues add constraint jl_venues_tag_color_check
      check (tag_color is null or tag_color ~ '^#[0-9A-Fa-f]{6}$');
  end if;
end $$;
notify pgrst, 'reload schema';
commit;
