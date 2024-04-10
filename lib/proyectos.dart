import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/detallesproyectos.dart';

class Proyectos extends StatefulWidget {
  @override
  _ProyectosState createState() => _ProyectosState();
}

class _ProyectosState extends State<Proyectos> {
  List<dynamic> listaProyectos = [];
  TextEditingController proyectoController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController tagsIdController = TextEditingController();

  Future<List<dynamic>> obtenerProyectos() async {
    final response = await http.get(Uri.parse('https://monge.terrabyteco.com/api/projects'));
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
        backgroundColor: Color.fromARGB(255, 221, 28, 28),
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
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: listaProyectos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      listaProyectos[index]['name'],
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => detallesproyectos(proyecto: listaProyectos[index]),
                        ),
                      );
                    },
                    onLongPress: () {
                      _mostrarDialogoEditarEliminar(context, listaProyectos[index]);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _mostrarDialogoEditar(context, listaProyectos[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _eliminarProyecto(listaProyectos[index]['id'].toString());
;
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarDialogoCrearProyecto(context);
        },
        tooltip: 'Crear Proyecto',
        child: Icon(Icons.add),
      ),
    );
  }

  void _mostrarDialogoCrearProyecto(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Crear Proyecto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: proyectoController,
                decoration: InputDecoration(hintText: 'Nombre del Proyecto'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: dateController,
                decoration: InputDecoration(hintText: 'Fecha (YYYY-MM-DD)'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: durationController,
                decoration: InputDecoration(hintText: 'Duración'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: tagsIdController,
                decoration: InputDecoration(hintText: 'ID de etiquetas'),
              ),
            ],
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
                _crearProyecto(
                  proyectoController.text,
                  dateController.text,
                  durationController.text,
                  tagsIdController.text,
                );
                Navigator.pop(context); // Cerrar el cuadro de diálogo
              },
              child: Text('Crear'),
            ),
          ],
        );
      },
    );
  }

void _crearProyecto(String nombreProyecto, String fecha, String duracion, String tagsId) async {
  try {
    final response = await http.post(
      Uri.parse('https://monge.terrabyteco.com/api/projects/create'),
      body: {
        'name': nombreProyecto,
        'date': fecha,
        'duration': duracion,
        'tags_id': tagsId,
      },
    );

    if (response.statusCode == 201) {
      // Proyecto creado exitosamente
      // Actualizar la lista de proyectos o realizar otras acciones necesarias
      obtenerProyectos().then((value) {
        setState(() {
          listaProyectos = value;
        });
      });
    } else {
      // Error al crear el proyecto
      print('Error al crear el proyecto: ${response.body}');
      // Mostrar un mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al crear el proyecto'),
      ));
    }
  } catch (e) {
    // Capturar cualquier excepción y mostrarla
    print('Excepción al crear el proyecto: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error: $e'),
    ));
  }
}


  void _mostrarDialogoEditarEliminar(BuildContext context, dynamic proyecto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar o Eliminar Proyecto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nombre del Proyecto: ${proyecto['name']}'),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar el cuadro de diálogo
                  _mostrarDialogoEditar(context, proyecto);
                },
                child: Text('Editar'),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar el cuadro de diálogo
                  _eliminarProyecto(proyecto['id']);
                },
                child: Text('Eliminar'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el cuadro de diálogo
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoEditar(BuildContext context, dynamic proyecto) {
  proyectoController.text = proyecto['name'] ?? '';
  dateController.text = proyecto['date'] ?? '';
  durationController.text = proyecto['duration'] ?? '';
  tagsIdController.text = proyecto['tags_id'] != null ? proyecto['tags_id'].toString() : '';


  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Editar Proyecto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: proyectoController,
              decoration: InputDecoration(hintText: 'Nombre del Proyecto'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: dateController,
              decoration: InputDecoration(hintText: 'Fecha (YYYY-MM-DD)'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: durationController,
              decoration: InputDecoration(hintText: 'Duración'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: tagsIdController,
              decoration: InputDecoration(hintText: 'ID de etiquetas'),
            ),
          ],
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
              _actualizarProyecto(
                proyecto['id'].toString(),
                proyectoController.text,
                dateController.text,
                durationController.text,
                int.parse(tagsIdController.text),
              );
              Navigator.pop(context); // Cerrar el cuadro de diálogo
            },
            child: Text('Actualizar'),
          ),
        ],
      );
    },
  );
}


 void _actualizarProyecto(
  String id,
  String nombreProyecto,
  String fecha,
  String duracion,
  int tagsId, // Especificamos que tagsId es de tipo entero (int)
) async {
  try {
    // Aquí colocas el código para realizar la actualización del proyecto
    final response = await http.put(
      Uri.parse('https://monge.terrabyteco.com/api/projects/$id/update'),
      body: {
        'name': nombreProyecto,
        'date': fecha,
        'duration': duracion,
        'tags_id': tagsId.toString(), // Convertimos tagsId a String para enviarlo en la solicitud
      },
    );

    if (response.statusCode == 200) {
      // Proyecto actualizado exitosamente
      // Actualizar la lista de proyectos o realizar otras acciones necesarias
      obtenerProyectos().then((value) {
        setState(() {
          listaProyectos = value;
        });
      });
    } else {
      // Error al actualizar el proyecto
      print('Error al actualizar el proyecto: ${response.body}');
      // Puedes mostrar un mensaje de error al usuario si lo deseas
    }
  } catch (e) {
    // Capturar cualquier excepción y mostrarla
    print('Excepción al actualizar el proyecto: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error al actualizar el proyecto: $e'),
    ));
  }
}



  void _eliminarProyecto(String id) async {
  try {
    final response = await http.delete(
      Uri.parse('https://monge.terrabyteco.com/api/projects/$id/delete'),
    );

    if (response.statusCode == 200) {
      obtenerProyectos().then((value) {
        setState(() {
          listaProyectos = value;
        });
      });
    } else {
      print('Error al eliminar el proyecto: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al eliminar el proyecto'),
      ));
    }
  } catch (e) {
    print('Excepción al eliminar el proyecto: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error: $e'),
    ));
  }
}


}

