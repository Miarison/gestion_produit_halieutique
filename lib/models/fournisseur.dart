import 'package:e_commerce/db/poisson_database.dart';
import 'package:e_commerce/models/poisson.dart';

const String fournisseur ='fournisseur';

class FournisseurFields{
    static final List<String> valeur =[
         id, nom, contact, image
    ];
    static const String id = '_id';
    static const String nom = 'nom';
    static const String contact ='contact';
    static const String image = 'image';
}
class Fournisseur{

    final int? id;
    final String nom;
    final int contact;
    final String image;

    Fournisseur({this.id,required this.nom,required this.contact, required this.image});

    Fournisseur copy ({int? id,String? nom,int? contact,String? image}){
          return  Fournisseur (
            id: id ?? this.id,
            nom: nom ?? this.nom,
            contact: contact?? this.contact,
            image: image ?? this.image
        );
    }


  static Fournisseur fromJson(Map<String,Object?> json) => Fournisseur(
      id: json[FournisseurFields.id] as int?,
      nom: json[FournisseurFields.nom] as String,
      contact: json[FournisseurFields.contact] as int,
      image: json[FournisseurFields.image] as String
     );

    Map<String,Object?> toJson() => {
         FournisseurFields.id: id,
         FournisseurFields.nom: nom,
         FournisseurFields.contact: contact,
         FournisseurFields.image: image,
    };
}

