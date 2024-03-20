import 'package:flutter/material.dart'; 

class tareas extends StatefulWidget { 
  @override
  _TareasState createState() => _TareasState();
}

class _TareasState extends State<tareas> { 
  List<String> listaTareas = [];

  TextEditingController tareaController = TextEditingController();

  void agregarTarea() { 
    setState(() { 
      String nuevaTarea = tareaController.text;
      if (nuevaTarea.isNotEmpty) { 
        listaTareas.add(nuevaTarea);
        tareaController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Tareas'), 
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listaTareas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listaTareas[index]),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tareaController,
                    decoration: InputDecoration(
                      labelText: 'Nueva Tarea',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: agregarTarea,
                  child: Text('Agregar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
