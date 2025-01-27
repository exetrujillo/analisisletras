#' Crear un corpus con las letras, tokenizar texto, generar DTM y calcular frecuencias de n-gramas
#'
#' Esta funcion crea un objeto de tipo corpus a partir de un dataframe, tokeniza el texto,
#' genera la matriz de documento-termino (DTM) y calcula las frecuencias de terminos,
#' bigramas y trigramas.
#'
#' @param dataframe Un dataframe que contiene las letras o textos en una columna llamada `plain_lyrics`.
#' @param stopwords_extra Un vector opcional de palabras adicionales que se deben considerar como stopwords.
#' @param bigrama_stopwords Logico. Si es `TRUE`, excluye las stopwords al calcular las frecuencias de bigramas.
#' @param trigrama_stopwords Logico. Si es `TRUE`, excluye las stopwords al calcular las frecuencias de trigramas.
#'
#' @return Una lista con los siguientes elementos:
#' \itemize{
#'   \item `corpus_df`: El dataframe original con las letras.
#'   \item `corpus`: El objeto corpus creado.
#'   \item `tokens`: Los tokens generados a partir del corpus.
#'   \item `stopwords`: La lista combinada de stopwords utilizadas.
#'   \item `dtm`: La matriz de documento-termino generada a partir de los tokens.
#'   \item `dtm_bigramas`: La matriz de documento-termino generada para los bigramas.
#'   \item `dtm_trigramas`: La matriz de documento-termino generada para los trigramas.
#'   \item `frecuencias`: Un dataframe con las frecuencias de los terminos.
#'   \item `frecuencias_bigramas`: Un dataframe con las frecuencias de los bigramas.
#'   \item `frecuencias_trigramas`: Un dataframe con las frecuencias de los trigramas.
#' }
#'
#' @examples
#' dataframe <- data.frame(plain_lyrics = c("Esta es una cancion", "Otra letra de prueba"))
#' resultado <- crear_corpus_literario(dataframe, stopwords_extra = c("oh", "yeah"), bigrama_stopwords = TRUE)
#'
#' @export
crear_corpus_literario <- function(dataframe,
                                   stopwords_extra = NULL,
                                   bigrama_stopwords = TRUE,
                                   trigrama_stopwords = FALSE
                                   ){

  # Crear el corpus desde la columna especificada
  corpus <- quanteda::corpus(dataframe$plain_lyrics)

  # Convertir todo el texto a minusculas
  corpus <- quanteda::corpus(tolower(as.character(corpus)))

  # Crear lista de stopwords (incluyendo palabras adicionales)
  stopwords_combinadas <- union(stopwords::stopwords("es"), stopwords_extra)
  stopwords_combinadas <- union(stopwords::stopwords("en"), stopwords_combinadas)

  # Tokenizacion
  tokens <- quanteda::tokens(
    corpus,
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = TRUE,
    remove_url = TRUE,
    what = "word"
  )

  dtm <- quanteda::dfm(tokens)

  # Calcular las frecuencias de los terminos
  frecuencias <- quanteda.textstats::textstat_frequency(dtm)

  # Calcular frecuencias de bigramas y trigramas usando la funcion auxiliar
  bigramas <- calcular_ngramas(tokens, n = 2, stopwords_combinadas, ngrama_stopwords = bigrama_stopwords)
  trigramas <- calcular_ngramas(tokens, n = 3, stopwords_combinadas, ngrama_stopwords = trigrama_stopwords)

  #Sacarlos al dataframe

  return(list(
    corpus_df = dataframe,
    corpus = corpus,
    tokens = tokens,
    stopwords = stopwords_combinadas,
    dtm = dtm,
    dtm_bigramas = bigramas$dtm,
    dtm_trigramas = trigramas$dtm,
    frecuencias = frecuencias,
    frecuencias_bigramas = bigramas$frecuencias,
    frecuencias_trigramas = trigramas$frecuencias
  ))
}
