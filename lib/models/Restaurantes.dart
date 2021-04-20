class Restaurantes {
  int id;
  String nombreRestaurante;
  String direccionR;
  String coloniaR;
  String estadoR;
  String ciudadR;
  String codigoPostal;
  String descripcionR;
  String horario;
  String fotografiaR;
  int idUsuarioR;
  String telefono;

  Restaurantes(id, nombreR, direccion, colonia, estado, ciudad, codigoP,
      descrip, horario, foto, idUsuario, tele) {
    this.id = id;
    this.nombreRestaurante = nombreR;
    this.direccionR = direccion;
    this.coloniaR = colonia;
    this.estadoR = estado;
    this.ciudadR = ciudad;
    this.codigoPostal = codigoP;
    this.descripcionR = descrip;
    this.horario = horario;
    this.fotografiaR = foto;
    this.idUsuarioR = idUsuario;
    this.telefono = tele;
  }
}
