  -------nulos
SELECT
  COUNTIF(track_id IS NULL)AS track_id,
  COUNTIF(track_name IS NULL)AS track_name,
  COUNTIF(artist_s__name IS NULL)AS artist_s__name,
  COUNTIF(artist_count IS NULL)AS artist_count,
  COUNTIF(released_year IS NULL)AS released_year,
  COUNTIF(released_month IS NULL)AS released_month,
  COUNTIF(released_day IS NULL)AS released_day,
  COUNTIF(in_spotify_playlists IS NULL)AS in_spotify_playlists,
  COUNTIF(in_spotify_charts IS NULL)AS in_spotify_charts,
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify - spotify`
SELECT
  *
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify - spotify` --
WHERE
  -- track_id IS NULL
SELECT
  COUNTIF(track_id IS NULL)AS track_id,
  COUNTIF(in_apple_playlists IS NULL)AS in_apple_playlists,
  COUNTIF(in_apple_charts IS NULL)AS in_apple_charts,
  COUNTIF(in_deezer_playlists IS NULL)AS in_deezer_playlists,
  COUNTIF(in_deezer_charts IS NULL)AS in_deezer_charts,
  COUNTIF(in_shazam_charts IS NULL)AS in_shazam_charts,
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_competition_competition`
SELECT
  COUNTIF(track_id IS NULL)AS track_id,
  COUNTIF(bpm IS NULL)AS bpm,
  COUNTIF(KEY IS NULL)AS KEY,
  COUNTIF(mode IS NULL)AS mode,
  COUNTIF(danceability__ IS NULL)AS danceability__,
  COUNTIF(valence__ IS NULL)AS valence__,
  COUNTIF(energy__ IS NULL)AS energy__,
  COUNTIF(acousticness__ IS NULL)AS acousticness__,
  COUNTIF(instrumentalness__ IS NULL)AS instrumentalness__,
  COUNTIF(liveness__ IS NULL)AS liveness__,
  COUNTIF(speechiness__ IS NULL)AS speechiness__,
FROM
  `my-project-laboratoria.dadoslaboratoria.track_technical_info_technical_info` -------------Substituição dos nulos E criando VIEW da technical info
CREATE OR REPLACE VIEW
  `my-project-laboratoria.dadoslaboratoria.track_technical_info_view` AS
SELECT
  track_id,
  bpm,
  IFNULL(KEY, 'Não informado') AS KEY,
  mode,
  danceability__,
  valence__,
  energy__,
  acousticness__,
  instrumentalness__,
  liveness__,
  speechiness__
FROM
  `my-project-laboratoria.dadoslaboratoria.track_technical_info_technical_info` ---- CRIANDO VIEW DA COMPETITION
CREATE OR REPLACE VIEW
  `my-project-laboratoria.dadoslaboratoria.track_in_competition_view` AS
SELECT
  track_id,
  in_apple_playlists,
  in_apple_charts,
  in_deezer_playlists,
  in_deezer_charts,
  IFNULL(in_shazam_charts, 0) AS in_shazam_charts
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_competition_competition` --- Verificando duplicatas de track_id dentro de cada tabela ----duplicatas -- Para a tabela Trackinspotify
SELECT
  track_id,
  COUNT(*) AS quantidade
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify - spotify`
GROUP BY
  track_id
HAVING
  COUNT(*) > 1; -- Para a tabela Trackincompetition
SELECT
  track_id,
  COUNT(*) AS quantidade
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_competition_competition`
GROUP BY
  track_id
HAVING
  COUNT(*) > 1; -- Para a tabela Tracktechnicalinfo
SELECT
  track_id,
  COUNT(*) AS quantidade
FROM
  `my-project-laboratoria.dadoslaboratoria.track_technical_info_technical_info`
GROUP BY
  track_id
HAVING
  COUNT(*) > 1; ---VALORES DUPLICADOS
SELECT
  track_name,
  `artist_s__name`,
  COUNT(*) AS quantidade
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify - spotify`
GROUP BY
  track_name,
  `artist_s__name`
HAVING
  COUNT(*) > 1;
SELECT
  *
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify - spotify`
WHERE
  track_name="Take My Breath"
SELECT
  * EXCEPT(KEY,
    mode)
FROM
  `my-project-laboratoria.dadoslaboratoria.track_technical_info_technical_info` ------------- corrigindo a VIEW sem AS colunas que são fora DO escopo
CREATE OR REPLACE VIEW
  `my-project-laboratoria.dadoslaboratoria.track_technical_info` AS
SELECT
  * EXCEPT (KEY,
    mode)
FROM
  `my-project-laboratoria.dadoslaboratoria.track_technical_info_technical_info`; -- Para corrigir durante uma consulta
SELECT
  track_name,
  artist_s_name,
  REGEXP_REPLACE(artist_s_name, r'[^\x00-\x7F]', '') AS artist_s_name,
  REGEXP_REPLACE(track_name, r'[^\x00-\x7F]', '') AS track_name
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify - spotify`
SELECT
  track_name,
  artist_s__name,
  SAFE_CONVERT_BYTES_TO_STRING(CAST(artist_s__name AS BYTES)) AS artist_s__name,
  SAFE_CONVERT_BYTES_TO_STRING(CAST(track_name AS BYTES)) AS track_name
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify - spotify`

CREATE OR REPLACE VIEW `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido` AS 

SELECT
  track_id,
  REGEXP_REPLACE(track_name,r'[^\x00-\x7F]', '') AS track_name,
  REGEXP_REPLACE(artist_s__name, r'[^\x00-\x7F]', '') AS artist_s__name,
  artist_count,
  released_year,
  released_month,
  released_day,
  in_spotify_playlists,
  in_spotify_charts,
  streams
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify - spotify`

-------------------- voltei para tratar os duplicados na view de spotify, removendo as linhas da consulta  

SELECT
  track_name,
  `artist_s__name`,
  COUNT(*) AS quantidade
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido`
GROUP BY
  track_name,
  `artist_s__name`
HAVING
  COUNT(*) > 1;



CREATE OR REPLACE VIEW `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido` AS 
SELECT DISTINCT 
  track_id,
  REGEXP_REPLACE(track_name,r'[^\x00-\x7F]', '') AS track_name,
  REGEXP_REPLACE(artist_s__name, r'[^\x00-\x7F]', '') AS artist_s__name,
  artist_count,
  released_year,
  released_month,
  released_day,
  in_spotify_playlists,
  in_spotify_charts,
  streams,
  DATE(released_year, released_month, released_day) AS release_date,
  cover_url
FROM 
    `my-project-laboratoria.dadoslaboratoria.track_in_spotify - spotify`
WHERE 
    track_name IS NOT NULL 
  AND track_name != ''
  AND (track_name, artist_s__name) NOT IN (
    ('SNAP', 'Rosa Linn'),
    ('SPIT IN MY FACE!', 'ThxSoMch'),
    ('About Damn Time', 'Lizzo'),
    ('Take My Breath', 'The Weeknd')
  )
   