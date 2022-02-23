import 'package:e_commerce/db/poisson_database.dart';
import 'package:e_commerce/models/Stock.dart';

class StockDao {
    final PoissonDatabase instanceDb = PoissonDatabase();

    Future<void> createStock(Stock stoks) async {
          final db = await instanceDb.database;
          try{
             await db.insert(stock, stoks.toJson());
             print('stock creer');

          }catch(ex){
             throw Exception(ex.toString());
          }

    }

}