import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jrmarketing_mobile/models/Consulta.dart';
import 'package:jrmarketing_mobile/models/EtiquetasName.dart';
import 'package:jrmarketing_mobile/models/Publicaciones.dart';
import 'package:jrmarketing_mobile/models/Restaurantes.dart';
import 'package:jrmarketing_mobile/views/consult/Advertisements.dart';

class Extra extends StatefulWidget {
  final Restaurantes myRestaurant;
  Extra({this.myRestaurant});
  @override
  _Extra createState() => _Extra();
}

Consulta consult = new Consulta();
int myId;

class _Extra extends State<Extra> {
  List<dynamic> _listadoPublicaciones;
  Future<Restaurantes> miRestaurante;
  List<EtiquetasName> misEtiquetas;

  Future _getResults() async {
    final responseAnuncios = await http.get(
        'https://06acc8867cbc.ngrok.io/api/publicacion/restaurant/' +
            myId.toString());
    final responseEtiquetas = await http.get('');

    setState(() {
      _listadoPublicaciones = json.decode(responseAnuncios.body);
      misEtiquetas = json.decode(responseEtiquetas.body);
    });
  }

  _commentList() {
    return _listadoPublicaciones
        .map((comment) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment['id'],
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(comment['descripcionP'], style: TextStyle(fontSize: 14)),
                SizedBox(height: 15)
              ],
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _getResults();
    consult.miRestaurante = widget.myRestaurant;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Publicaciones'),
            ),
            body: Center(
              child: ListView(
                children: <Widget>[
                  miRestauranteData(consult.miRestaurante),
                  _commentList(),
                ],
              ),
            )));
  }
}

List<Widget> _listPublicaciones(List<Publicaciones> data) {
  List<Widget> publicaciones = [];
  for (var publication in data) {
    publicaciones.add(Card(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
              'https://06acc8867cbc.ngrok.io/api/restaurante/image?imageName=' +
                  publication.foto),
        ),
        Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            strutStyle: StrutStyle(fontSize: 12.0),
            text: TextSpan(
                style: TextStyle(color: Colors.black),
                text: publication.descripcionP),
          ),
        ),
      ],
    )));
  }
  return publicaciones;
}

Widget miRestauranteData(Restaurantes data) {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          title: Text(data.nombreRestaurante),
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
                data.fotografiaR),
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
