
import 'package:e_commerce/models/poisson.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
 abstract class PoissonEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class OnFindAllPoisson extends PoissonEvent{
}
class OnFindById extends PoissonEvent{
    final int id;

    OnFindById({ required this.id});
    @override
   List<Object?> get props => [id];
}
class OnSavePoisson extends PoissonEvent{
     final Poisson poisson;

     OnSavePoisson({required this.poisson});
     @override
  List<Object?> get props => [poisson];
}
class OnFindIdByName extends PoissonEvent{
     final String nom;

     OnFindIdByName({required this.nom});
     @override
  List<Object?> get props => [nom];

}