import 'package:flutter/material.dart';

class InformacionGrupo extends StatelessWidget {
  final String metodologia;

  const InformacionGrupo({Key? key, required this.metodologia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Información del Grupo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre del Grupo: GN-1-1',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Carrera: Gestión de Negocios',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Método Ágil Utilizado: $metodologia',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Integrantes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Juan Pérez\n'
              '2. María García\n'
              '3. Carlos López\n'
              '4. Ana Martínez\n'
              '5. Pedro Rodríguez\n'
              '6. Laura González',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InformacionGrupo(metodologia: ''), // Inicialmente muestra la metodología utilizada por el grupo
  ));
}
