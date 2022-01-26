import 'package:e_commerce/models/vente.dart';
import 'package:equatable/equatable.dart';

abstract class VenteEvent extends Equatable{

}
class OnCreateVente extends VenteEvent{
       Vente vente;

       OnCreateVente({required this.vente});
  @override
  // TODO: implement props
  List<Object?> get props =>[vente];

}
class OnFindAllVente extends VenteEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}