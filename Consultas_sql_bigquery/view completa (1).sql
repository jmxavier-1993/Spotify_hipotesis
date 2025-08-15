CREATE OR REPLACE VIEW `dadoslaboratoria.view_unificada_com_quartis` AS
WITH dados_unificados AS (
  -- 1. Unifica as três tabelas em uma base única
  SELECT 
    -- Colunas da track_in_spotify
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
    
    -- Colunas da track_in_competition
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
    `my-project-laboratoria.dadoslaboratoria.track_in_spotify_corrigido` AS spot
  LEFT JOIN 
    `my-project-laboratoria.dadoslaboratoria.track_in_competition_view` AS comp
    ON spot.track_id = comp.track_id
  LEFT JOIN 
    `my-project-laboratoria.dadoslaboratoria.track_technical_info` AS tech
    -- CORREÇÃO: A junção deve ser feita com a tabela principal (spot) para garantir a consistência dos dados
    ON spot.track_id = tech.track_id
),

dados_com_quartis AS (
  -- 2. Calcula os quartis sobre a base unificada
  SELECT
    *, -- Seleciona todas as colunas da etapa anterior
    NTILE(4) OVER (ORDER BY streams) AS quartil_streams,
    NTILE(4) OVER (ORDER BY bpm) AS quartil_bpm,
    NTILE(4) OVER (ORDER BY danceability__) AS quartil_danceability,
    NTILE(4) OVER (ORDER BY valence__) AS quartil_valence,
    NTILE(4) OVER (ORDER BY energy__) AS quartil_energy,
    NTILE(4) OVER (ORDER BY acousticness__) AS quartil_acousticness,
    NTILE(4) OVER (ORDER BY instrumentalness__) AS quartil_instrumentalness,
    NTILE(4) OVER (ORDER BY liveness__) AS quartil_liveness,
    NTILE(4) OVER (ORDER BY speechiness__) AS quartil_speechiness
  FROM
    dados_unificados
)

-- 3. Seleciona todos os dados e adiciona as classificações textuais
SELECT
  *,
  CASE
    WHEN quartil_bpm = 1 THEN 'Baixo'
    WHEN quartil_bpm = 2 THEN 'Médio-Baixo'
    WHEN quartil_bpm = 3 THEN 'Médio-Alto'
    WHEN quartil_bpm = 4 THEN 'Alto'
  END AS classificacao_bpm,
  
  CASE
    WHEN quartil_streams = 1 THEN 'Baixo'
    WHEN quartil_streams = 2 THEN 'Médio-Baixo'
    WHEN quartil_streams = 3 THEN 'Médio-Alto'
    WHEN quartil_streams = 4 THEN 'Alto'
  END AS classificacao_streams,
  
  CASE
    WHEN quartil_danceability = 1 THEN 'Baixo'
    WHEN quartil_danceability = 2 THEN 'Médio-Baixo'
    WHEN quartil_danceability = 3 THEN 'Médio-Alto'
    WHEN quartil_danceability = 4 THEN 'Alto'
  END AS classificacao_danceability,
  
  CASE
    WHEN quartil_valence = 1 THEN 'Baixo'
    WHEN quartil_valence = 2 THEN 'Médio-Baixo'
    WHEN quartil_valence = 3 THEN 'Médio-Alto'
    WHEN quartil_valence = 4 THEN 'Alto'
  END AS classificacao_valence,
  
  CASE
    WHEN quartil_energy = 1 THEN 'Baixo'
    WHEN quartil_energy = 2 THEN 'Médio-Baixo'
    WHEN quartil_energy = 3 THEN 'Médio-Alto'
    WHEN quartil_energy = 4 THEN 'Alto'
  END AS classificacao_energy,
  
  CASE
    WHEN quartil_acousticness = 1 THEN 'Baixo'
    WHEN quartil_acousticness = 2 THEN 'Médio-Baixo'
    WHEN quartil_acousticness = 3 THEN 'Médio-Alto'
    WHEN quartil_acousticness = 4 THEN 'Alto'
  END AS classificacao_acousticness,
  
  CASE
    WHEN quartil_instrumentalness = 1 THEN 'Baixo'
    WHEN quartil_instrumentalness = 2 THEN 'Médio-Baixo'
    WHEN quartil_instrumentalness = 3 THEN 'Médio-Alto'
    WHEN quartil_instrumentalness = 4 THEN 'Alto'
  END AS classificacao_instrumentalness,
  
  CASE
    WHEN quartil_liveness = 1 THEN 'Baixo'
    WHEN quartil_liveness = 2 THEN 'Médio-Baixo'
    WHEN quartil_liveness = 3 THEN 'Médio-Alto'
    WHEN quartil_liveness = 4 THEN 'Alto'
  END AS classificacao_liveness,
  
  CASE
    WHEN quartil_speechiness = 1 THEN 'Baixo'
    WHEN quartil_speechiness = 2 THEN 'Médio-Baixo'
    WHEN quartil_speechiness = 3 THEN 'Médio-Alto'
    WHEN quartil_speechiness = 4 THEN 'Alto'
  END AS classificacao_speechiness
FROM
  dados_com_quartis;