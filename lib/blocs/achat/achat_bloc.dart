import 'package:e_commerce/blocs/achat/achat_event.dart';
import 'package:e_commerce/blocs/achat/achat_state.dart';
import 'package:e_commerce/blocs/poisson/poisson_state.dart';
import 'package:e_commerce/models/achat.dart';
import 'package:e_commerce/services/achat_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AchatBloc extends Bloc<AchatEvent,AchatState>{
   final AchatRepository achatRepository;

  AchatBloc({required this.achatRepository}) : super(AchatState(status: Status.initial, achats: [])){
   on<OnCreateAchat>(_onCreateAchat);
   on<OnFindAllAchat>(_onFindAllAchat);
  }

  Future<List<Achat>> _onFindAllAchat(OnFindAllAchat event, Emitter<AchatState> emit) async{
        emit(state.copy(status: Status.loading));
        List<Achat> list = await achatRepository.getAllAchats();
         if(list.isNotEmpty){
           emit(state.copy(status: Status.loaded,achats: list));
           for(Achat achat in list){
                if (kDebugMode) {
                  print(' idPoisson: ${achat.idPoisson},'
                      'idFournisseur: ${achat.idFournisseur},'
                      'prix: ${achat.prix},'
                      'quantite: ${achat.quantite}'
                      'date achat: ${achat.dateAchat},'
                      '');
                }
           }
         }
         if(list.isEmpty){
           emit(state.copy(status: Status.error));
           throw Exception('data vide');
         }
        return list;
   }
  Future<void> _onCreateAchat(OnCreateAchat event, Emitter<AchatState> emitter) async{
        try{
          emitter(state.copy(status: Status.initial));
          await achatRepository.save(event.achat);
          emitter(state.copy(status: Status.loaded));
        }catch(ex){
          emitter(state.copy(status: Status.error));
          throw Exception(ex.toString());
        }
  }
}