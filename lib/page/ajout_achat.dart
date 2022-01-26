import 'dart:ui';
import 'package:e_commerce/blocs/achat/achat_bloc.dart';
import 'package:e_commerce/blocs/achat/achat_event.dart';
import 'package:e_commerce/blocs/achat/achat_state.dart';
import 'package:e_commerce/blocs/founisseur/fournisseur_bloc.dart';
import 'package:e_commerce/blocs/founisseur/fournisseur_state.dart';
import 'package:e_commerce/blocs/poisson/poisson_bloc.dart';
import 'package:e_commerce/blocs/poisson/poisson_state.dart';
import 'package:e_commerce/models/achat.dart';
import 'package:e_commerce/models/fournisseur.dart';
import 'package:e_commerce/models/poisson.dart';
import 'package:e_commerce/services/achat_repository.dart';
import 'package:e_commerce/services/fournisseur_repository.dart';
import 'package:e_commerce/services/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AjoutAchat extends StatefulWidget {

  const AjoutAchat({Key? key}) : super(key: key);



  @override
  _AjoutAchatState createState() => _AjoutAchatState();
}

class _AjoutAchatState extends State<AjoutAchat> {


     final prixController = TextEditingController();

     final quantiteController = TextEditingController();

     final _fournisseurRepository = FournisseurRepository() ;

     final _poissonRepository = Repository();

     List<String> nomFornisseur = [] ;

     String dropdownValue = 'Sahondra';

     String dropdownValuePoisson = 'Makoba';

     int idFournisseur = 0;

     int idPoisson = 0;

     List<String> nomPoisson = [];


   @override
  void initState() {
     _fournisseurRepository.findAllFournisseurs().then((value) {
          setState(()  {
              for(Fournisseur f in value){
                  nomFornisseur.add(f.nom);
              }
          });
     });
    _poissonRepository.fetchAllPoissons().then((value) => setState((){
               for(Poisson p in value){
                  nomPoisson.add(p.nom);
               }
    }));
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
      prixController.dispose();
      quantiteController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    AchatBloc achatBloc = BlocProvider.of<AchatBloc>(context);

    return Scaffold(
       appBar: AppBar(
           title: const Text('Nouveau Achat'),
         backgroundColor: Colors.teal,
       ),
       body: Container(
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
                       child:DropdownButton<String>(
                       isExpanded: true,
                       value: dropdownValue,
                       elevation: 24,
                       iconSize: 40,
                       onChanged: (String? newValue) {
                         setState((){
                           dropdownValue = newValue!;
                           _fournisseurRepository.findIdByName(newValue).then(
                                   (value) => idFournisseur = value
                           );

                         });
                       },
                     items: nomFornisseur.map<DropdownMenuItem<String>>((String data) =>
                         DropdownMenuItem(
                         child: Text(data),
                         value: data
                     )).toList(),
                    ),
                   ),
                   const SizedBox(
                       height: 30
                   ),
                   SizedBox(
                       width: 350,
                       child: DropdownButton<String>(
                         isExpanded: true,
                         value: dropdownValuePoisson,
                         elevation: 24,
                         iconSize: 40,
                         onChanged: (String? newValue) {
                           setState((){
                             dropdownValuePoisson = newValue!;
                             _poissonRepository.getIdByNom(newValue).then(
                                     (value) => idPoisson = value
                             );
                           });
                         },
                         items: nomPoisson.map<DropdownMenuItem<String>>((String data) =>
                             DropdownMenuItem(
                                 child: Text(data),
                                 value: data
                             )).toList(),
                     ),
                   ),
                    TextField(
                     controller: prixController,
                     keyboardType: TextInputType.number,

                     decoration: const InputDecoration(
                       hintText: 'Prix',
                     ),
                   ),
                   TextField(
                     keyboardType: TextInputType.number,
                     controller: quantiteController,
                     decoration: const InputDecoration(
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
                         achatBloc.add(OnCreateAchat(achat: Achat(
                             idPoisson: idPoisson,
                             idFournisseur: idFournisseur,
                             prix: double.tryParse(prixController.text)!,
                             quantite: double.tryParse(quantiteController.text)!,
                         )));
                           print('idFournisseur $idFournisseur');
                           print('idPoissson $idPoisson');
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => widget,
                             )
                         );
                       }, child: const Text('Valider achat',
                     style: TextStyle(
                       color: Colors.white,
                     ),
                   ))
                 ],
               ),
             ),
           ],
           // keyboardType: TextInputType.number,
         ),
       )
    );
  }

}


