#' Exportar los N primeros bigramas y trigramas por frecuencia y docfreq
#'
#' Esta funcion permite seleccionar y exportar los primeros N bigramas y trigramas ordenados
#' por frecuencia y por docfreq desde un corpus literario, y los guarda en un archivo de texto.
#'
#' @param corpus_literario Un objeto con los resultados del analisis del corpus, que debe contener
#'   las frecuencias de los bigramas y trigramas en sus componentes `frecuencias_bigramas`
#'   y `frecuencias_trigramas`, que deben ser dataframes.
#' @param bpf Numero de bigramas por frecuencia a seleccionar. Un valor entero.
#' @param bpdf Numero de bigramas por docfreq a seleccionar. Un valor entero.
#' @param tpf Numero de trigramas por frecuencia a seleccionar. Un valor entero.
#' @param tpdf Numero de trigramas por docfreq a seleccionar. Un valor entero.
#' @param archivo_salida El nombre del archivo de salida donde se guardaran los resultados.
#'   El valor por defecto es "data/salida_ngramas.txt".
#'
#' @return La funcion no retorna valores. Exporta el contenido a un archivo de texto que incluye
#'   los bigramas y trigramas ordenados por frecuencia y docfreq.
#'
#' @examples
#' # Ejemplo de uso con un corpus 'mi_corpus'
#' exportar_ngrams(mi_corpus, bpf = 10, bpdf = 10, tpf = 10, tpdf = 10)
#'
#' # Usando un archivo de salida personalizado
#' exportar_ngrams(mi_corpus, bpf = 5, bpdf = 5, tpf = 5, tpdf = 5, archivo_salida = "data/resultado_ngramas.txt")
#'
#' @export

exportar_ngramas <- function(corpus_literario,
                            bpf, bpdf, tpf, tpdf, archivo_salida = "data/salida_ngramas.txt") {
  # Extraer frecuencias de bigramas y trigramas
  frecuencias_bigramas <- corpus_literario$frecuencias_bigramas
  frecuencias_trigramas <- corpus_literario$frecuencias_trigramas

  # Validar argumentos
  if (!is.data.frame(frecuencias_bigramas) || !is.data.frame(frecuencias_trigramas)) {
    stop("Los inputs de frecuencias deben ser dataframes.")
  }

  # Seleccionar los bpf primeros bigramas por frecuencia
  bigramas_por_frecuencia <- head(frecuencias_bigramas[order(-frecuencias_bigramas$frequency), ], bpf)

  # Seleccionar los bpdf primeros bigramas por docfreq
  bigramas_por_docfreq <- head(frecuencias_bigramas[order(-frecuencias_bigramas$docfreq), ], bpdf)

  # Seleccionar los tpf primeros trigramas por frecuencia
  trigramas_por_frecuencia <- head(frecuencias_trigramas[order(-frecuencias_trigramas$frequency), ], tpf)

  # Seleccionar los tpdf primeros trigramas por docfreq
  trigramas_por_docfreq <- head(frecuencias_trigramas[order(-frecuencias_trigramas$docfreq), ], tpdf)

  # Crear el contenido del archivo de salida
  texto_salida <- c(
    "BIGRAMAS ORDENADOS POR FRECUENCIA:",
    paste(bigramas_por_frecuencia$feature, bigramas_por_frecuencia$frequency, sep = " -> "),
    "",
    "BIGRAMAS ORDENADOS POR DOCFREQ:",
    paste(bigramas_por_docfreq$feature, bigramas_por_docfreq$docfreq, sep = " -> "),
    "",
    "TRIGRAMAS ORDENADOS POR FRECUENCIA:",
    paste(trigramas_por_frecuencia$feature, trigramas_por_frecuencia$frequency, sep = " -> "),
    "",
    "TRIGRAMAS ORDENADOS POR DOCFREQ:",
    paste(trigramas_por_docfreq$feature, trigramas_por_docfreq$docfreq, sep = " -> ")
  )

  # Escribir el contenido al archivo
  writeLines(texto_salida, con = archivo_salida)

  cat("Archivo exportado exitosamente a:", archivo_salida, "\n")
}
