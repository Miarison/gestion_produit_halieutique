import 'package:e_commerce/blocs/founisseur/fournisseur_bloc.dart';
import 'package:e_commerce/blocs/founisseur/fournisseur_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListeFournisseurPage extends StatelessWidget {
  const ListeFournisseurPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
          body: BlocBuilder<FournisseurBloc,FournisseurState>(
             builder: (context,state){
               if(state.status == StatusF.loading){
                  return Container(
                      child: Text('Loading ...'),
                  );
               }if(state.status == StatusF.loaded){
                    return Column(
                         children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.fournisseurs.length,
                                itemBuilder: (context, int index){
                                   return ListTile(
                                       title: Text(state.fournisseurs[index].nom),
                                       subtitle: Text((state.fournisseurs[index].contact).toString()),
                                   );
                                }
                               ),
                            )
                         ],   
                    );
               }else{
                  return Container(
                      child: Text('Error'),
                  );
               }
             }),
    );
  }
}
