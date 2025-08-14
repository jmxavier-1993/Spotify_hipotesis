WITH dados_artistas AS (
  SELECT
    TRIM(artist) AS artista,
    SUM(in_apple_playlists + in_deezer_playlists + in_spotify_playlists) AS total_playlists_artista
  FROM
    `my-project-laboratoria.dadoslaboratoria.view_unificada_tabela`,
    UNNEST(SPLIT(artist_s__name, ',')) AS artist
  GROUP BY TRIM(artist)
)

SELECT
  t.track_id,
  t.track_name,
  TRIM(a) AS artista_individual,
  d.total_playlists_artista AS total_por_artista
FROM
  `my-project-laboratoria.dadoslaboratoria.view_unificada_tabela` t,
  UNNEST(SPLIT(t.artist_s__name, ',')) AS a
LEFT JOIN dados_artistas d ON TRIM(a) = d.artista
GROUP BY
  t.track_id,
  t.track_name,
  TRIM(a),
  d.total_playlists_artista
