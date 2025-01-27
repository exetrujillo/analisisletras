#' Desconectar de la base de datos
#'
#' Esta funcion cierra la conexion con la base de datos proporcionada.
#' Si el objeto no es una conexion valida, se genera un error.
#'
#' @param conn Una conexion activa con la base de datos (un objeto de clase `DBIConnection`).
#' @return No retorna ningun valor. Solo cierra la conexion.
#' @export
#'
#' @examples
#' desconectar_bd(conn)
desconectar_bd <- function(conn) {
  if (!inherits(conn, "DBIConnection")) {
    stop("El objeto proporcionado no es una conexion valida.")
  }
  DBI::dbDisconnect(conn)
}
