import 'package:e_commerce/dao/achat_dao.dart';
import 'package:e_commerce/models/achat.dart';

class AchatRepository{
    late final AchatDao achatDao = AchatDao();

    Future<void> save(Achat achat)  async {
         await achatDao.createAchat(achat);
    }
    Future<List<Achat>> getAllAchats() async {
         List<Achat> list = await achatDao.findAllAchats();
         return list;
    }
    Future<Achat> getById(int id) async {
        Achat  achat = await achatDao.findById(id);
        return achat;
    }
    Future<int> getCurrentId() async{
       int id = await achatDao.getLastId();
       return id;
    }
}