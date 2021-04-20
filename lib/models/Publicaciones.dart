import 'package:jrmarketing_mobile/models/Consulta.dart';

class Publicaciones {
  int id;
  String descripcionP;
  int idRestaurantePubli;
  String foto;

  Publicaciones(id, descripcion, idRestaurante, foto) {
    this.id = id;
    this.descripcionP = descripcion;
    this.idRestaurantePubli = idRestaurante;
    this.foto = foto;
  }
}
