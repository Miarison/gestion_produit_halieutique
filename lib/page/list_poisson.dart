import 'package:e_commerce/blocs/poisson/poisson_bloc.dart';
import 'package:e_commerce/blocs/poisson/poisson_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFish extends StatelessWidget {
  const ListFish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bloc.findAllPoisson();
    return Scaffold(
         body: BlocBuilder<PoissonBloc,PoissonState>(
             builder: (context,state){
               if(state.status == Status.loading){
                 return Center(
                   child:  Text('Loading ... '),
                 );
               }
               if(state.status == Status.loaded){
                 return Column(
                   children: [
                     Expanded(
                       child:
                       ListView.builder(
                          scrollDirection: Axis.vertical,
                           itemCount: state.poissons.length,
                           itemBuilder: (context, int index){
                             return ListTile(
                               title: Text(state.poissons[index].nom),
                               subtitle: Text(state.poissons[index].image),
                             );
                           }
                       ),

                     ),
                   ],
                 );
               }else{
                 return Container(
                   child: Text('Error'),
                 );
               }

             }) ,
    );
  }
}
