import 'package:flutter/material.dart';

class detallesproyectos extends StatelessWidget {
  final dynamic proyecto;

  const detallesproyectos({Key? key, required this.proyecto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Detalles del Proyecto',
         style: TextStyle(color: Colors.blue),
        ), 
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${proyecto['name']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue), // Texto en azul
            ),
            SizedBox(height: 10),
            Text(
              'ID: ${proyecto['id']}',
              style: TextStyle(fontSize: 16, color: Colors.blue), // Texto en azul
            ),
            SizedBox(height: 10),
            Text(
              'Fecha: ${proyecto['date']}',
              style: TextStyle(fontSize: 16, color: Colors.blue), // Texto en azul
            ),
            SizedBox(height: 10),
            Text(
              'Duración: ${proyecto['duration']}',
              style: TextStyle(fontSize: 16, color: Colors.blue), // Texto en azul
            ),
            SizedBox(height: 10),
            // Agrega más detalles aquí según la estructura de tu proyecto
          ],
        ),
      ),
    );
  }
}
