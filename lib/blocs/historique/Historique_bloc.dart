import 'package:e_commerce/blocs/historique/historique_event.dart';
import 'package:e_commerce/models/historique.dart';
import 'package:e_commerce/services/historique_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'historique_state.dart';

class HistoriqueBloc extends Bloc<HistoriqueEvent,HistoriqueState>{
      final historiqueRepository = HistoriqueRepository();

      HistoriqueBloc() : super(HistoriqueState(status: StatusHisto.initial, historique: Historique())){
        on<OnCreateHistorique>(_onCreateHistorique);
      }

  Future<void> _onCreateHistorique(OnCreateHistorique event, Emitter<HistoriqueState> emit) async{
                await historiqueRepository.save_historique(event.historique);
                emit(state.copy(status: StatusHisto.loaded));
  }
}