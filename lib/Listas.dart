import 'package:flutter/material.dart';
import 'package:proyecto/InformacionGrupo.dart';
import 'package:proyecto/metodologias.dart';
import 'package:proyecto/tareas.dart';
import 'package:proyecto/perfil.dart';
import 'package:proyecto/tareas_grupo.dart';
import 'package:proyecto/proyectos.dart';

class Listas extends StatelessWidget {
  const Listas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas'),
        backgroundColor: Color.fromARGB(255, 201, 199, 199),
      ),
      backgroundColor: Colors.black, // Fondo negro para toda la pantalla
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Perfil()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Text(
                  'Perfil',
                  style: TextStyle(fontSize: 18, color: Colors.black), // Texto en negro
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InformacionGrupo(metodologia: 'Scrum')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Text(
                  'Información de grupo',
                  style: TextStyle(fontSize: 18, color: Colors.black), // Texto en negro
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => metodologias()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Text(
                  'Metodologías',
                  style: TextStyle(fontSize: 18, color: Colors.black), // Texto en negro
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => tareas()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Text(
                  'Tareas',
                  style: TextStyle(fontSize: 18, color: Colors.black), // Texto en negro
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => tareas_grupo()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Text(
                  'Tareas de Grupo',
                  style: TextStyle(fontSize: 18, color: Colors.black), // Texto en negro
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Proyectos()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Text(
                  'Proyectos',
                  style: TextStyle(fontSize: 18, color: Colors.black), // Texto en negro
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
