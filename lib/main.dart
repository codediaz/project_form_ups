import 'package:flutter/material.dart';
import 'package:project_form_ups/models/persona.dart';

void main() {
  runApp(MyApp());
}

const darkBlueColor = Color(0xff486579);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        primaryColor: darkBlueColor,
      ),
      home: const MyHomePage(title: 'Form Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Persona _persona= Persona(id:null,name: '', lastname: '',age:'');
  List<Persona> _personas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: darkBlueColor),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_form(), _list()],
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  _form() => Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Nombre'),
            validator: (val) =>
            (val?.length == 0 ? 'Este campo es obligatorio' : null),
            onSaved: (val) => setState(() => _persona.name = val!),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Apellido'),
            validator: (val) =>
            (val?.length == 0 ? 'Este campo es obligatorio' : null),
            onSaved: (val) => setState(() => _persona.lastname = val!),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Edad'),
            validator: (val) =>
            (val?.length == 0 ? 'Este campo es obligatorio' : null),
            onSaved: (val) => setState(() => _persona.age = val!),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () => _onSubmit(),
              child: Text('Guardar'),
              color: darkBlueColor,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  _onSubmit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      print('''
    Nombre : ${_persona.name}
    Apellido : ${_persona.lastname}
    Edad: ${_persona.age}
    ''');
      _personas.add(Persona(id:null,name:_persona.name,lastname: _persona.lastname, age:_persona.age));
      form.reset();
    }
  }

  _list() => Expanded(
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: darkBlueColor,
                    size: 40.0,
                  ),
                  title: Text(
                    _personas[index].name.toUpperCase() +' '+ _personas[index].lastname.toUpperCase(),
                    style: TextStyle(
                        color: darkBlueColor, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_personas[index].age),
                  onTap: () {},
                ),
                Divider(
                  height: 5.0,
                ),
              ],
            );
          },
          itemCount: _personas.length,
        ),
      ),
    ),
  );

}



