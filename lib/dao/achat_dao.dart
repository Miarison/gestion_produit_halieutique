import 'package:e_commerce/dao/PoissonDao.dart';
import 'package:e_commerce/dao/fournisseur_dao.dart';
import 'package:e_commerce/dao/historique_dao.dart';
import 'package:e_commerce/dao/stock_dao.dart';
import 'package:e_commerce/db/poisson_database.dart';
import 'package:e_commerce/models/Stock.dart';
import 'package:e_commerce/models/achat.dart';
import 'package:e_commerce/models/historique.dart';
import 'package:intl/intl.dart';

class AchatDao {

    PoissonDatabase instanceDb = PoissonDatabase();
    late final PoissonDao poissonDao;
    late final FournisseurDao fournisseurDao;
    final HistoriqueDao _historiqueDao = HistoriqueDao();
    final StockDao _stockDao = StockDao();
    
    Future<Achat> createAchat(Achat achats) async {
        final db =  await instanceDb.database;
        final DateTime now = DateTime.now();
        final DateFormat formatter = DateFormat(' "yyyy-MM-dd" ');
        final String formatted = formatter.format(now);

        final json = achats.toJson();
        const columns =  '${AchatFields.id_poisson},${AchatFields.id_fournisseur},'
            '${AchatFields.prix},${AchatFields.quantite},${AchatFields.date_achat}';
        final values = '${json[AchatFields.id_poisson]},${json[AchatFields.id_fournisseur]},${json[AchatFields.prix]},'
            '${json[AchatFields.quantite]},$formatted';
        try{
           // inserer achat
            final idAChat = await db.rawInsert('insert into  $achat ($columns) values ($values)');
            print('Achat creer avec success!! $idAChat');

            // recuperer quantite Achat
            final result = await db.rawQuery("SELECT quantite FROM achat WHERE id = $idAChat ");
            var quantite ;

            for(int i = 0; i < result.length; i++){
               quantite = result[i]["quantite"];

            }
            // inserer historique
            int idHistorique =
             await _historiqueDao.create_historique(Historique(idAchat: idAChat));

            print( 'date test ${DateTime.parse(DateFormat("yyyy-MM-dd").format(now))}');
            var dateStock = DateTime.parse(DateFormat("yyyy-MM-dd").format(now));
            // inserer stock
            await _stockDao.createStock(Stock(idMouvement: idHistorique,stock: quantite,dateStock:dateStock));
            return achats.copy(id: idAChat);
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
    Future<int> getLastId() async {
        final db = await instanceDb.database;
        int idAchat = 0;
        final id = await db.rawQuery('SELECT max(id) as nombre FROM achat');
        for(int i = 0; i < id.length; i++){
            idAchat = id[i]['nombre'].hashCode;
        }
        print('id achat dans achatDao:  $idAchat');
        return idAchat;

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