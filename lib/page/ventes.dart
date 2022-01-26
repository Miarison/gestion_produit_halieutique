import 'package:e_commerce/blocs/vente/vente_bloc.dart';
import 'package:e_commerce/blocs/vente/vente_event.dart';
import 'package:e_commerce/models/poisson.dart';
import 'package:e_commerce/models/vente.dart';
import 'package:e_commerce/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Ventes extends StatefulWidget {
  const Ventes({Key? key}) : super(key: key);

  @override
  State<Ventes> createState() => _VentesState();
}

class _VentesState extends State<Ventes> {

  final _poissonRepository = Repository();

  final prixController = TextEditingController();

  final quantiteController = TextEditingController();

  int idPoisson = 0;

  List<String> nomPoisson = [];

  String dropdownValue = 'Makoba';

  @override
  void initState() {
    _poissonRepository.fetchAllPoissons().then((value) => setState((){
      for(Poisson p in value){
        nomPoisson.add(p.nom);
      }
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VenteBloc venteBloc = BlocProvider.of<VenteBloc>(context);
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
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        elevation: 24,
                        iconSize: 40,
                        onChanged: (String? newValue) {
                          setState((){
                            dropdownValue = newValue!;
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
                          venteBloc.add(OnCreateVente(vente: Vente(
                            id_poisson: idPoisson,
                            prix: double.tryParse(prixController.text)!,
                            quantite: double.tryParse(quantiteController.text)!,
                          )));
                          print('idPoissson $idPoisson');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => widget,
                              )
                          );
                        }, child: const Text('Valider vente',
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
