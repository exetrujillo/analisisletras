#' Desconectar de la base de datos
#'
#' Esta función cierra la conexión con la base de datos proporcionada.
#' Si el objeto no es una conexión válida, se genera un error.
#'
#' @param conn Una conexión activa con la base de datos (un objeto de clase `DBIConnection`).
#' @return No retorna ningún valor. Solo cierra la conexión.
#' @export
#'
#' @examples
#' desconectar_bd(conn)
desconectar_bd <- function(conn) {
  if (!inherits(conn, "DBIConnection")) {
    stop("El objeto proporcionado no es una conexión válida.")
  }
  DBI::dbDisconnect(conn)
}
