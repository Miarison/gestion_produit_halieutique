
const String historique ='historique';

class HistoriqueFields{
      static final List<String> colonneHistorique = [
         id,idAchat,idVente
      ];
      static const String id = 'id';
      static const String idAchat = 'idAchat';
      static const String idVente = 'idVente';
}

class Historique {
    int? id;
    int? idAchat;
    int? idVente;

    Historique({this.id, this.idAchat,this.idVente});

    Historique copy({int? id, int? id_achat, int? id_vente})=> Historique(
              id: id ?? this.id,
              idAchat: id_achat ?? idAchat,
              idVente: id_vente ?? idVente,

    );

    static Historique fromJson(Map<String,Object?> json) => Historique(
           id: json[HistoriqueFields.id] as int?,
           idAchat: json[HistoriqueFields.idAchat] as int?,
           idVente:  json[HistoriqueFields.idVente] as int?,
    );
      Map<String,Object?> toJson() => {
          HistoriqueFields.id: id,
          HistoriqueFields.idAchat: idAchat,
          HistoriqueFields.idVente:idVente
      };
}