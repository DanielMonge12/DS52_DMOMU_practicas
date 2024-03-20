import 'package:flutter/material.dart'; 

class Perfil extends StatelessWidget { 
  // Simulación de datos de usuario
  final String nombreUsuario = "John Doe";
  final String correoUsuario = "john.doe@example.com";
  final String telefonoUsuario = "+1234567890";
  final String grupoUsuario = "Ninguno";

  @override
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Perfil'), 
      ),
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre: $nombreUsuario'),
            Text('Correo electrónico: $correoUsuario'),
            Text('Teléfono: $telefonoUsuario'),
            Text('Grupo: $grupoUsuario')
          ],
        ),
      ),
    );
  }
}
