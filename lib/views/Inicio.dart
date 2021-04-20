import 'package:flutter/material.dart';
import 'package:jrmarketing_mobile/views/consult/Index.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 90, 0, 25),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('images/logo.png')),
              ),
            ),
            Text(
              'JRMARKETING',
              style: TextStyle(
                  color: Color.fromARGB(255, 80, 56, 56),
                  fontSize: 22,
                  fontFamily: 'New Tegomin'),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 45,
              width: 150,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 80, 56, 56),
                  borderRadius: BorderRadius.circular(1)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Index()));
                },
                child: Text(
                  'Iniciar',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
