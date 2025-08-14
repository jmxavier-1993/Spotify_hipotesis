WITH artistas_separados AS (
  SELECT
    track_name,
    TRIM(artist) AS artista_individual
  FROM
    `my-project-laboratoria.dadoslaboratoria.view_unificada_tabela`,
    UNNEST(SPLIT(artist_s__name, ',')) AS artist
),

contagem_por_artista AS (
  SELECT
    artista_individual AS artist_name,
    COUNT(DISTINCT track_name) AS total_musicas_distintas
  FROM
    artistas_separados
  GROUP BY
    artista_individual
)

SELECT
  artist_name,
  total_musicas_distintas
FROM
  contagem_por_artista
ORDER BY
  total_musicas_distintas DESC