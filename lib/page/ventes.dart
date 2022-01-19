import 'package:flutter/material.dart';

class Ventes extends StatelessWidget {
  const Ventes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
             child: Text(
                 'Page vente',
               style: TextStyle(
                 color: Colors.green,
                 fontWeight: FontWeight.normal,
                 fontSize: 28.0,
               ),
             ),
          ),
    );
  }
}
