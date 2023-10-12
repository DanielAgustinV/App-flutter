import 'dart:convert';

import 'package:componets/api/NuevoPrestmoNomina.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:intl/intl.dart';



class NuevoPrestamo extends HookConsumerWidget{
  const NuevoPrestamo({super.key});

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final asyncValue = ref.watch(response_solicita_prestamo_nomina);
    dynamic resultado; // Declaras la variable 'resultado' fuera de 'asyncValue.when'
      asyncValue.when(
        data: (data) {
          resultado = jsonDecode(data);
          // Puedes realizar otras operaciones aquí con 'resultado'
          return resultado;
        },
        error: (error, stackTrace) {
          print('Error: $error');
          // Puedes manejar el error aquí
        },
        loading: () {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>[
              Text('Cargando datos...'), // Texto para indicar la carga
              SizedBox(height: 16), // Espacio entre el texto y el CircularProgressIndicator
              CircularProgressIndicator(), // El widget CircularProgressIndicator
            ],
          );
          // return const CircularProgressIndicator();
        },
      );

  // List<String> options = resultado ['avales']['nombre_completo'];

          // print(resultado);
          final salario = resultado['empleado']['salario_mensual'];
          print(salario);
          final maxorestamo = 33000;

  TextEditingController _amountController = TextEditingController();

    void _validateAmount() {
    final String amountText = _amountController.text;
    if (amountText.isEmpty) {
      return;
    }

    final double? amount = double.tryParse(amountText);
    if (amount != null && amount > maxorestamo) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cantidad excedida'),
            content: Text('La cantidad no puede ser mayor a $maxorestamo'),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      _amountController.clear();
    }
  }
    DateTime fechaActual = DateTime.now();
    DateTime fechainicio = DateTime(fechaActual.year, fechaActual.month, fechaActual.day);
    DateTime fecha = DateTime(2023, 11, 30); 
    DateTime fechafin = DateTime(fecha.year, fecha.month, fecha.day);
    Duration diferencia = fechafin.difference(fechainicio);
    int dias = diferencia.inDays;

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String? _monto;
    String? _tasaiva;
    String? _comision;
    String? _plazos;
    String? _pagoprestamo;
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Datos Préstamo'),
        backgroundColor:Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,),
            child: Column(
              children: [Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                              controller: _amountController,
                              decoration: InputDecoration(
                                labelText: "Monto",
                                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),

                              ),
                              onChanged: (_) {
                                _validateAmount();
                              },
                            ),
                              // child: TextFormField(
                              //   decoration: InputDecoration(labelText: 'Monto',
                              //     // icon:  Icon(Icons.monetization_on, color: Color.fromARGB(255, 0, 0, 0)),
                              //     border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                              //   ),
                              //   validator: (value) {
                              //     if (value!.isEmpty) {
                              //         return 'Por favor, ingresa el monto';
                              //       }

                              //       // Convierte 'value' a un número (puedes usar double o int según tus necesidades)
                              //       double? monto = double.tryParse(value);

                              //       if (monto == null) {
                              //         return 'Por favor, ingresa un número válido';
                              //       }

                              //       if (monto > maxorestamo) {
                              //         // return 'Maximo: $maxorestamo';
                              //       }
                              //       return null; // La validación fue exitosa
                              //   },
                              //   onSaved: (value) {
                              //     _monto = value;
                              //   },
                              // ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                // readOnly: true,
                                decoration:  const InputDecoration(labelText: 'Tasa con iva por periodo',
                                  // fillColor: Colors.green,
                                  // filled: true,
                                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                  decorationColor:Colors.purple,
          
                                )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Selecciona el periodo';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _tasaiva = value;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: '200',
                                readOnly: true,
                                decoration: InputDecoration(labelText: 'Comision por Apertura',
                                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _comision = value;
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Plazo(s)',
                                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingresa el plazo';
                                  }
                                  // Agregar validación de formato de teléfono si es necesario
                                  return null;
                                },
                                onSaved: (value) {
                                  _plazos = value;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: '',
                                // readOnly: true,
                                decoration: InputDecoration(labelText: 'Pago del prestamo',
                                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _pagoprestamo = value;
                                },
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: TextFormField(
                          //       decoration: const InputDecoration(labelText: 'Plazo(s)',
                          //         border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                          //       ),
                          //       validator: (value) {
                          //         if (value == null || value.isEmpty) {
                          //           return 'Por favor, ingresa el plazo';
                          //         }
                          //         // Agregar validación de formato de teléfono si es necesario
                          //         return null;
                          //       },
                          //       onSaved: (value) {
                          //         _plazos = value;
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Realizar acciones con los datos ingresados
                            print('monto: $_monto');
                            print('tasaiva: $_tasaiva');
                            print('comision: $_comision');
                            print('plazos: $_plazos');
                            print('plazos: $_pagoprestamo');

                          }
                        },
                        child: Text('Solicitar Prestamo'),
                      ),
                    ],
                  ),
                ),
    ),
              ],
            ),
            )
        ),
    );
  }

}