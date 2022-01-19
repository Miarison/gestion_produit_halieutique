import 'dart:ui';

import 'package:e_commerce/blocs/achat/achat_bloc.dart';
import 'package:e_commerce/blocs/achat/achat_event.dart';
import 'package:e_commerce/models/achat.dart';
import 'package:e_commerce/services/achat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AjoutAchat extends StatefulWidget {

  const AjoutAchat({Key? key}) : super(key: key);



  @override
  _AjoutAchatState createState() => _AjoutAchatState();
}

class _AjoutAchatState extends State<AjoutAchat> {

   late TextEditingController _prixController,_quantiteController;


   @override
  void initState() {
      // _fournisseurBloc.onFindAllFournisseur(event, emit)
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
       appBar: AppBar(
           title: const Text('Nouveau Achat'),
         backgroundColor: Colors.teal,
       ),
       body: BlocProvider(
          child: Container(
            // color: Colors.red,
              margin: const EdgeInsets.only(top: 30,left: 30,right: 30,bottom: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.transparent,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(5),

              ),
            child:Column(
              children: [
                Expanded(
                  child:ListView(
                    children: [
                      SizedBox(
                          width: 350,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text(
                              'Selectionner  fournisseur ...',
                              textAlign: TextAlign.right,
                            ),
                            iconSize: 40,
                            items: <String>['Sahondra', 'Hary'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          )

                      ),
                      const SizedBox(
                          height: 30
                      ),
                      SizedBox(
                        width: 350,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text('Selectionner  poisson ...'),
                          iconSize: 40,

                          items: <String>['Morue', 'Lamatra', 'Gogo', 'Makoba'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                      const TextField(
                        keyboardType: TextInputType.number,
                        // controller: _prixController = TextEditingController(text: widget.)
                        decoration: InputDecoration(
                          hintText: 'Prix',
                        ),
                      ),
                      const TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText:  'Quantite',
                            hintStyle: TextStyle(
                            )
                        ),
                      ),
                      const SizedBox(
                          height: 40
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(355, 40),
                              primary: Colors.teal,
                              // shape:StadiumBorder(),
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.normal,
                                // fontSize: 0.5,
                              )
                          ),
                          onPressed:(){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => widget,
                                )
                            );
                          }, child: const Text('Valider achat',
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold
                        ),
                      ))
                    ],
                  ),
                ),
              ],
              // keyboardType: TextInputType.number,
            ),
          ),
         create: (context)=> AchatBloc(achatRepository: AchatRepository())
           ..add(
               OnCreateAchat(
                   achat: Achat(idPoisson: 0,idFournisseur: 0,prix: 0.0,quantite: 0.0)
               )),
         )
    );
  }
}
