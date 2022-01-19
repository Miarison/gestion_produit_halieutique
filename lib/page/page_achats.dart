
import 'package:e_commerce/blocs/achat/achat_bloc.dart';
import 'package:e_commerce/blocs/achat/achat_state.dart';
import 'package:e_commerce/blocs/poisson/poisson_state.dart';
import 'package:e_commerce/models/achat.dart';
import 'package:e_commerce/services/achat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageAchats extends StatelessWidget {
  const PageAchats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: BlocBuilder<AchatBloc,AchatState>(
           builder: (BuildContext context,state){
             if(state.status == Status.loading){
               return Container();
             }
               if(state.status == Status.loaded){
                   return ListView.builder(
                        itemCount: state.achats.length,
                        itemBuilder: (context, int index){
                           return ListTile(
                                  leading: Text((state.achats[index].quantite).toString()),
                                   title: Text((state.achats[index].prix).toString()),
                           );
                        }
                   );
               }else {
                 return Container(
                    child: const Center(
                        child: Text(
                            'Error',
                          style: TextStyle(
                             color: Colors.red,
                             fontSize: 30.0,
                             fontWeight: FontWeight.bold,
                          ),
                            ),
                    ),
                 );
             }
           }
         ),
    );
  }
}
