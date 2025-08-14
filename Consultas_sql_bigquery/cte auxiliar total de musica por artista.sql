SELECT
  artist_s__name,
  COUNT(*) AS total_tracks
FROM
  `my-project-laboratoria.dadoslaboratoria.Tabela_unida_corrigida`
GROUP BY 
  artist_s__name
ORDER BY 
  total_tracks DESC