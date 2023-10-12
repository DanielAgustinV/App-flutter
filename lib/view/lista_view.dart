import 'package:flutter/material.dart';

class Listaview extends StatelessWidget{
  const Listaview({super.key});
  final elementos = const [
    'Pedro',
    'Pablo',
    'Camelia',
    'Patricio',
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('SERVICIOS'),
      ),
      body: ListView(
        children:  [
          ...elementos.map((elemento) => ListTile(
            title:Text(elemento),
            trailing: Icon(Icons.arrow_forward_ios),
            )
            ).toList()
        ],
      )
    );
  }

}