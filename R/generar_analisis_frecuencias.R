#' Funcion para generar analisis visual de frecuencias y diversidad lexica
#'
#' Esta funcion genera una nube de palabras, un grafico de barras de las 20 palabras mas frecuentes,
#' y graficos de los 20 bigramas y trigramas mas frecuentes.
#'
#' @param corpus_literario Un objeto de tipo lista generado por la funcion `crear_corpus_literario`.
#' @param stopwords_extra Vector opcional de palabras adicionales a considerar como stopwords.
#'
#' @return Una lista con los graficos generados.
#'
#' @examples
#' generar_analisis_frecuencias(corpus_literario)
#'
#' @export
generar_analisis_frecuencias <- function(corpus_literario, stopwords_extra = NULL) {
  # Extraer las frecuencias desde el corpus_literario
  corpus <- corpus_literario$corpus
  frecuencias <- corpus_literario$frecuencias
  frecuencias_bigramas <- corpus_literario$frecuencias_bigramas
  frecuencias_trigramas <- corpus_literario$frecuencias_trigramas
  stopwords <- corpus_literario$stopwords

  # Unificar las stopwords del corpus y las extra que se pasan como parametro
  if (!is.null(stopwords_extra)) {
    stopwords <- union(stopwords, stopwords_extra)
  }

  # Filtrar las frecuencias para eliminar las stopwords
  frecuencias <- frecuencias[!frecuencias$feature %in% stopwords, ]

  # 1. Nube de palabras
  wordcloud::wordcloud(
    words = frecuencias$feature,
    freq = frecuencias$frequency,
    min.freq = 3,  # Palabras con frecuencia minima
    max.words = 200,  # Numero maximo de palabras
    scale = c(3, 0.5),  # Tamano de las palabras
    colors = RColorBrewer::brewer.pal(8, "Dark2"),  # Paleta de colores
    random.order = FALSE  # Las palabras mas frecuentes en el centro
  )

  # 2. Grafico de barras de las 20 palabras mas frecuentes
  top_20_frecuencias <- frecuencias[1:20, ]
  plot_1 <- ggplot2::ggplot(top_20_frecuencias,
                            ggplot2::aes(x = reorder(feature, -frequency), y = frequency)) +
    ggplot2::geom_bar(stat = "identity", fill = "steelblue") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
    ggplot2::xlab("Terminos") + ggplot2::ylab("Frecuencia") +
    ggplot2::ggtitle("Top 20 terminos mas frecuentes")

  print(plot_1)  # Asegurarse de que el grafico se muestre

  # 3. Grafico de los 20 bigramas mas frecuentes
  top_20_frecuencias_bigramas <- frecuencias_bigramas[1:20, ]
  plot_2 <- ggplot2::ggplot(top_20_frecuencias_bigramas,
                            ggplot2::aes(x = reorder(feature, -frequency), y = frequency)) +
    ggplot2::geom_bar(stat = "identity", fill = "steelblue") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
    ggplot2::xlab("Terminos") + ggplot2::ylab("Frecuencia") +
    ggplot2::ggtitle("Top 20 bigramas mas frecuentes")

  print(plot_2)  # Asegurarse de que el grafico se muestre

  # 4. Grafico de los 20 trigramas mas frecuentes
  top_20_frecuencias_trigramas <- frecuencias_trigramas[1:20, ]
  plot_3 <- ggplot2::ggplot(top_20_frecuencias_trigramas,
                            ggplot2::aes(x = reorder(feature, -frequency), y = frequency)) +
    ggplot2::geom_bar(stat = "identity", fill = "steelblue") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
    ggplot2::xlab("Terminos") + ggplot2::ylab("Frecuencia") +
    ggplot2::ggtitle("Top 20 trigramas mas frecuentes")

  print(plot_3)  # Asegurarse de que el grafico se muestre


  # Podemos ordenar los ngramas por la cantidad de canciones en las que aparecen
  frecuencias_bigramas <- frecuencias_bigramas %>%
    dplyr::arrange(desc(docfreq))
  frecuencias_trigramas <- frecuencias_trigramas %>%
    dplyr::arrange(desc(docfreq))

  # 5. Grafico de los 20 bigramas mas frecuentes
  top_20_frecuencias_bigramas <- frecuencias_bigramas[1:20, ]
  plot_4 <- ggplot2::ggplot(top_20_frecuencias_bigramas,
                            ggplot2::aes(x = reorder(feature, -frequency), y = frequency)) +
    ggplot2::geom_bar(stat = "identity", fill = "steelblue") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
    ggplot2::xlab("Terminos") + ggplot2::ylab("Documentos en que el bigrama aparece") +
    ggplot2::ggtitle("20 bigramas que aparecen en mayor cantidad de documentos")

  print(plot_4)  # Asegurarse de que el grafico se muestre

  # 6. Grafico de los 20 trigramas mas frecuentes
  top_20_frecuencias_trigramas <- frecuencias_trigramas[1:20, ]
  plot_5 <- ggplot2::ggplot(top_20_frecuencias_trigramas,
                            ggplot2::aes(x = reorder(feature, -frequency), y = frequency)) +
    ggplot2::geom_bar(stat = "identity", fill = "steelblue") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
    ggplot2::xlab("Terminos") + ggplot2::ylab("Documentos en que el trigrama aparece") +
    ggplot2::ggtitle("20 trigramas que aparecen en mayor cantidad de documentos")

  print(plot_5)  # Asegurarse de que el grafico se muestre

}
