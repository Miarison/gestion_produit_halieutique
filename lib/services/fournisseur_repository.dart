import 'package:e_commerce/dao/fournisseur_dao.dart';
import 'package:e_commerce/models/fournisseur.dart';

class FournisseurRepository {
    final FournisseurDao _fournisseurDao = FournisseurDao();

    Future<void> createFournisseur(Fournisseur fournisseur) async {
               await  _fournisseurDao.createFournisseur(fournisseur);
    }
    Future<List<Fournisseur>> findAllFournisseurs() async {
          List<Fournisseur> liste = await _fournisseurDao.findAllFournisseurs();
          return liste;
    }
    Future<Fournisseur> getById(int id) async{
          Fournisseur fournisseur = await _fournisseurDao.findById(id);
          return  fournisseur;
    }

    Future<int> findIdByName(String name) async{
         var idFournisseur = await _fournisseurDao.getIdByNom(name);
         return idFournisseur;
    }
}