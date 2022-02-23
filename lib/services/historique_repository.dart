import 'package:e_commerce/dao/historique_dao.dart';
import 'package:e_commerce/models/historique.dart';

class HistoriqueRepository{
    final  historiqueDao = HistoriqueDao();
    
    Future<void> save_historique(Historique historique) async =>
         await historiqueDao.create_historique(historique);
}