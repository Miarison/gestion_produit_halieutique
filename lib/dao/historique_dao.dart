import 'package:e_commerce/db/poisson_database.dart';
import 'package:e_commerce/models/historique.dart';

class HistoriqueDao {

   PoissonDatabase instanceDb = PoissonDatabase();
       Future<int>  create_historique(Historique historiques) async {
             final db = await instanceDb.database;
             int idHistorique = 0;
             try{
                 idHistorique = await db.insert(historique, historiques.toJson());
                 print(' Historique creer');

             }catch(ex){
               throw Exception(ex.toString());
             }
             return idHistorique;
   }
  
}