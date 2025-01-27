buscar_ngramas <- function(corpus_literario, n, ngramas) {
  # Seleccionar la matriz correspondiente
  if (n == 2) {
    dtm <- corpus_literario$dtm_bigramas
  } else if (n == 3) {
    dtm <- corpus_literario$dtm_trigramas
  } else {
    stop("El parámetro 'n' debe ser 2 (bigramas) o 3 (trigramas).")
  }

  # Dataframe original
  corpus_df <- corpus_literario$corpus_df

  # Dataframe de resultados
  resultados <- data.frame(
    name = character(),
    artist_name = character(),
    album_name = character(),
    plain_lyrics = character(),
    ngrama = character(),
    stringsAsFactors = FALSE
  )

  # Iterar sobre los n-gramas
  for (ngrama in ngramas) {
    # Comprobar si el n-grama está en las características
    if (!(ngrama %in% colnames(dtm))) {
      message(paste("El n-grama", ngrama, "no está presente en el dtm."))
      next
    }

    # Encontrar las filas donde aparece el n-grama
    filas <- which(quanteda::convert(dtm[, ngrama], to = "matrix") > 0)

    # Extraer las canciones correspondientes
    if (length(filas) > 0) {
      canciones <- corpus_df[filas, ]
      canciones$ngrama <- ngrama

      # Agregar al dataframe de resultados
      resultados <- rbind(resultados, canciones[, c("name", "artist_name", "album_name", "plain_lyrics", "ngrama")])
    }
  }

  return(resultados)
}
