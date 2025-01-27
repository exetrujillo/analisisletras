#' Crear un corpus de bandas
#'
#' Esta funcion crea un corpus a partir de una lista de bandas, recopilando y procesando las canciones de cada banda.
#' El corpus resultante incluye informacion como titulos de canciones, artistas, albumes y letras.
#'
#' @param lista_bandas Un vector de cadenas que contiene los nombres de las bandas o artistas a procesar.
#'
#' @return Un \code{data.frame} con las siguientes columnas:
#' \describe{
#'   \item{track_id}{Identificador unico de la cancion.}
#'   \item{name}{Nombre de la cancion.}
#'   \item{name_lower}{Nombre de la cancion en minusculas.}
#'   \item{artist_name}{Nombre del artista o banda.}
#'   \item{artist_name_lower}{Nombre del artista o banda en minusculas.}
#'   \item{album_name}{Nombre del album.}
#'   \item{album_name_lower}{Nombre del album en minusculas.}
#'   \item{duration}{Duracion de la cancion (en segundos).}
#'   \item{updated_at}{Fecha de la ultima actualizacion de la informacion.}
#'   \item{lyrics_id}{Identificador unico de las letras.}
#'   \item{plain_lyrics}{Letras en formato plano.}
#'   \item{synced_lyrics}{Letras sincronizadas con la musica.}
#'   \item{has_plain_lyrics}{Indicador binario (\code{1}/\code{0}) que senala si existen letras planas.}
#'   \item{has_synced_lyrics}{Indicador binario (\code{1}/\code{0}) que senala si existen letras sincronizadas.}
#'   \item{instrumental}{Indicador binario (\code{1}/\code{0}) que senala si la cancion es instrumental.}
#' }
#'
#' @details La funcion utiliza la funcion \code{buscar_por_artista()} para obtener las canciones de cada banda o artista,
#' y la funcion \code{limpiar_duplicados()} para asegurarse de que no haya canciones duplicadas en el corpus final.
#'
#' Si no se encuentran datos para una banda o artista, la funcion omite esa entrada y continua con el siguiente.
#'
#' @examples
#' # Crear un corpus a partir de una lista de bandas
#' lista_bandas <- c("The Beatles", "Queen", "Pink Floyd")
#' corpus <- crear_corpus_de_bandas(lista_bandas)
#'
#' @export
crear_corpus_de_bandas <- function(lista_bandas) {
  # Inicializar un dataframe vacío
  corpus_data <- data.frame(
    track_id = integer(),
    name = character(),
    name_lower = character(),
    artist_name = character(),
    artist_name_lower = character(),
    album_name = character(),
    album_name_lower = character(),
    duration = double(),
    updated_at = character(),
    lyrics_id = integer(),
    plain_lyrics = character(),
    synced_lyrics = character(),
    has_plain_lyrics = integer(),
    has_synced_lyrics = integer(),
    instrumental = integer(),
    stringsAsFactors = FALSE
  )

  # Recorrer la lista de bandas
  for (artista in lista_bandas) {
    # Obtener canciones del artista
    df_artista <- buscar_por_artista(artista)
    cat("Buscando datos para el artista:", artista, "\n")

    if (is.null(df_artista) || nrow(df_artista) == 0) {
      cat("No se encontraron datos para el artista:", artista, "\n")
      next
    }

    # Limpiar duplicados
    df_artista <- limpiar_duplicados(df_artista)

    # Agregar al corpus
    corpus_data <- dplyr::bind_rows(corpus_data, df_artista %>%
                               dplyr::select(
                                 track_id,
                                 name,
                                 name_lower,
                                 artist_name,
                                 artist_name_lower,
                                 album_name,
                                 album_name_lower,
                                 duration,
                                 updated_at,
                                 lyrics_id,
                                 plain_lyrics,
                                 synced_lyrics,
                                 has_plain_lyrics,
                                 has_synced_lyrics,
                                 instrumental
                               ))
  }

  return(corpus_data)
}
