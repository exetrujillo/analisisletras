#' Buscar canciones por nombre de artista
#'
#' Esta funcion permite buscar las canciones de un artista en la base de datos, realizando una busqueda flexible sobre
#' el nombre del artista, despues de normalizarlo. Utiliza una consulta SQL con un `LIKE` para encontrar coincidencias en
#' el campo `artist_name_lower` de la base de datos.
#'
#' @param nombre_artista Un texto (de tipo `character`) con el nombre del artista a buscar.
#' @return Un dataframe con los resultados de la consulta, que contiene informacion sobre las canciones y sus letras.
#'         El dataframe incluye los campos `track_id`, `name`, `name_lower`, `artist_name`, `artist_name_lower`,
#'         `album_name`, `album_name_lower`, `duration`, `updated_at`, `lyrics_id`, `plain_lyrics`, `synced_lyrics`,
#'         `has_plain_lyrics`, `has_synced_lyrics`, e `instrumental`.
#' @export
#'
#' @examples
#' resultados <- buscar_por_artista("Las Olas (NoisPop))
#' print(resultados)
buscar_por_artista <- function(nombre_artista) {
  # Normalizar el nombre del artista
  nombre_artista_nrm <- nrmlztxt(nombre_artista)

  # Conectamos a la base de datos
  conexion <- conectar_bd()

  # Proteger el nombre para consultas SQL
  nombre_artista_quoted <- DBI::dbQuoteString(conexion, nombre_artista_nrm)

  # Consulta SQL con LIKE (busqueda flexible) y campo normalizado en la base de datos
  query <- paste0("
    SELECT
      t.id AS track_id, t.name, t.name_lower, t.artist_name, t.artist_name_lower,
      t.album_name, t.album_name_lower, t.duration, t.updated_at,
      l.id AS lyrics_id, l.plain_lyrics, l.synced_lyrics, l.has_plain_lyrics,
      l.has_synced_lyrics, l.instrumental
    FROM tracks t
    LEFT JOIN lyrics l ON t.last_lyrics_id = l.id
    WHERE t.artist_name_lower LIKE ", nombre_artista_quoted
  )

  # Ejecutar la consulta
  data <- DBI::dbGetQuery(conexion, query)

  # Desconectamos la base de datos
  desconectar_bd(conexion)

  # Retornar los datos
  return(data)
}
