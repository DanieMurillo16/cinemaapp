import 'package:flutter/material.dart';



class FullScreenLoarder extends StatelessWidget {
  FullScreenLoarder({super.key});

  final message = <String>[
    'Cargando perfiles...',
    'Cargando peliculas...',
    'Cargando data...',
    'Ya casi terminamos...',
  ];

  Stream<String> getLoading() {
    return Stream.periodic(const Duration(milliseconds: 1200),(step){
      return message[step];
    }).take(message.length);
    
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: 
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Espere por favor...'),
        const SizedBox(height: 15),
        CircularProgressIndicator(),
        const SizedBox(height: 15),
        StreamBuilder(stream: getLoading(),
         builder: (context, snapshot) {
           if(!snapshot.hasData) return const Text('Cargando....');
            return Text(snapshot.data!);
         },)
      ],
    ));
  }
}