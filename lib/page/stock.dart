
import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
             child: Text(
                 'Page stock',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 28.0,
                      fontStyle: FontStyle.normal,
                  ),
               ),
          ),
    );
  }
}
