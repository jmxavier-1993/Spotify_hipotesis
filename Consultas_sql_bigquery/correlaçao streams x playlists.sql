SELECT
  CORR(streams, in_apple_playlists) AS apple_corr,
  CORR(streams, in_deezer_playlists) AS deezer_corr,
  CORR(streams, in_spotify_playlists) AS spotify_corr
FROM
  `my-project-laboratoria.dadoslaboratoria.view_unificada_tabela`
LIMIT
  1000

SELECT
  CORR(streams, (in_apple_playlists + in_deezer_playlists + in_spotify_playlists)) AS correlation
FROM
  `my-project-laboratoria.dadoslaboratoria.view_unificada_tabela`
LIMIT
  1000  