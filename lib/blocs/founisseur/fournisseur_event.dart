import 'package:e_commerce/models/fournisseur.dart';
import 'package:equatable/equatable.dart';

abstract class FournisseurEvent extends Equatable{

  @override
  List<Object?> get props => [];
}
class OnFindAllFournisseurs extends FournisseurEvent{}
class OnCreateFournisseur extends FournisseurEvent{
      final Fournisseur fournisseur;
      OnCreateFournisseur({required this.fournisseur});

      @override
      List<Fournisseur> get props =>[fournisseur];
}
class OnFindById extends FournisseurEvent{
      final int id ;
      OnFindById({required this.id});

      @override
      List<Object?> get props => [id];
}
class OnUpdate extends FournisseurEvent {
      final int id;
      OnUpdate({required this.id});

      @override
      List<Object?> get props => [id];
}
class OnRemove extends FournisseurEvent{
      final int id;
      OnRemove({required this.id});

      @override
      List<Object?> get props => [id];
}