import 'package:e_commerce/blocs/achat/achat_bloc.dart';
import 'package:e_commerce/blocs/achat/achat_event.dart';
import 'package:e_commerce/blocs/achat/achat_state.dart';
import 'package:e_commerce/blocs/founisseur/fournisseur_bloc.dart';
import 'package:e_commerce/blocs/founisseur/fournisseur_event.dart';
import 'package:e_commerce/blocs/poisson/poisson_bloc.dart';
import 'package:e_commerce/blocs/poisson/poisson_event.dart';
import 'package:e_commerce/blocs/poisson/poisson_state.dart';
import 'package:e_commerce/dao/PoissonDao.dart';
import 'package:e_commerce/dao/fournisseur_dao.dart';
import 'package:e_commerce/models/achat.dart';
import 'package:e_commerce/models/poisson.dart';
import 'package:e_commerce/page/home.dart';
import 'package:e_commerce/services/achat_repository.dart';
import 'package:e_commerce/services/fournisseur_repository.dart';
import 'package:e_commerce/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
/*  AchatRepository repo = AchatRepository();
 int idPoisson = await PoissonDao().getIdByNom("Makoba");
 int idFournisseur = await FournisseurDao().getIdByNom("Sahondra");
 DateTime datezao = DateTime.now();
    var now = new DateTime.now();
    print(DateFormat("yyyy-MM-dd").format(now));
    DateTime dateAchat = DateTime.parse(DateFormat("yyyy-MM-dd").format(now));
    print('date test $dateAchat,type ${dateAchat.runtimeType}');
   String dateFormat = DateFormat(' yyyy-MM-dd hh:mm:ss ').format(datezao) ;

   DateTime datetenaizy = DateTime.parse(dateFormat);

   datezao.rep
  print('test dateTime  $datetenaizy');


  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  print('date formatteeee $formatted'); // something like 2013-04-20

 Achat achat = Achat(
     idPoisson: idPoisson,
     idFournisseur: idFournisseur,
     prix: 3000,
     quantite: 100,
     // dateAchat: dateAchat
 );
 // int p = await repo.getIdByNom("Gogo");
 // print('id $p');
 //
 //  // Poisson poisson = Poisson(nom: "Makoba", image: "image_makoba.png");
  repo.save(achat);*/
  runApp(const MyApp());
 }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
            BlocProvider(create: (context) => PoissonBloc(
                repository: Repository()
               )..add(OnFindAllPoisson())),
            BlocProvider(create: (context) => FournisseurBloc(
                fournisseurRepository: FournisseurRepository()
            )..add(OnFindAllFournisseurs())),
            BlocProvider(create: (context) => AchatBloc(
                achatRepository: AchatRepository()
            )),
        ],
        child: const MaterialApp(
            home: Home(),
        )
    );
  }
}