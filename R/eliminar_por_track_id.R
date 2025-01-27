#' Eliminar filas segun track_id
#'
#' Esta funcion elimina filas de un conjunto de datos basandose en un listado de valores de la columna `track_id`.
#'
#' @param data Un data frame que contiene al menos una columna llamada `track_id`.
#' @param listado Un vector de caracteres con los `track_id` que se desean eliminar del data frame.
#'
#' @return Un data frame sin las filas cuyos `track_id` esten presentes en el vector `listado`.
#'
#' @examples
#' data_filtrado <- eliminar_por_track_id(data, listado = c("track1", "track2"))
#'
#' @export
eliminar_por_track_id <- function(data, listado = c()) {
  # Validar que 'track_id' exista en el data frame
  if (!"track_id" %in% colnames(data)) {
    stop("La columna 'track_id' no existe en el data frame.")
  }

  # Filtrar las filas eliminando las que tienen 'track_id' en el listado
  data <- data[!data$track_id %in% listado, ]

  return(data)
}
