
import 'package:e_commerce/blocs/poisson/poisson_event.dart';
import 'package:e_commerce/blocs/poisson/poisson_state.dart';
import 'package:e_commerce/models/poisson.dart';
import 'package:e_commerce/services/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 class PoissonBloc extends Bloc<PoissonEvent,PoissonState>{
  final Repository repository;

  PoissonBloc({required this.repository}) : super(const PoissonState(status: Status.initial, poissons: [])){
        on<OnFindAllPoisson>(_onFindAllPoisson);
        on<OnFindIdByName>(_onFindIdByName);
  }

 Future<void> _onFindAllPoisson(OnFindAllPoisson event, Emitter<PoissonState> emit) async {
       emit(state.copy(status: Status.loading));
       List<Poisson> list = await repository.fetchAllPoissons();
        if(list.isNotEmpty){
           emit(state.copy(status: Status.loaded,poissons:list));
           if (kDebugMode) {
             print('etat: ${state.status}');
             for(Poisson p in list){
               print('liste poisson dispo : ${p.id} : ${p.nom} - ${p.image}');
             }
           }
        }
        if(list.isEmpty){
          emit(state.copy(status: Status.error));
          throw Exception('data vide');
        }
 }

 Future<void> _onFindIdByName(OnFindIdByName event, Emitter<PoissonState> emit) async {
       int idPoisson = await repository.getIdByNom(event.nom);
      if(idPoisson != 0){
           emit(state.copy(status: Status.loaded));
      }else{
        emit(state.copy(status: Status.error));
      }
 }

}
