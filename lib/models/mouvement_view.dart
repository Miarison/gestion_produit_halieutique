class MouvementView {

   late int? id;

   late int idAchat;

   late  int idVente;

   final  double prixAchat;

   final  double prixVente;

   final double quantiteAcheter;

   final double quantiteVendu;

   final DateTime dateVente;

   final DateTime dateAchat;

  MouvementView({
          this.id,
       required this.idAchat,
       required this.prixAchat,
       required this.prixVente,
       required this.quantiteAcheter,
       required this.quantiteVendu,
       required this.dateAchat,
       required this.dateVente
  });


}