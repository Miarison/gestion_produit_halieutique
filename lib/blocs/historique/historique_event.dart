import 'package:e_commerce/models/historique.dart';
import 'package:equatable/equatable.dart';

abstract class HistoriqueEvent extends Equatable{

}
class OnCreateHistorique extends HistoriqueEvent{
       final Historique historique;
       
       OnCreateHistorique({required this.historique});

  @override
  // TODO: implement props
  List<Object?> get props => [historique];

}