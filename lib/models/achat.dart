final  String achat = 'achat';

class AchatFields{
  static final List<String> colonneAchat =[
    id, id_poisson,id_fournisseur,prix,quantite,date_achat
  ];
   static final String id ='id';
   static final String id_poisson = 'idPoisson';
   static final String id_fournisseur ='idFournisseur';
   static final String prix = 'prix';
   static final String quantite = 'quantite';
   static final String  date_achat ='dateAchat';

}
class Achat {
   final int? id;
   final int idPoisson;
   final int idFournisseur;
   final double prix;
   final double quantite;
   final DateTime? dateAchat;
   Achat({
     this.id,
     required this.idPoisson,
     required this.idFournisseur,
     required this.prix,
     required this.quantite,
     this.dateAchat,

   });

   Achat copy({
     int? id,
     int? idPoisson,
     int? idFournisseur,
     double? prix,
     double? quantite,
     DateTime? dateAchat,
   }) => Achat(
       id: id ?? this.id,
       idPoisson: idPoisson ?? this.idPoisson,
       idFournisseur: idFournisseur ?? this.idFournisseur,
       prix: prix ?? this.prix,
       quantite: quantite ?? this.quantite,
       dateAchat: dateAchat ?? this.dateAchat,

   );
   static Achat fromJson(Map<String,Object?> json) => Achat(
       id: json[AchatFields.id] as int?,
       idPoisson: json[AchatFields.id_poisson] as int,
       idFournisseur: json[AchatFields.id_fournisseur] as int,
       prix: json[AchatFields.prix] as double,
       quantite: json[AchatFields.quantite] as double,
       dateAchat: json[AchatFields.date_achat] as DateTime,

   );

   Map<String,Object?> toJson() => {
     AchatFields.id: id,
     AchatFields.id_poisson: idPoisson,
     AchatFields.id_fournisseur: idFournisseur,
     AchatFields.prix: prix,
     AchatFields.quantite: quantite,
     // AchatFields.date_achat : dateAchat,
   };

}