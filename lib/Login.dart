import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto/Listas.dart';

class Login extends StatefulWidget {
  final String title;

  const Login({Key? key, required this.title}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = 'contraseña o correo incorrecto';

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    final String url = 'https://monge.terrabyteco.com/api/login';
    final Map<String, dynamic> body = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      final http.Response response =
          await http.post(Uri.parse(url), body: body);
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('access_token')) {
        // Almacena la ID del usuario en SharedPreferences.
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', responseData['id']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => Listas()),
          ),
        );
      } else {
        setState(() {
          errorMessage = responseData['message'];
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Correo o contraseña incorrectos"),
          ),
        );
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error de conexión';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title), // Utiliza el título proporcionado
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              height: 150,
              width: 150,
              image: AssetImage('assets/images/ara.png'),
            ),
            Text(
              'Iniciar sesión',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0), // Espacio
            Text(
              'Correo:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0), // Espacio
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introduce el correo',
              ),
            ),
            SizedBox(height: 20.0), // Espacio
            Text(
              'Contraseña:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0), // Espacio
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introduce la contraseña',
              ),
              obscureText: true,
            ),
            SizedBox(height: 100.0), // Espacio
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 10.0), // Espacio
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ),
                );
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
