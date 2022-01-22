import 'package:e_commerce/db/poisson_database.dart';

const String tablesPoisson = 'poissons';

class PoissonFields{
    static final List<String> values =[
        id, nom, image
    ];
    static const String id = 'id';
    static const String nom = 'nom';
    static const String image ='image';
}

class Poisson{
   final  int? id;
   final String nom;
   final String image;

  Poisson({this.id,required this.nom, required this.image});

   Poisson copy ({
     int? id,
     String? nom,
     String?image,
}) => Poisson(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      image: image ?? this.image,
   );
  static Poisson fromJson(Map<String, Object?> json) => Poisson(
      id: json[PoissonFields.id] as int?,
      nom: json[PoissonFields.nom] as String,
      image: json[PoissonFields.image] as String,
  );
       

   Map<String,Object?> toJson() => {
     PoissonFields.id: id,
     PoissonFields.nom: nom,
     PoissonFields.image : image,
   };
   
}
