import 'package:e_commerce/models/achat.dart';
import 'package:equatable/equatable.dart';

abstract class AchatEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnCreateAchat extends AchatEvent{
      Achat achat;


      OnCreateAchat({required this.achat});
  @override
  // TODO: implement props
  List<Object?> get props => [achat];

}
class OnFindAllAchat extends AchatEvent{}

class OnfindById extends AchatEvent{
      late  int id;
      OnfindById({required this.id});
}