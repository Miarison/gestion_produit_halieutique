import 'package:e_commerce/blocs/poisson/poisson_state.dart';
import 'package:e_commerce/models/achat.dart';
import 'package:equatable/equatable.dart';

class AchatState extends Equatable{
    final  Status status;
    final List<Achat> achats;

    AchatState({required this.status,required this.achats});

    AchatState copy({
              Status? status,
              List<Achat>? achats,
              }) =>AchatState(
                  status: status?? this.status,
                  achats: achats ?? this.achats,
             );

  @override
  // TODO: implement props
  List<Object?> get props => [status,achats];

}