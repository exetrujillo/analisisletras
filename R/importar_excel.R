#' Importar un archivo Excel
#'
#' Esta funcion importa un archivo Excel y devuelve su contenido como un data frame.
#'
#' @param ruta_archivo Una cadena de texto que representa la ruta al archivo Excel que se desea importar.
#'
#' @return Un data frame que contiene los datos del archivo Excel importado.
#'
#' @examples
#' df <- importar_excel("ruta/al/archivo.xlsx")
#'
#' @export
importar_excel <- function(ruta_archivo) {
  # Verificar si el archivo existe
  if (!file.exists(ruta_archivo)) {
    stop("El archivo no existe en la ruta proporcionada.")
  }

  # Leer el archivo Excel
  dataframe <- readxl::read_excel(ruta_archivo)

  # Mensaje de confirmación
  cat("El archivo se ha importado correctamente.\n")

  # Devolver el dataframe
  return(dataframe)
}
