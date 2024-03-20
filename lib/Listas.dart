import 'package:flutter/material.dart';
import 'package:proyecto/InformacionGrupo.dart';
import 'package:proyecto/metodologias.dart'; // Importa el archivo metodologias.dart
import 'package:proyecto/tareas.dart'; // Importa el archivo tareas.dart
import 'package:proyecto/perfil.dart'; // Importa el archivo perfil.dart
import 'package:proyecto/tareas_grupo.dart';
import 'package:proyecto/proyectos.dart';

class Listas extends StatelessWidget {
  const Listas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas'),
      ),
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
                child: Text(
                  'Perfil',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InformacionGrupo(metodologia: 'Scrum')), // Passing 'Scrum' to InformacionGrupo constructor
                  );
                },
                child: Text(
                  'Información de grupo',
                  style: TextStyle(fontSize: 18),
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
                child: Text(
                  'Metodologías',
                  style: TextStyle(fontSize: 18),
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
                child: Text(
                  'Tareas',
                  style: TextStyle(fontSize: 18),
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
                child: Text(
                  'Tareas de Grupo',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => proyectos()),
                  );
                },
                child: Text(
                  'Proyectos',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
