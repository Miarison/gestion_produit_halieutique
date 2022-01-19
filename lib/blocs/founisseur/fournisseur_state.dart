import 'package:e_commerce/models/fournisseur.dart';
import 'package:equatable/equatable.dart';

enum Status {
  initial,
  loading,
  loaded,
  error
}

class FournisseurState extends Equatable{
     final Status status;
     final List<Fournisseur> fournisseurs;

     const FournisseurState({
           required this.status,
           required this.fournisseurs
     });

     FournisseurState copyWith({
       Status? status,
       List<Fournisseur>? fournisseurs
     }){
        return FournisseurState(
              status: status?? this.status,
              fournisseurs: fournisseurs?? this.fournisseurs,
        );
     }
  @override
  // TODO: implement props
  List<Object?> get props => [status,fournisseurs];

}