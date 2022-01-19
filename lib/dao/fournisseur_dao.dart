import 'package:e_commerce/db/poisson_database.dart';
import 'package:e_commerce/models/fournisseur.dart';
import 'package:flutter/foundation.dart';

class FournisseurDao{
  PoissonDatabase instanceBd = PoissonDatabase();

  Future<Fournisseur> createFournisseur(Fournisseur provider) async{
    final db = await instanceBd.database;
    try{
      final id = await db.insert(fournisseur, provider.toJson());
      if (kDebugMode) {
        print("Fournisseur creer avec succes!!!" );
      }
      return provider.copy(id: id);

    }catch(ex) {
      throw Exception(" erreur d insertion ");
    }finally{
      db.close();
    }
  }
  Future<List<Fournisseur>> findAllFournisseurs() async {
    final db = await instanceBd.database;
    try{
      final result = await db.query(fournisseur);
      return result.map((json) => Fournisseur.fromJson(json)).toList();
    }catch(ex){
      throw Exception(' ${ex.toString()},erreur de chargement');
    }finally{
      db.close();
    }
  }
  Future<Fournisseur> findById(int id) async {
    final db = await instanceBd.database;
    final map = await db.query(
      fournisseur,
      columns: FournisseurFields.valeur,
      where:  '${FournisseurFields.id } = ? ',
      whereArgs: [id],
    );
    if(map.isNotEmpty) {
      return Fournisseur.fromJson(map.first);
    }else{
      throw Exception(['ID $id non trouve']);
    }
  }
  Future<int> getIdByNom(String  nom) async{
    final db =  await instanceBd.database;
    var id = 0;

    final result = await db.rawQuery(
        "SELECT id FROM "
            " $fournisseur WHERE nom = '$nom'"
    );
    if(result.isNotEmpty){
      for(int i =0;i<result.length;i++){
        id = result[i]['id'].hashCode;
      }
    }else{
      return throw Exception(" $nom n'existe pas dans la basse donnee ");
    }
    return id;
  }
}