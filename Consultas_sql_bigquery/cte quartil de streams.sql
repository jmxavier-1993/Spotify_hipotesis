WITH quartiles AS (
  SELECT
    track_id,
    streams,
    NTILE(4) OVER (ORDER BY streams) AS quartiles_streams
  FROM
    `my-project-laboratoria.dadoslaboratoria.view_unificada_tabela`
)
SELECT
   a.*,
   q.quartiles_streams,
   CASE
     WHEN q.quartiles_streams = 1 THEN 'Baixo'
     WHEN q.quartiles_streams = 2 THEN 'Médio-Baixo'
     WHEN q.quartiles_streams = 3 THEN 'Médio-Alto'
     WHEN q.quartiles_streams = 4 THEN 'Alto'
     ELSE 'Fora da Classificação'
   END AS classificacao_streams
FROM
 `my-project-laboratoria.dadoslaboratoria.view_unificada_tabela` as a
LEFT JOIN quartiles q
ON a.track_id = q.track_id AND a.streams = q.streams
