import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  Future<void> registerUser() async {
    final String url = 'https://monge.terrabyteco.com/api/users/create';
    final Map<String, dynamic> body = {
      'name': nameController.text,
      'surname': surnameController.text,
      'email': emailController.text,
      'phone': phoneController.text, 
      'password': passwordController.text,
      'image': imageController.text,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Si el registro fue exitoso, puedes navegar a la pantalla de inicio de sesión
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // Si el registro falló, puedes mostrar un mensaje de error al usuario
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Error al registrar. Inténtelo de nuevo."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: surnameController,
              decoration: InputDecoration(labelText: 'Apellido'),
              
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Telefono'),
              
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'Imagen'),
              
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: registerUser,
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}