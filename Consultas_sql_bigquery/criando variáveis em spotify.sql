SELECT
  SAFE_CAST(streams AS INT64)
FROM
  `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido`
WHERE
  streams IS NULL

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
  DATE(released_year, released_month, released_day) AS release_date
FROM 
    `my-project-laboratoria.dadoslaboratoria.track_in_spotify - spotify`
WHERE 
    (track_name, artist_s__name) NOT IN (
        ('SNAP', 'Rosa Linn'),
        ('SPIT IN MY FACE!', 'ThxSoMch'),
        ('About Damn Time', 'Lizzo'),
        ('Take My Breath', 'The Weeknd')
    ) 
