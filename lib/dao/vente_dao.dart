import 'package:e_commerce/db/poisson_database.dart';
import 'package:e_commerce/models/vente.dart';
import 'package:intl/intl.dart';

class VenteDao {
  PoissonDatabase instanceDb = PoissonDatabase();

  Future<Vente> createVente(Vente ventes) async {
      final db = await instanceDb.database;
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat(' "yyyy-MM-dd" ');
      final String formatted = formatter.format(now);
      final json = ventes.toJson();
      final columns =  '${VenteFields.id_poisson},'
          '${VenteFields.prix},${VenteFields.quantite},${VenteFields.date_vente}';
      final values = '${json[VenteFields.id_poisson]},${json[VenteFields.prix]},'
          '${json[VenteFields.quantite]},$formatted';

      try{
        final id = await db.rawInsert('insert into  $vente ($columns) values ($values)');
        print(' Vente creer avec success!!');
        return ventes.copy(id: id);
      }catch(ex){
        throw Exception(ex.toString());
      }
  }
  DateTime getDate(String timeDate)  {
    var date = DateTime.parse(timeDate);
    return date;
  }
  Future<List<Vente>> findAllVente() async {
         final db = await instanceDb.database;
         List result = await db.rawQuery('select*from vente');
         List<Vente> list =  [];
         for(int i = 0; i < result.length; i++ ){
           list.add(
               Vente(
                   id_poisson: result[i]["id_poisson"],
                   prix:  result[i]["prix"],
                   quantite: result[i]["quantite"],
                   date_vente:  getDate(result[i]["date_vente"]
                   ))
           );
         }
         return list;
  }
}