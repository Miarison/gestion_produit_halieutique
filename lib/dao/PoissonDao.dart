import 'dart:io';

import 'package:e_commerce/db/poisson_database.dart';
import 'package:e_commerce/models/poisson.dart';
import 'package:flutter/foundation.dart';

class PoissonDao{
  PoissonDatabase  instance = PoissonDatabase();

  Future<Poisson> create_poisson(Poisson poisson) async {
    final db = await instance.database;
    final id = await db.insert(tablesPoisson, poisson.toJson());
    if (kDebugMode) {
      print('poisson inserer avec success!!');
    }
    return poisson.copy(id: id);
  }
  Future<Poisson> findPoissonById(int id) async {
    final db = await instance.database;
    final map = await db.query(
      tablesPoisson,
      columns: PoissonFields.values,
      where: '${PoissonFields.id} = ?',
      whereArgs: [id],
    );
    if(map.isNotEmpty){
      return Poisson.fromJson(map.first);
    }else {
      throw Exception('ID $id non trouve');
    }
  }
  Future<List<Poisson>> findAllPoissons() async{
    final db = await instance.database;
    final result = await db.query(tablesPoisson);

    return result.map((json) => Poisson.fromJson(json)).toList();

  }
  Future<int> deletePoisson(int id) async {
    final db = await instance.database;
    if (kDebugMode) {
      print('poisson supprimer!!');
    }
    return await db.delete(
      tablesPoisson,
      where:  '${PoissonFields.id} = ?',
      whereArgs: [id],
    );
  }
  Future<int> getIdByNom(String nom) async{
    final db =  await instance.database;
    var id = 0;
    final result = await db.rawQuery(
                 "SELECT id FROM "
                     " $tablesPoisson WHERE nom = '$nom'"
       );
      if(result.isNotEmpty){
        for(int i =0;i<result.length;i++){
             id = result[i]['id'].hashCode;
        }
      }else{
        return throw Exception(" $nom n'existe pas dans la base donnee ");
      }
     return id;
  }

}