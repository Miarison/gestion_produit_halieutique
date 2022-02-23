
import 'package:e_commerce/models/historique.dart';
import 'package:equatable/equatable.dart';

enum StatusHisto{
     initial,
     loading,
     loaded,
     error
}

class HistoriqueState extends Equatable{
     final StatusHisto status;
     final Historique historique;

     HistoriqueState({required this.status, required this.historique});

     HistoriqueState copy({StatusHisto? status,Historique? historique}) => HistoriqueState(
         status: status ?? this.status,
         historique: historique ?? this.historique
        );

  @override
  // TODO: implement props
  List<Object?> get props => [status,historique];

}