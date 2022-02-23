import 'package:e_commerce/models/Stock.dart';
import 'package:e_commerce/models/achat.dart';
import 'package:e_commerce/models/fournisseur.dart';
import 'package:e_commerce/models/historique.dart';
import 'package:e_commerce/models/poisson.dart';
import 'package:e_commerce/models/vente.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PoissonDatabase{
  static final PoissonDatabase instance = PoissonDatabase();
  Database? _database;
  final String mouvementView = 'mouvementview';
  PoissonDatabase();
  Future<Database> get database async{
    if(_database!= null) {
      return _database!;
    }
    _database = await _initDB('poissonData.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join (dbPath,filePath);

    return await openDatabase(path,version: 1,onCreate: _createDB,onConfigure: _onConfigure);
  }
  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
   Future<void> _createDB(Database db,int newVersion) async{

    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const dateType = 'TIMESTAMP NOT NULL';
    const doubleType ='REAL NOT NULL';
    const idTypeNullable = 'INTEGER';
    const intType = 'INTEGER NOT NULL';

    await db.execute("DROP TABLE IF EXISTS $tablesPoisson");

    await db.execute('''
        CREATE TABLE $tablesPoisson (
            ${PoissonFields.id} $idType,
            ${PoissonFields.nom} $textType,
            ${PoissonFields.image} $textType
        )
       
    ''');
    await db.execute("DROP TABLE IF EXISTS $fournisseur");

    await db.execute('''
         CREATE TABLE $fournisseur(
           ${FournisseurFields.id} $idType,
           ${FournisseurFields.nom} $textType,
           ${FournisseurFields.contact} $intType,
           ${FournisseurFields.image} $textType
        )
    ''');
    await db.execute("DROP TABLE IF EXISTS $achat");

    await db.execute('''
        CREATE TABLE $achat(
           ${AchatFields.id} $idType,
           ${AchatFields.id_poisson} $intType,
           ${AchatFields.id_fournisseur} $intType,
           ${AchatFields.prix} $doubleType,
           ${AchatFields.quantite} $doubleType,
           ${AchatFields.date_achat} $dateType,
           "FOREIGN KEY (${AchatFields.id_poisson}) REFERENCES $tablesPoisson (id) ON DELETE NO ACTION ON UPDATE NO ACTION", 
           "FOREIGN KEY (${AchatFields.id_fournisseur}) REFERENCES $fournisseur (id) ON DELETE NO ACTION ON UPDATE NO ACTION" 
        )
    ''');
    await db.execute("DROP TABLE IF EXISTS $vente");

    await db.execute('''
          CREATE TABLE $vente (
            ${VenteFields.id} $idType,
            ${VenteFields.id_poisson} $intType,
            ${VenteFields.prix} $doubleType,
            ${VenteFields.quantite} $doubleType,
            ${VenteFields.date_vente} $dateType,
            "FOREIGN KEY (${AchatFields.id_poisson}) REFERENCES $tablesPoisson (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
          )
    ''');

    await db.execute("DROP TABLE IF EXISTS historique");
    await db.execute('''
        CREATE TABLE $historique(
          ${HistoriqueFields.id} $idType,
          ${HistoriqueFields.idAchat} $idTypeNullable,
          ${HistoriqueFields.idVente} $idTypeNullable,
       
           "FOREIGN KEY (${HistoriqueFields.idAchat}) REFERENCES $achat (id) ON DELETE NO ACTION ON UPDATE NO ACTION",
           "FOREIGN KEY (${HistoriqueFields.idVente}) REFERENCES $vente (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
        )
    ''');

    await db.execute("DROP TABLE IF EXISTS $stock");
    await db.execute('''
        CREATE TABLE $stock(
          ${StockFields.id} $idType,
          ${StockFields.idMouvement} $intType,
          ${StockFields.stock} $doubleType,
          ${StockFields.dateStock} $dateType,
          "FOREIGN KEY (${StockFields.idMouvement}) REFERENCES $historique (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
        )
     ''');
    await db.execute(''' 
        CREATE VIEW $mouvementView as 
         SELECT historique.*,achat.idPoisson, achat.prix as prix_achat, achat.quantite as quantite_acheter,
          achat.dateAchat ,vente.id_poisson, vente.prix as prix_vente, vente.quantite as quantite_vendu,
          vente.date_vente FROM historique join achat on historique.idAchat = achat.id join 
          vente on historique.idVente = vente.id;
    ''');
  }
  Future close() async {
    final db = await instance.database;
    _database = null;
    db.close();
  }
}


