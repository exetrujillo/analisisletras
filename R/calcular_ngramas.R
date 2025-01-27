#' Calcular dtm y frecuencias de n-gramas
#'
#' Esta funcion calcula las frecuencias  y dtm de n-gramas a partir de un objeto tokens,
#' con la opcion de excluir stopwords si el parametro `ngrama_stopwords` es `TRUE`.
#'
#' @param tokens Un objeto tokens generado con quanteda.
#' @param n El numero de palabras por n-grama (por ejemplo, 2 para bigramas, 3 para trigramas).
#' @param stopwords Un vector de palabras que se deben excluir del calculo de frecuencias.
#' @param ngrama_stopwords Logico. Si es `TRUE`, elimina las stopwords de los tokens antes de calcular los n-gramas.
#'
#' @return Una lista con dos elementos:
#' \itemize{
#'   \item `dtm`: La matriz de documento-termino (DTM) para los n-gramas.
#'   \item `frecuencias`: Un dataframe con las frecuencias de los n-gramas.
#' }
#'
#' @examples
#' # Calcular bigramas excluyendo stopwords
#' bigramas <- calcular_ngramas(tokens, n = 2, stopwords = c("de", "la", "y"), ngrama_stopwords = TRUE)
#'
#' @export
calcular_ngramas <- function(tokens, n, stopwords, ngrama_stopwords = FALSE) {
  # Si ngrama_stopwords es TRUE, eliminar las stopwords
  if (ngrama_stopwords) {
    # Eliminar las stopwords de los tokens
    tokens <- quanteda::tokens_remove(tokens, stopwords)
  }

  # Generar los n-gramas
  ngramas <- quanteda::tokens_ngrams(tokens, n = n)

  # Crear la matriz de documento-termino (DTM) para los n-gramas
  dtm_ngramas <- quanteda::dfm(ngramas)

  # Calcular las frecuencias
  frecuencias_ngramas <- quanteda.textstats::textstat_frequency(dtm_ngramas)

  return(list(
    dtm = dtm_ngramas,
    frecuencias = frecuencias_ngramas
  ))
}
