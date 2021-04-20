import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jrmarketing_mobile/models/Consulta.dart';
import 'package:jrmarketing_mobile/models/Restaurantes.dart';
import 'package:http/http.dart' as http;
import 'package:jrmarketing_mobile/views/consult/Advertisements.dart';
import 'package:jrmarketing_mobile/views/consult/Extra.dart';

class RestaurantesList extends StatefulWidget {
  Consulta consulta;
  RestaurantesList({Key key, this.consulta}) : super(key: key);
  @override
  _MyRestaurante createState() => _MyRestaurante();
}

String nombreRest, estadoRest;
int myId;

class _MyRestaurante extends State<RestaurantesList> {
  Future<List<Restaurantes>> _listadoRestau;
  Future<List<Restaurantes>> _getRestaurantes() async {
    var response =
        await http.get('https://06acc8867cbc.ngrok.io/api/restaurante/filter');

    if (estadoRest != 'Seleccione uno' && nombreRest != null) {
      response = await http.get(
          'https://06acc8867cbc.ngrok.io/api/restaurante/filter?NombreRestaurante=' +
              nombreRest +
              '&estadoR=' +
              estadoRest);
    }
    if (estadoRest != 'Seleccione uno' && nombreRest == null) {
      response = await http.get(
          'https://06acc8867cbc.ngrok.io/api/restaurante/filter?estadoR=' +
              estadoRest);
    }
    if (estadoRest == 'Seleccione uno' && nombreRest != null) {
      response = await http.get(
          'https://06acc8867cbc.ngrok.io/api/restaurante/filter?NombreRestaurante=' +
              nombreRest);
    }
    List<Restaurantes> _restaurantes = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData["data"]) {
        _restaurantes.add(Restaurantes(
            item["id"],
            item["nombreRestaurante"],
            item["direccionR"],
            item["coloniaR"],
            item["estadoR"],
            item["ciudadR"],
            item["coidgoPostalR"],
            item["descripcionR"],
            item["horario"],
            item["fotografiaR"],
            item["idUsuarioR"],
            item["telefono"]));
      }
      return _restaurantes;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listadoRestau = _getRestaurantes();
    nombreRest = widget.consulta.nombreRestaurante.toString();
    estadoRest = widget.consulta.estadoR.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(title: Text('Restaurantes')),
        body: FutureBuilder(
          future: _listadoRestau,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                children: _listRestaurantes(snapshot.data, context),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('No se encontraron resultados',
                      style: TextStyle(fontWeight: FontWeight.bold)));
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ),
      ),
    );
  }
}

List<Widget> _listRestaurantes(List<Restaurantes> data, BuildContext context) {
  navigateToDetail(Restaurantes consulta) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Advertisements(myRestaurant: consulta)));
  }

  List<Widget> restaurantes = [];
  for (var restau in data) {
    restaurantes.add(Card(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () => navigateToDetail(restau),
              child: Image.network(
                  'https://06acc8867cbc.ngrok.io/api/restaurante/image?imageName=' +
                      restau.fotografiaR,
                  height: 120,
                  width: 140)),
        ),
        Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            strutStyle: StrutStyle(fontSize: 12.0),
            text: TextSpan(
                style: TextStyle(color: Colors.black),
                text: restau.nombreRestaurante),
          ),
        ),
      ],
    )));
  }
  return restaurantes;
}
