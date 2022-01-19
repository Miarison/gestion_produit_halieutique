import 'package:e_commerce/models/achat.dart';
import 'package:e_commerce/models/fournisseur.dart';
import 'package:e_commerce/models/mouvement.dart';
import 'package:e_commerce/models/poisson.dart';
import 'package:e_commerce/models/vente.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PoissonDatabase{
  static final PoissonDatabase instance = PoissonDatabase();
  Database? _database;
  PoissonDatabase();
  Future<Database> get database async{
     if(_database!= null) {
       return _database!;
     }
     _database = await _initDB('poisson.db');

     return _database!;
  }
  Future<Database> _initDB(String filePath) async {
      final dbPath = await getDatabasesPath();
      final path = join (dbPath,filePath);

      return await openDatabase(path,version: 3,onCreate: _createDB,onConfigure: _onConfigure,onUpgrade: _onUpgrade,onDowngrade: onDatabaseDowngradeDelete);
  }
  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
  Future _createDB (Database db, int version) async{

    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const dateType = 'TIMESTAMP NOT NULL';
    const doubleType ='REAL NOT NULL';
    const idTypeNullable = 'INTEGER';


    await db.execute('''

        CREATE TABLE $tablesPoisson (
            ${PoissonFields.id} $idType,
            ${PoissonFields.nom} $textType,
            ${PoissonFields.image} $textType
        )
       
    ''');
    await db.execute('''
         CREATE TABLE $fournisseur(
           ${FournisseurFields.id} $idType,
           ${FournisseurFields.nom} $textType,
           ${FournisseurFields.contact} $idTypeNullable,
           ${FournisseurFields.image} $textType
        )
    ''');
    await db.execute('''
        CREATE TABLE $achat(
           ${AchatFields.id} $idType,
           ${AchatFields.id_poisson} $textType,
           ${AchatFields.id_fournisseur} $textType,
           ${AchatFields.prix} $doubleType,
           ${AchatFields.quantite} $doubleType,
           ${AchatFields.date_achat} $dateType,
           "FOREIGN KEY (${AchatFields.id_poisson}) REFERENCES $tablesPoisson (id) ON DELETE NO ACTION ON UPDATE NO ACTION," 
           "FOREIGN KEY (${AchatFields.id_fournisseur}) REFERENCES $fournisseur (id) ON DELETE NO ACTION ON UPDATE NO ACTION" 
        )
    ''');
    await db.execute('''
          CREATE TABLE $vente (
            ${VenteFields.id} $idType,
            ${VenteFields.id_poisson} $idTypeNullable,
            ${VenteFields.prix} $doubleType,
            ${VenteFields.quantite} $doubleType,
            ${VenteFields.date_vente} $dateType,
            "FOREIGN KEY (${AchatFields.id_poisson}) REFERENCES $tablesPoisson (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
          )
    ''');
    await db.execute('''
        CREATE TABLE $mouvement(
          ${MouvementFields.id} $idType,
          ${MouvementFields.id_achat} $idTypeNullable,
          ${MouvementFields.id_vente} $idTypeNullable,
          ${MouvementFields.quantite} $doubleType,
          ${MouvementFields.date_mouvement} $dateType,
           "FOREIGN KEY (${MouvementFields.id_achat}) REFERENCES $achat (id) ON DELETE NO ACTION ON UPDATE NO ACTION," 
           "FOREIGN KEY (${MouvementFields.id_vente}) REFERENCES $vente (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
        )
    ''');
    await db.execute('''
        CREATE TABLE $stock(
          ${StockFields.id} $idType,
          ${StockFields.id_mouvement} $idTypeNullable,
          ${StockFields.stock} $doubleType,
          ${StockFields.date_stock} $dateType,
          "FOREIGN KEY (${StockFields.id_mouvement}) REFERENCES $mouvement (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
        )
     ''');
  }
  Future<void> _onUpgrade(Database db, int oldVersion,int newVersion) async{

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

    await db.execute("DROP TABLE IF EXISTS $mouvement");
    await db.execute('''
        CREATE TABLE $mouvement(
          ${MouvementFields.id} $idType,
          ${MouvementFields.id_achat} $idTypeNullable,
          ${MouvementFields.id_vente} $idTypeNullable,
          ${MouvementFields.quantite} $doubleType,
          ${MouvementFields.date_mouvement} $dateType,
           "FOREIGN KEY (${MouvementFields.id_achat}) REFERENCES $achat (id) ON DELETE NO ACTION ON UPDATE NO ACTION", 
           "FOREIGN KEY (${MouvementFields.id_vente}) REFERENCES $vente (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
        )
    ''');

    await db.execute("DROP TABLE IF EXISTS $stock");
    await db.execute('''
        CREATE TABLE $stock(
          ${StockFields.id} $idType,
          ${StockFields.id_mouvement} $intType,
          ${StockFields.stock} $doubleType,
          ${StockFields.date_stock} $dateType,
          "FOREIGN KEY (${StockFields.id_mouvement}) REFERENCES $mouvement (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
        )
     ''');
  }
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}