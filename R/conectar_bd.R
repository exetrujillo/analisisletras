#' Conectar a la base de datos SQLite
#'
#' Esta función establece una conexión con una base de datos SQLite especificada por la ruta del archivo.
#' Si el archivo de la base de datos no existe, se genera un error.
#'
#' @param db_path Ruta al archivo de base de datos SQLite. Por defecto es "db.sqlite3".
#' @return Un objeto de clase `DBIConnection`, que es la conexión abierta con la base de datos.
#' @export
#'
#' @examples
#' conn <- conectar_bd("mi_base_de_datos.sqlite3")
conectar_bd <- function(db_path = "db.sqlite3") {
  if (!file.exists(db_path)) {
    stop("El archivo de la base de datos no existe.")
  }
  conn <- DBI::dbConnect(RSQLite::SQLite(), dbname = db_path)
  return(conn)
}
