import 'package:flutter/material.dart';
import 'package:jrmarketing_mobile/models/Consulta.dart';
import 'package:jrmarketing_mobile/views/consult/RestaurantesList.dart';

class Index extends StatefulWidget {
  Index() : super();

  final String title = "DropDown Demo";

  @override
  DropDownState createState() => DropDownState();
}

class Estados {
  String name;

  Estados(this.name);

  static List<Estados> getCompanies() {
    return <Estados>[
      Estados('Seleccione uno'),
      Estados('Aguascalientes'),
      Estados('Baja California'),
      Estados('Baja California Sur'),
      Estados('Campeche'),
      Estados('Coahuila'),
      Estados('Colima'),
      Estados('Chiapas'),
      Estados('Chihuahua'),
      Estados('Durango'),
      Estados('Guanajuato'),
      Estados('Guerrero'),
      Estados('Hidalgo'),
      Estados('Jalisco'),
      Estados('México'),
      Estados('Michoacán'),
      Estados('Morelos'),
      Estados('Nayarit'),
      Estados('Nuevo León'),
      Estados('Oaxaca'),
      Estados('Puebla'),
      Estados('Querétaro'),
      Estados('Quintana Roo'),
      Estados('San Luis Potosí'),
      Estados('Sinaloa'),
      Estados('Sonora'),
      Estados('Tabasco'),
      Estados('Tamaulipas'),
      Estados('Tlaxcala'),
      Estados('Veracruz'),
      Estados('Yucatán'),
      Estados('Zacatecas'),
    ];
  }
}

class DropDownState extends State<Index> {
  //
  List<Estados> _companies = Estados.getCompanies();
  List<DropdownMenuItem<Estados>> _dropdownMenuItems;
  Estados _selectedCompany;
  final myController = TextEditingController();

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Estados>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Estados>> items = List();
    for (Estados company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Estados selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Ingrese los datos para buscar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Estado',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                  value: _selectedCompany,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                  hint: Text('Estado'),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: '¿Qué estas buscando?',
                        prefixIcon: Icon(Icons.search)),
                    controller: myController,
                  ),
                ),
                SizedBox(height: 15),
                MaterialButton(
                    minWidth: 180.0,
                    height: 40.0,
                    onPressed: () {
                      Consulta consult = new Consulta();
                      consult.estadoR = _selectedCompany.name.toString();
                      consult.nombreRestaurante = myController.text;
                      var route = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new RestaurantesList(consulta: consult),
                      );
                      Navigator.of(context).push(route);
                    },
                    color: Colors.lightBlue,
                    child:
                        Text('Buscar', style: TextStyle(color: Colors.white)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
