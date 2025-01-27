#' Eliminar filas instrumentales y con letras faltantes o muy cortas
#'
#' Esta función elimina filas de un dataset que cumplen alguna de las siguientes condiciones:
#' - La columna `lyrics_id` tiene valores NA.
#' - La columna `instrumental` tiene el valor 1.
#' - La longitud de la columna `plain_lyrics` es menor o igual al umbral especificado.
#'
#' @param datos Un data frame con las columnas `lyrics_id`, `instrumental` y `plain_lyrics`.
#' @param umbral Un valor numérico que define la longitud mínima permitida para la columna `plain_lyrics`.
#'   Las filas con una longitud menor o igual a este valor serán eliminadas. Por defecto es 20.
#'
#' @return Un data frame limpio, sin las filas que cumplen alguna de las condiciones.
#'
#' @examples
#' df_limpio <- eliminar_instrumentales(df, umbral = 20)
#'
#' @export
eliminar_instrumentales <- function(datos, umbral = 20) {
  # Verificar que las columnas necesarias estén presentes
  columnas_necesarias <- c("lyrics_id", "instrumental", "plain_lyrics")
  if (!all(columnas_necesarias %in% colnames(datos))) {
    stop("El dataframe debe contener las columnas: ", paste(columnas_necesarias, collapse = ", "))
  }

  # Filtrar filas que cumplen con las condiciones
  datos_limpios <- datos[
    datos$instrumental != 1 &                        # No es instrumental
      !is.na(datos$lyrics_id) &                     # No tiene lyrics_id faltante
      nchar(datos$plain_lyrics) > umbral,           # La longitud de plain_lyrics supera el umbral
  ]

  return(datos_limpios)
}
