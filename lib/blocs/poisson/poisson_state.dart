import 'package:e_commerce/models/poisson.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum Status {
    initial,
    loading,
    loaded,
    error
}
@immutable
class PoissonState extends Equatable{
       final Status status;
       final List<Poisson> poissons;


     const PoissonState({required this.status, required this.poissons});

     PoissonState copy({Status? status,List<Poisson>? poissons}){
         return PoissonState(
               status: status?? this.status,
               poissons: poissons?? this.poissons
         );
      }
  @override
  // TODO: implement props
  List<Object?> get props =>[status,poissons];
}