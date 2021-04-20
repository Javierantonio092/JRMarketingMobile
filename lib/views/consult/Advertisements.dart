import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jrmarketing_mobile/models/EtiquetasName.dart';
import 'package:jrmarketing_mobile/models/Publicaciones.dart';
import 'package:jrmarketing_mobile/models/Restaurantes.dart';
import 'package:jrmarketing_mobile/models/Consulta.dart';

class Advertisements extends StatefulWidget {
  final Restaurantes myRestaurant;
  Advertisements({this.myRestaurant});
  @override
  _Advertisements createState() => _Advertisements();
}

int myid;
Consulta consult = new Consulta();

class _Advertisements extends State<Advertisements> {
  Future<List<Publicaciones>> _listadoPublicaciones;
  Future<List<EtiquetasName>> misEtiquetas;

  Future<List<Publicaciones>> _getPublicaciones() async {
    final response = await http.get(
        'https://06acc8867cbc.ngrok.io/api/publicacion/restaurant/' +
            myid.toString());

    List<Publicaciones> _publicaciones = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData["data"]) {
        _publicaciones.add(Publicaciones(item["id"], item["descripcionP"],
            item["idRestaurantePubli"], item["foto"]));
      }
      return _publicaciones;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  Future<List<EtiquetasName>> _getEtiquetas() async {
    final response = await http.get(
        'https://06acc8867cbc.ngrok.io/api/etiquetum/restaurant/' +
            myid.toString());
    List<EtiquetasName> _etiquetas = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData["data"]) {
        _etiquetas.add(EtiquetasName(item["nombreEtiqueta"], item["idRestau"]));
      }
      return _etiquetas;
    } else
      throw Exception("Falló la conexión");
  }

  @override
  void initState() {
    super.initState();
    myid = widget.myRestaurant.id;
    _listadoPublicaciones = _getPublicaciones();
    consult.miRestaurante = widget.myRestaurant;
    misEtiquetas = _getEtiquetas();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          body: Column(
        children: [
          FutureBuilder(
              future: misEtiquetas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return miRestauranteData(
                      consult.miRestaurante, snapshot.data, context);
                }
              }),
          Expanded(
            child: FutureBuilder(
              future: _listadoPublicaciones,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GridView.count(
                    crossAxisCount: 2,
                    children: _listPublicaciones(snapshot.data, context),
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}

List<Widget> _listPublicaciones(
    List<Publicaciones> data, BuildContext context) {
  List<Widget> publicaciones = [];
  MaterialPageRoute route;
  for (var publi in data) {
    publicaciones.add(Card(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(route);
              },
              child: Image.network(
                'https://06acc8867cbc.ngrok.io/api/restaurante/image?imageName=' +
                    publi.foto,
                width: 110,
                height: 100,
              )),
        ),
        Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            strutStyle: StrutStyle(fontSize: 12.0),
            text: TextSpan(
                style: TextStyle(color: Colors.black),
                text: publi.descripcionP),
          ),
        ),
      ],
    )));
  }
  return publicaciones;
}

Widget miRestauranteData(
    Restaurantes data, List<EtiquetasName> etiquetum, BuildContext context) {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: ListTile(
            title: Text(
              data.nombreRestaurante,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        /*
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
                itemCount: etiquetum.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(etiquetum[index].nombreEtiqueta),
                  );
                })
          ],
        ),*/
        Image.network(
          'https://06acc8867cbc.ngrok.io/api/restaurante/image?imageName=' +
              data.fotografiaR,
          width: 180,
          height: 160,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data.descripcionR,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data.horario,
            style:
                TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 11),
          ),
        ),
      ],
    ),
  );
}
