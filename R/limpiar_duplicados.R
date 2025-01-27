#' Limpiar duplicados en un conjunto de datos
#'
#' Esta funcion elimina duplicados en un conjunto de datos, priorizando las entradas
#' segun la existencia de letras sincronizadas o letras planas, y asegurandose
#' de conservar la entrada mas relevante por grupo. Adicionalmente, permite eliminar
#' canciones con ciertos patrones no deseados como "feat.", "live", "acoustic", etc.
#'
#' @param data Un data frame que contiene al menos una columna llamada `name_lower`,
#'   que se utiliza para identificar duplicados, y las columnas `has_synced_lyrics`
#'   y `has_plain_lyrics` para determinar la prioridad.
#' @param eliminar_otros Un valor booleano que indica si se deben eliminar canciones
#'   con patrones no deseados (por defecto es TRUE).
#'
#' @return Un data frame sin duplicados, donde se conserva solo la entrada con
#'   la mayor prioridad dentro de cada grupo identificado por `name_lower`.
#'
#' @details
#' La funcion ordena el conjunto de datos para priorizar las canciones con letras
#' sincronizadas (`has_synced_lyrics`) y, en segundo lugar, las que tienen letras
#' planas (`has_plain_lyrics`). Posteriormente, agrupa los datos por la columna
#' `name_lower` y mantiene unicamente la primera entrada en orden de prioridad.
#' Si `eliminar_otros` es TRUE, se eliminan registros que contengan patrones como
#' "feat.", "live", "acoustic", "Remix", entre otros.
#'
#' @examples
#' resultados <- buscar_por_artista("Alex Anwandter")
#' limpiar_duplicados(resultados, eliminar_otros = TRUE)
#'
#' @export
limpiar_duplicados <- function(data, eliminar_otros = TRUE) {
  # Copiar la bd original para no modificarla directamente
  data_c <- data

  # Asegurar que 'name' esté en minusculas para facilitar el patrón de búsqueda
  data_c <- data_c %>%
    dplyr::mutate(name = tolower(name))

  # Si eliminar_otros es TRUE, eliminar canciones con patrones no deseados
  if (eliminar_otros) {
    # Arreglar el patrón para que sea más robusto y case insensitive
    patrones <- "(feat\\.|ft\\.|\\(feat\\.|\\(en vivo\\)|\\(acoustic\\)|\\(acustico\\)|remix|deluxe|remaster)"

    # Eliminar las filas donde 'name' contiene alguno de esos patrones
    data_c <- data_c[!stringr::str_detect(data_c$name, patrones), ]
  }

  # Normalizar la columna 'name' usando la función nrmlztxt
  data_c <- data_c %>%
    dplyr::mutate(name = nrmlztxt(name))

  # Ordenar el conjunto de datos para priorizar las canciones con letras sincronizadas
  data_c <- data_c %>%
    dplyr::arrange(desc(has_synced_lyrics), desc(has_plain_lyrics))

  # Detectar duplicados y mantener solo la primera canción por grupo de 'name'
  data_c <- data_c %>%
    dplyr::distinct(name, .keep_all = TRUE)

  # Obtener los 'track_id' de las filas eliminadas en data_c
  track_ids_eliminados <- setdiff(data$track_id, data_c$track_id)

  # Eliminar las filas correspondientes en el dataframe original 'data'
  data <- data[!data$track_id %in% track_ids_eliminados, ]

  # Ordenar 'data' alfabéticamente por 'name_lower'
  data <- data %>%
    dplyr::arrange(name_lower)

  return(data)
}
