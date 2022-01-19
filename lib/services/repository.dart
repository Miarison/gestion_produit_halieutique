import 'package:e_commerce/dao/PoissonDao.dart';
import 'package:e_commerce/models/poisson.dart';

class Repository{
  final poissonApi = PoissonDao();

  Future<List<Poisson>> fetchAllPoissons() async =>
    await  poissonApi.findAllPoissons();

  Future<Poisson> findPoissonById(int id) async  =>
      await poissonApi.findPoissonById(id);

  Future<void> save(Poisson poisson) async =>
      await poissonApi.create_poisson(poisson);

  Future<int> remove(int id) async =>
      await poissonApi.deletePoisson(id);

  Future<int> getIdByNom(String nom) async =>
      await poissonApi.getIdByNom(nom);
}