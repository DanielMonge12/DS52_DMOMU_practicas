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
        backgroundColor: Colors.blue, // Cambia el color de fondo de la barra de aplicación
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(), // Agrega un separador entre elementos
              itemCount: listaProyectos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listaProyectos[index]['name']),
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
    );
  }
}
