import 'package:e_commerce/dao/PoissonDao.dart';
import 'package:e_commerce/dao/fournisseur_dao.dart';
import 'package:e_commerce/db/poisson_database.dart';
import 'package:e_commerce/models/achat.dart';
import 'package:intl/intl.dart';

class AchatDao {

    PoissonDatabase instanceDb = PoissonDatabase();
    late final PoissonDao poissonDao;
    late final FournisseurDao fournisseurDao;
    
    Future<Achat> createAchat(Achat achats) async {
        final db =  await instanceDb.database;
        final DateTime now = DateTime.now();
        final DateFormat formatter = DateFormat(' "yyyy-MM-dd" ');
        final String formatted = formatter.format(now);
        final json = achats.toJson();
        final columns =  '${AchatFields.id_poisson},${AchatFields.id_fournisseur},'
            '${AchatFields.prix},${AchatFields.quantite},${AchatFields.date_achat}';
        final values = '${json[AchatFields.id_poisson]},${json[AchatFields.id_fournisseur]},${json[AchatFields.prix]},'
            '${json[AchatFields.quantite]},$formatted';
        try{
            final id = await db.rawInsert('insert into  $achat ($columns) values ($values)');
            print('Achat creer avec success!!');
            return achats.copy(id: id);
        }catch(ex){
           throw Exception(ex.toString());
        }
    }

    Future<Achat> findById(int id) async {
          final db = await instanceDb.database;
          final map = await db.query(
              achat,
              columns: AchatFields.colonneAchat,
              where:  '${AchatFields.id} = ?',
              whereArgs: [id],
          );
          if(map.isNotEmpty){
            return Achat.fromJson(map.first);
          }else{
            throw Exception('ID $id non trouve');
          }

    }
    DateTime getDate(String timeDate)  {
       var date = DateTime.parse(timeDate);
       return date;
    }
    Future<List<Achat>> findAllAchats() async{
        final db = await instanceDb.database;
          List result = await db.rawQuery('select*from achat');
          List<Achat> list =  [];
          for(int i = 0; i < result.length; i++ ){
              list.add(
                  Achat(
                      idPoisson: result[i]["idPoisson"],
                      idFournisseur:  result[i]["idFournisseur"],
                      prix:  result[i]["prix"],
                      quantite: result[i]["quantite"],
                      dateAchat:  getDate(result[i]["dateAchat"]
                      ))
              );
          }
          // return result.map((object) => Achat.fromJson(object)).toList();
         return list;
    }
    Future<Achat> updateAchat(Achat achats) async {
          final db = await instanceDb.database;
          final id = await db.update(
                achat,
                achats.toJson(),
                where: '${AchatFields.id} = ? ',
                whereArgs: [achats.id],
              );
          print('Achat modifier avec succes!');
          return achats.copy(id: id);
    }

}