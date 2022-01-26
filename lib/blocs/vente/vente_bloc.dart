import 'package:e_commerce/blocs/vente/vente_event.dart';
import 'package:e_commerce/blocs/vente/vente_state.dart';
import 'package:e_commerce/models/vente.dart';
import 'package:e_commerce/services/vente_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VenteBloc extends Bloc<VenteEvent,VenteState>{
   final  venteRepository = VenteRepository();

  VenteBloc() : super(VenteState(status: StatusVente.initial, ventes: [] )){
      on<OnCreateVente>(_onCreateVente);
      on<OnFindAllVente>(_onFindAllVente);
  }


  Future<void> _onCreateVente(OnCreateVente event, Emitter<VenteState> emitter) async {
              emitter(state.copy(status: StatusVente.initial));
              try{
                 await venteRepository.save(event.vente);
                 emitter(state.copy(status: StatusVente.loaded));
              }catch(ex){
                 emitter(state.copy(status: StatusVente.error));
                throw Exception(" errer d'insertion ");
              }
  }
  Future<List<Vente>> _onFindAllVente(OnFindAllVente event, Emitter<VenteState> emitter) async{
             emitter(state.copy(status: StatusVente.loading,ventes: []));
             List<Vente> list = await venteRepository.getAllVente();
                if(list.isNotEmpty){
                    emitter(state.copy(status: StatusVente.loaded,ventes: list));
                }
                if(list.isEmpty){
                  emitter(state.copy(status: StatusVente.error,ventes: []));
                }
                return list;
        }
}