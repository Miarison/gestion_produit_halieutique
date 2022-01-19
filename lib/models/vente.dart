final String vente = 'vente';

class VenteFields {
  static final String id ='_id';
  static final String id_poisson ='id_poisson';
  static final String prix = 'prix';
  static final String quantite ='quantite';
  static final String date_vente = 'date_vente';
}
class Vente {
  late int id;
  late int id_poisson;
  late double prix;
  late double quantite;
  late DateTime date_vente;

  Vente({ required this.id_poisson, required this.prix,required this.quantite, required this.date_vente});
}