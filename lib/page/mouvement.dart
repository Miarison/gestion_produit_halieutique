import 'package:flutter/material.dart';

class Mouvement extends StatelessWidget {
  const Mouvement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
          body: Center(
               child: Text(
                   'Page Historique',
                   style: TextStyle(
                       color: Colors.green,
                       fontStyle: FontStyle.normal,
                       fontSize: 28.0,
                   ),
               ),
          ),
    );
  }
}
