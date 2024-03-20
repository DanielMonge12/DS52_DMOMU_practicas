import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:proyecto/InformacionGrupo.dart';

class metodologias extends StatefulWidget {
  const metodologias({Key? key}) : super(key: key);

  @override
  _metodologiasState createState() => _metodologiasState();
}

class _metodologiasState extends State<metodologias> {
  int _ratingScrum = 0;
  int _ratingCascada = 0;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la URL $url';
    }
  }

  Widget _buildStarRating(int rating, ValueChanged<int> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating) {
          return IconButton(
            icon: Icon(Icons.star, color: Colors.amber),
            onPressed: () {
              onChanged(index + 1);
            },
          );
        } else {
          return IconButton(
            icon: Icon(Icons.star_border, color: Colors.grey),
            onPressed: () {
              onChanged(index + 1);
            },
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Información de Metodologías Ágiles'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Metodologías Ágiles:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Las metodologías ágiles son un conjunto de prácticas para el desarrollo de software basadas en los principios del Manifiesto Ágil. Algunas de las metodologías ágiles más populares son Scrum, Kanban, eXtreme Programming (XP), entre otras.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Scrum:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  _launchURL('https://www.scrum.org/');
                },
                child: Text(
                  'Más información sobre Scrum',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InformacionGrupo(metodologia: 'Scrum')),
                  );
                },
                child: Text('Agregar a grupo (Scrum)'),
              ),
              SizedBox(height: 20.0),
              Text(
                'Calificación de Scrum:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10.0),
              _buildStarRating(_ratingScrum, (rating) {
                setState(() {
                  _ratingScrum = rating;
                });
              }),
              SizedBox(height: 20.0),
              Text(
                'Cascada:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InformacionGrupo(metodologia: 'Cascada')),
                  );
                },
                child: Text('Agregar a grupo (Cascada)'),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  _launchURL('https://es.wikipedia.org/wiki/Modelo_en_cascada');
                },
                child: Text(
                  'Más información sobre Cascada',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Calificación de Cascada:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10.0),
              _buildStarRating(_ratingCascada, (rating) {
                setState(() {
                  _ratingCascada = rating;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
