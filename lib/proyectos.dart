import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/detallesproyectos.dart';

class proyectos extends StatefulWidget {
  @override
  _proyectosState createState() => _proyectosState();
}

class _proyectosState extends State<proyectos> {
  List<dynamic> listaProyectos = [];
  TextEditingController proyectoController = TextEditingController();

  Future<List<dynamic>> obtenerProyectos() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/projects'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar proyectos');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerProyectos().then((value) {
      setState(() {
        listaProyectos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Proyectos'),
        backgroundColor: Color.fromARGB(255, 221, 28, 28), // Cambia el color de fondo de la barra de aplicación
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _mostrarDialogoCrearProyecto(context);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black, // Fondo negro para el cuerpo de la pantalla
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(), // Agrega un separador entre elementos
                itemCount: listaProyectos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      listaProyectos[index]['name'],
                      style: TextStyle(color: Colors.red), // Color rojo para el texto
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => detallesproyectos(proyecto: listaProyectos[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoCrearProyecto(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Crear Proyecto'),
          content: TextField(
            controller: proyectoController,
            decoration: InputDecoration(hintText: 'Nombre del Proyecto'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el cuadro de diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _crearProyecto(proyectoController.text);
                Navigator.pop(context); // Cerrar el cuadro de diálogo
              },
              child: Text('Crear'),
            ),
          ],
        );
      },
    );
  }

  void _crearProyecto(String nombreProyecto) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/projects/create'),
      body: {'name': nombreProyecto},
    );

    if (response.statusCode == 201) {
      // Proyecto creado exitosamente
      // Actualizar la lista de proyectos o realizar otras acciones necesarias
    } else {
      // Error al crear el proyecto
      print('Error al crear el proyecto: ${response.body}');
      // Puedes mostrar un mensaje de error al usuario si lo deseas
    }
  }
}
