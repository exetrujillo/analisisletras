#' Filtrar canciones según la emoción predominante
#'
#' Esta función filtra las canciones en un DataFrame según las emociones predominantes,
#' excluyendo aquellas con una emoción "neutral" mayor o igual al porcentaje mínimo
#' especificado (si incluir_neutral es FALSE). Si incluir_neutral es TRUE, se incluyen
#' las canciones con "neutral" mayor o igual a `porc_min`.
#'
#' @param df_emociones DataFrame con las columnas de emociones y letras de las canciones.
#' @param porc_min Valor mínimo (en porcentaje) para que una emoción sea considerada predominante. Default es 51.
#' @param incluir_neutral Lógico. Si TRUE, incluye canciones con "neutral" >= porc_min. Default es FALSE.
#'
#' @return Un DataFrame con las canciones filtradas, incluyendo la columna de la emoción predominante y el porcentaje de la emoción.
#' @export
filtrar_emociones <- function(df_emociones, porc_min = 51, incluir_neutral = FALSE) {
  # Crear una lista de emociones en el orden que deseas
  emociones_ordenadas <- c("joy", "surprise", "sadness", "fear", "disgust", "anger", "neutral")

  # Verificar si las columnas de emociones existen en df_emociones
  if (!all(emociones_ordenadas %in% colnames(df_emociones))) {
    stop("Las columnas de emociones no existen en el DataFrame.")
  }

  # Crear una nueva columna 'emocion_predom' con la emoción predominante en cada fila
  df_emociones$emocion_predom <- apply(df_emociones[emociones_ordenadas], 1, function(row) {
    # Obtener la emoción con el valor más alto
    names(row)[which.max(row)]
  })

  # Agregar la columna 'porc_emocion_predom' con el porcentaje de la emoción predominante
  df_emociones$porc_emocion_predom <- apply(df_emociones[emociones_ordenadas], 1, function(row) {
    max(row)  # El valor máximo de la fila es el porcentaje de la emoción predominante
  })

  # Filtrar filas donde alguna emoción es mayor que porc_min
  if (incluir_neutral) {
    # Si incluir_neutral es TRUE, no eliminamos canciones con neutral >= porc_min
    df_filtrado <- df_emociones[rowSums(df_emociones[emociones_ordenadas] >= porc_min) > 0, ]
  } else {
    # Si incluir_neutral es FALSE, eliminamos canciones donde neutral >= porc_min
    df_filtrado <- df_emociones[rowSums(df_emociones[emociones_ordenadas] >= porc_min) > 0 & df_emociones$neutral < porc_min, ]
  }

  # Asegurarse de que las columnas de emociones estén presentes después de las filtraciones
  df_filtrado <- df_filtrado[, c("track_id", "name_lower", "artist_name_lower", "album_name_lower",
                                 "plain_lyrics", "plain_lyrics_en", "estrofas", "emocion_predom", "porc_emocion_predom", emociones_ordenadas)]

  # Ordenar primero por la emoción predominante usando un factor con el orden deseado
  df_filtrado$emocion_predom <- factor(df_filtrado$emocion_predom, levels = emociones_ordenadas)

  # Luego ordenar por el porcentaje de la emoción predominante
  df_filtrado <- df_filtrado[order(df_filtrado$emocion_predom, -df_filtrado$porc_emocion_predom), ]

  return(df_filtrado)
}
