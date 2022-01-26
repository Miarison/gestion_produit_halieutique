final String vente = 'vente';

class VenteFields {
  static final List<String> colonneVente =[
    id, id_poisson,prix,quantite,date_vente
  ];
  static final String id ='_id';
  static final String id_poisson ='id_poisson';
  static final String prix = 'prix';
  static final String quantite ='quantite';
  static final String date_vente = 'date_vente';
}
class Vente {
  late int? id;
  late int id_poisson;
  late double prix;
  late double quantite;
  late DateTime? date_vente;

  Vente({
    this.id,
    required this.id_poisson,
    required this.prix,
    required this.quantite,
    this.date_vente
  });

  Vente copy({
    int? id,
    int? idPoisson,
    double? prix,
    double? quantite,
    DateTime? date_vente,
  }) => Vente(
     id: id ?? this.id,
    id_poisson: idPoisson ?? id_poisson,
    prix: prix ?? this.prix,
    quantite: quantite ?? this.quantite,
    date_vente: date_vente ?? this.date_vente,

  );
  static Vente fromJson(Map<String,Object?> json) => Vente(
    id: json[VenteFields.id] as int?,
    id_poisson: json[VenteFields.id_poisson] as int,
    prix: json[VenteFields.prix] as double,
    quantite: json[VenteFields.quantite] as double,
    date_vente: json[VenteFields.date_vente] as DateTime,

  );

  Map<String,Object?> toJson() => {
    VenteFields.id: id,
    VenteFields.id_poisson: id_poisson,
    VenteFields.prix: prix,
    VenteFields.quantite: quantite,
  };

}