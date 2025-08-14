SELECT
min(streams),
max(streams),
avg(streams)
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido`

SELECT
min(in_spotify_playlists),
max(in_spotify_playlists),
avg(in_spotify_playlists)
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido`  

-- SELECT 
--   APPROX_QUANTILES(streams, 100) as percentis
-- FROM 
--   `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido`  

SELECT
  CASE
    WHEN streams < 10000 THEN '0-10k'
    WHEN streams < 100000 THEN '10k-100k'
    WHEN streams < 1000000 THEN '100k-1M'
    WHEN streams < 10000000 THEN '1M-10M'
    ELSE '>10M'
  END as faixa_streams,
  COUNT(*) as quantidade_musicas
FROM 
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido`
GROUP BY 1
ORDER BY 1

SELECT
streams
FROM 
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido`
WHERE streams > 10000000

SELECT
  track_name,
  artist_s__name,
  streams
FROM 
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido`
ORDER BY streams DESC
LIMIT 10