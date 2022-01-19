import 'dart:ffi';

import 'package:e_commerce/blocs/founisseur/fournisseur_event.dart';
import 'package:e_commerce/blocs/founisseur/fournisseur_state.dart';
import 'package:e_commerce/models/fournisseur.dart';
import 'package:e_commerce/services/fournisseur_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FournisseurBloc extends Bloc<FournisseurEvent,FournisseurState>{
      final FournisseurRepository fournisseurRepository;

      FournisseurBloc({required this.fournisseurRepository} ) : super(const FournisseurState( status: Status.initial, fournisseurs: [])){
      on<OnFindAllFournisseurs>(onFindAllFournisseur);
      on<OnCreateFournisseur>(_onCreateFournisseur);
      on<OnFindById>(_onFindById);
  }

  Future<void> onFindAllFournisseur(OnFindAllFournisseurs event, Emitter<FournisseurState> emit) async {
             emit(state.copyWith(status: Status.loading));
             List<Fournisseur> list =
                               await fournisseurRepository.findAllFournisseurs();
             if(list.isNotEmpty){
                 emit(state.copyWith(
                     status: Status.loaded,
                     fournisseurs: list
                 ));
             }
             if(list.isEmpty){
                emit(state.copyWith(
                   status: Status.error
                ));
             }
  }
  Future<void> _onCreateFournisseur(OnCreateFournisseur event,Emitter<FournisseurState> emit) async {
               await fournisseurRepository.createFournisseur(event.fournisseur);
               emit(state.copyWith(
                   status: Status.loaded,
               ));
  }
 Future<void> _onFindById(OnFindById event, Emitter<FournisseurState> emit) async {
           await fournisseurRepository.getById(event.id);
            emit(state.copyWith(
            status: Status.loaded,
          ));
 }
}