SELECT
track_name,
count(*) as qtd_duplicada
FROM
  `my-project-laboratoria.dadoslaboratoria.Tabela_unida_corrigida`
  GROUP BY
 track_name
having
count(*)>1;

select
*
from 
`my-project-laboratoria.dadoslaboratoria.Tabela_unida_corrigida`
where track_name = "Flowers"