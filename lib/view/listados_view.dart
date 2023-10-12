import 'package:flutter/material.dart';

class Listadosview extends StatelessWidget{
    final elementos = const [
    'Pedro',
    'Pablo',
    'Camelia',
    'juan',
    'Pedro',
    ''
  ];
  const Listadosview({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('SERVICIOS'),
        backgroundColor: Colors.black,
      ),
      body: ListView.separated(
        itemCount: elementos.length,  
        separatorBuilder: (context,index) => ListTile(
          title: Text(elementos[index]),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          onTap: (){
            final res = elementos[index];
            print(res);
          },
        ), 
        itemBuilder: (_,__)=> const Divider(),
        )
    );
  }

}