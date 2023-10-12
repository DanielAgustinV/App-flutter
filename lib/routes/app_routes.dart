import 'package:componets/models/menu.dart';
import 'package:flutter/material.dart';

import '../view/views.dart';

class AppRoutes{
  static const initialRoute = 'home';

  static final menu = <Menu>[
    Menu(route: 'home',      icon: Icons.home,                     name:'Inicio',            view: HomeScreen()),
    Menu(route: 'listados',  icon: Icons.list_outlined,            name:'Listas',            view: Listadosview()),
    Menu(route: 'Prestamo',  icon: Icons.monetization_on_outlined, name:'Solicitar Prestamo',view: PrestamoNomina()),
    Menu(route: 'Ejempplos', icon: Icons.wind_power,               name:'Pruebas',           view: MyHomePage())
  ];
  
    static Map<String, Widget Function(BuildContext)> getAppRoutes(){
    Map<String, Widget Function (BuildContext)> appRoutes ={};

    for (final option in menu ) {
      appRoutes.addAll({option.route : (BuildContext contex) => option.view});
      
    };

    return appRoutes;
  }

  // static Map<String, Widget Function (BuildContext)> routes = {
  //       'home'     :(BuildContext context) => const HomeScreen(),
  //       'lista'    :(BuildContext context) => const Listaview(),
  //       'listados' :(BuildContext context) => const Listadosview(),
  //     };
} 