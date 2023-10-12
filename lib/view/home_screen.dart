
import 'package:componets/routes/app_routes.dart';
// import 'package:componets/view/views.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final opcionMenu = AppRoutes.menu;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicacion'),
        backgroundColor: Colors.black,
        elevation: 5,
      ),
      body: ListView.separated(
        itemBuilder: (context, i) => ListTile(
          title:  Text(opcionMenu[i].name),
          leading: Icon(opcionMenu[i].icon),
          onTap: () {
            // final route = MaterialPageRoute(builder: (context) => const Listadosview());
            // Navigator.push(context, route);
            // Navigator.pushReplacement(context, route);
            Navigator.pushNamed(context, opcionMenu[i].route);
          },
        ) , 
        separatorBuilder: ( _, __) => const Divider(),
        itemCount: opcionMenu.length)
    );
  }

}