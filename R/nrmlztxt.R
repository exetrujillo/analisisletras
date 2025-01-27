#' Normalizar texto
#'
#' Esta función normaliza un texto convirtiéndolo a minúsculas, eliminando los acentos y caracteres especiales,
#' eliminando símbolos como `&`, `(`, `)`, y otros, y eliminando espacios adicionales al principio y al final del texto.
#'
#' @param texto Un texto a ser normalizado (de tipo `character`).
#' @return Un texto normalizado (de tipo `character`), en minúsculas, sin acentos ni caracteres especiales,
#'         sin símbolos y sin espacios adicionales.
#' @export
#'
#' @examples
#' texto_normalizado <- nrmlztxt("¡Hola, cómo estás? (prueba) & todo bien!")
#' print(texto_normalizado)  # "hola como estas prueba todo bien"
nrmlztxt <- function(texto) {
  texto <- tolower(texto)                                # Minusculas
  texto <- stringi::stri_trans_general(texto, "Latin-ASCII")  # Eliminar acentos y especiales
  texto <- gsub("\\s*[&().?¡¿!]\\s*", " ", texto)             # Eliminar simbolos y espacios extra
  texto <- gsub("\\s+", " ", texto)                         # Reemplazar multiples espacios con uno solo
  texto <- trimws(texto)                                    # Eliminar espacios al inicio y al final
  return(texto)
}
