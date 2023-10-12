// import 'package:componets/api/solicitaPrestamo.dart';
import 'dart:convert';

import 'package:componets/api/SolicitaPrestamoNomina.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../views.dart';


class PrestamoNomina extends HookConsumerWidget {
  const PrestamoNomina({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postData = ref.watch(postDataProvider);
    // var idoperacion = 5;
    // final Widget widgetConKey = find.byKey( const Key('idoperacion')).evaluate().first.widget;
    // final Text widgetText = widgetConKey as Text;
    // final texto = widgetText.data; // Aquí obtienes el valor del widget Text

    return Scaffold(
      appBar: AppBar(
        title: const Text('Préstamo'),
        backgroundColor: Colors.black,
        elevation: 5,
        ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [  Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
                child:postData.when(
                  data:(data){
                    final jsonMap = jsonDecode(data);
                    return HtmlWidget(' ${jsonMap ['polititcas']}');
                  },
                  loading: (){
                    // return const CircularProgressIndicator();
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <Widget>[
                        Text('Cargando datos...'), // Texto para indicar la carga
                        SizedBox(height: 30), // Espacio entre el texto y el CircularProgressIndicator
                        // CircularProgressIndicator(), // El widget CircularProgressIndicator
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return Text('Error: $error');
                  },
                  ),
              ),
            ),
            Center(
          child: Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () { // Navegar a la nueva vista cuando se toque el botón
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NuevoPrestamo(),
                ));

              },
              child: Container(
                width: 250.0,
                height: 50.0,
                decoration: BoxDecoration(
                  boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 2, 136).withOpacity(0.2), // Sombra
                  blurRadius: 40,
                  offset: Offset(2.0, 2.0),
                  ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                child: Center(
                  child: postData.when(
                  data:(data){
                    final jsonMap = jsonDecode(data);
                    return Text(' ${jsonMap ['operaciones'][0]['operaciones']}',
                    key: const Key('idoperacion'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white, 
                    ),
                    );
                  },
                  loading: (){
                    return const CircularProgressIndicator();
                  },
                  error: (error, stackTrace) {
                    return Text('Error: $error');
                  },
                  )
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0)
          ],
        ),
      ),
    );
    
  }
}

  // Padding newMethod() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [ ListTile(
  //           onTap: () {
              
  //           },
  //         )
  //         ],

  //       )
  //     ),
  //   );
  // }

