import 'package:e_commerce/dao/vente_dao.dart';
import 'package:e_commerce/models/vente.dart';

class VenteRepository {
    final venteDao = VenteDao();

    Future<void> save(Vente vente) async {
          await venteDao.createVente(vente);
    }
    Future <List<Vente>> getAllVente() async {
        List<Vente>  liste = await venteDao.findAllVente();
        return liste ;
    }
}