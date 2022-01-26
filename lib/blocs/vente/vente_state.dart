import 'package:e_commerce/models/vente.dart';
import 'package:equatable/equatable.dart';

enum StatusVente{
     initial,
     loading,
     loaded,
     error
}

class VenteState extends Equatable{
      StatusVente status;
      List<Vente> ventes;

      VenteState({required this.status, required this.ventes});

      VenteState copy({
        StatusVente? status,
        List<Vente>? ventes
      }) => VenteState(
          status: status?? this.status,
          ventes: ventes?? this.ventes
      );
  @override
  // TODO: implement props
  List<Object?> get props => [status,ventes];

}