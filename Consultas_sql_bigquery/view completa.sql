CREATE OR REPLACE VIEW `dadoslaboratoria.view_unificada_com_quartis` AS
WITH dados_completos AS (
  SELECT 
    -- Colunas da track_in_spotify - spotify
    spot.track_id,
    spot.track_name,
    spot.artist_s__name,
    spot.artist_count,
    spot.released_year,
    spot.released_month,
    spot.released_day,
    spot.in_spotify_playlists,
    spot.in_spotify_charts,
    spot.streams,
    spot.release_date,
    spot.cover_url,
    
    -- Colunas da track_in_competition_competition
    comp.in_apple_playlists,
    comp.in_apple_charts,
    comp.in_deezer_playlists,
    comp.in_deezer_charts,
    comp.in_shazam_charts,
    
    -- Colunas da track_technical_info
    tech.bpm,
    tech.danceability__,
    tech.valence__,
    tech.energy__,
    tech.acousticness__,
    tech.instrumentalness__,
    tech.liveness__,
    tech.speechiness__
    
  FROM 
    `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido` spot
  LEFT JOIN 
    `my-project-laboratoria.dadoslaboratoria.track_in_competition_view` comp
    ON spot.track_id = comp.track_id
  LEFT JOIN 
    `my-project-laboratoria.dadoslaboratoria.track_technical_info` tech
    ON comp.track_id = tech.track_id
),

quartis_calculados AS (
  SELECT
    track_id,
    streams,
    danceability__,
    valence__,
    energy__,
    acousticness__,
    instrumentalness__,
    liveness__,
    speechiness__,
    -- Cálculo dos quartis para cada métrica
    NTILE(4) OVER (ORDER BY streams) AS quartil_streams,
    NTILE(4) OVER (ORDER BY danceability__) AS quartil_danceability,
    NTILE(4) OVER (ORDER BY valence__) AS quartil_valence,
    NTILE(4) OVER (ORDER BY energy__) AS quartil_energy,
    NTILE(4) OVER (ORDER BY acousticness__) AS quartil_acousticness,
    NTILE(4) OVER (ORDER BY instrumentalness__) AS quartil_instrumentalness,
    NTILE(4) OVER (ORDER BY liveness__) AS quartil_liveness,
    NTILE(4) OVER (ORDER BY speechiness__) AS quartil_speechiness
  FROM
    dados_completos
)

SELECT
  d.*,
  -- Quartis numéricos
  q.quartil_streams,
  q.quartil_danceability,
  q.quartil_valence,
  q.quartil_energy,
  q.quartil_acousticness,
  q.quartil_instrumentalness,
  q.quartil_liveness,
  q.quartil_speechiness,
  
  -- Classificações por quartil para streams
  CASE
    WHEN q.quartil_streams = 1 THEN 'Baixo'
    WHEN q.quartil_streams = 2 THEN 'Médio-Baixo'
    WHEN q.quartil_streams = 3 THEN 'Médio-Alto'
    WHEN q.quartil_streams = 4 THEN 'Alto'
    ELSE 'Fora da Classificação'
  END AS classificacao_streams,
  
  -- Classificações por quartil para danceability
  CASE
    WHEN q.quartil_danceability = 1 THEN 'Baixo'
    WHEN q.quartil_danceability = 2 THEN 'Médio-Baixo'
    WHEN q.quartil_danceability = 3 THEN 'Médio-Alto'
    WHEN q.quartil_danceability = 4 THEN 'Alto'
    ELSE 'Fora da Classificação'
  END AS classificacao_danceability,
  
  -- Classificações por quartil para valence
  CASE
    WHEN q.quartil_valence = 1 THEN 'Baixo'
    WHEN q.quartil_valence = 2 THEN 'Médio-Baixo'
    WHEN q.quartil_valence = 3 THEN 'Médio-Alto'
    WHEN q.quartil_valence = 4 THEN 'Alto'
    ELSE 'Fora da Classificação'
  END AS classificacao_valence,
  
  -- Classificações por quartil para energy
  CASE
    WHEN q.quartil_energy = 1 THEN 'Baixo'
    WHEN q.quartil_energy = 2 THEN 'Médio-Baixo'
    WHEN q.quartil_energy = 3 THEN 'Médio-Alto'
    WHEN q.quartil_energy = 4 THEN 'Alto'
    ELSE 'Fora da Classificação'
  END AS classificacao_energy,
  
  -- Classificações por quartil para acousticness
  CASE
    WHEN q.quartil_acousticness = 1 THEN 'Baixo'
    WHEN q.quartil_acousticness = 2 THEN 'Médio-Baixo'
    WHEN q.quartil_acousticness = 3 THEN 'Médio-Alto'
    WHEN q.quartil_acousticness = 4 THEN 'Alto'
    ELSE 'Fora da Classificação'
  END AS classificacao_acousticness,
  
  -- Classificações por quartil para instrumentalness
  CASE
    WHEN q.quartil_instrumentalness = 1 THEN 'Baixo'
    WHEN q.quartil_instrumentalness = 2 THEN 'Médio-Baixo'
    WHEN q.quartil_instrumentalness = 3 THEN 'Médio-Alto'
    WHEN q.quartil_instrumentalness = 4 THEN 'Alto'
    ELSE 'Fora da Classificação'
  END AS classificacao_instrumentalness,
  
  -- Classificações por quartil para liveness
  CASE
    WHEN q.quartil_liveness = 1 THEN 'Baixo'
    WHEN q.quartil_liveness = 2 THEN 'Médio-Baixo'
    WHEN q.quartil_liveness = 3 THEN 'Médio-Alto'
    WHEN q.quartil_liveness = 4 THEN 'Alto'
    ELSE 'Fora da Classificação'
  END AS classificacao_liveness,
  
  -- Classificações por quartil para speechiness
  CASE
    WHEN q.quartil_speechiness = 1 THEN 'Baixo'
    WHEN q.quartil_speechiness = 2 THEN 'Médio-Baixo'
    WHEN q.quartil_speechiness = 3 THEN 'Médio-Alto'
    WHEN q.quartil_speechiness = 4 THEN 'Alto'
    ELSE 'Fora da Classificação'
  END AS classificacao_speechiness
  
FROM
  dados_completos d
LEFT JOIN
  quartis_calculados q
ON
  d.track_id = q.track_id;