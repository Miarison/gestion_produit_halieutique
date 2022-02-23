import 'package:e_commerce/models/menu_option.dart';
import 'package:e_commerce/page/page_achats.dart';
import 'package:e_commerce/page/list_poisson.dart';
import 'package:e_commerce/page/stock.dart';
import 'package:e_commerce/page/ventes.dart';
import 'package:flutter/material.dart';

import 'ajout_achat.dart';
import 'mouvement.dart';
import 'liste_fournisseur_page.dart';


class Home extends StatefulWidget {
  static const IconData panorama_fish_eye_outlined = IconData(0xf251, fontFamily: 'MaterialIcons');

  const  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int _selectMenu = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
             leading: Icon(Icons.import_contacts_sharp),
             title: const Text(
                 'Accueil',
                ),
             toolbarHeight: 100,
             backgroundColor: Color(0xFFEA5042),
                 // backgroundColor: Colors.teal,
        ) ,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (BuildContext context,   int index){
                    return Container(
                        margin: const EdgeInsets.all(10.0),
                        width: double.infinity,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border:
                           Border.all(color: Colors.white),
                        ),
                       child: ListTile(
                            leading: options[index].icon,
                            title: TextButton(
                                  style: const ButtonStyle(
                                     alignment: Alignment.topLeft,
                                  ),
                                  onPressed: (){
                                   switch(options[index].menu){
                                     case 'Fournisseur':{
                                       Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => const ListeFournisseurPage(),
                                           )
                                       );
                                     } break;
                                     case 'Marchandises':
                                       Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => const ListFish(),
                                           )
                                       );
                                       break;
                                     case 'Achats':
                                       Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => const AjoutAchat(),
                                           )
                                       );
                                       break;
                                     case 'Ventes':{
                                       Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => const Ventes(),
                                           )
                                       );
                                       break;
                                     }
                                     case'Stocks':
                                       Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => const Stock(),
                                           )
                                       );
                                       break;
                                     case 'Mouvement':
                                       Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => const Mouvement(),
                                           )
                                       );
                                       break;
                                   }
                            },
                                   child: Text(
                                     options[index].menu,
                                     textAlign: TextAlign.right,
                                     style: const TextStyle(
                                         color: Colors.black54,
                                     ),
                                    ) ,
                                   ),

                             onTap:(){

                                  setState(() {
                                  });
                            },
                      ),
                      
                    );
                  }
                 ),
            ),
          ],
        ),
    );
  }
}

