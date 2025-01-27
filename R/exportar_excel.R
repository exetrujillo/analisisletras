#' Exportar DataFrame a Excel
#'
#' Esta funcion permite exportar un dataframe a un archivo Excel en la ubicacion especificada.
#' Verifica que el dataframe no este vacio y que el paquete `writexl` este instalado antes de realizar la exportacion.
#'
#' @param dataframe Un objeto de tipo `data.frame` que se desea exportar.
#' @param file_path Una cadena de texto que especifica la ruta y el nombre del archivo Excel que se generara.
#'                  Ejemplo: "output/datos.xlsx".
#'
#' @return No devuelve un valor, pero genera un archivo Excel en la ubicacion indicada.
#' @export
#'
#' @details
#' La funcion realiza varias comprobaciones:
#' - Asegura que el dataframe no este vacio. Si lo esta, se lanza un error.
#' - Verifica que el paquete `writexl` este instalado. Si no lo esta, se lanza un error.
#'
#' Una vez satisfechas estas condiciones, se utiliza la funcion `writexl::write_xlsx` para guardar el archivo Excel.
#'
#' @examples
#' \dontrun{
#' # Crear un dataframe de ejemplo
#' df <- data.frame(Nombres = c("Ana", "Luis", "Pedro"), Edades = c(23, 30, 25))
#'
#' # Exportar el dataframe a un archivo Excel
#' exportar_excel(df, "output/datos.xlsx")
#' }
#'
exportar_excel <- function(dataframe, file_path) {
  # Verificar que el dataframe no este vacio
  if (nrow(dataframe) == 0) {
    stop("El dataframe esta vacio y no se puede exportar.")
  }

  # Verificar que el paquete writexl este instalado
  if (!requireNamespace("writexl", quietly = TRUE)) {
    stop("El paquete 'writexl' no esta instalado. Usa install.packages('writexl') para instalarlo.")
  }

  # Exportar el dataframe como archivo Excel
  writexl::write_xlsx(dataframe, file_path)

  # Mensaje de confirmación
  message("El archivo Excel se ha guardado correctamente en: ", file_path)
}
