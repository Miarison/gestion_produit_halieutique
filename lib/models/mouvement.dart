final String mouvement = 'mouvement';
final String stock = 'stock';

class MouvementFields{
      static final String id ='_id';
      static final String id_achat = 'id_achat';
      static final String id_vente = 'id_vente';
      static final String quantite = 'quantite';
      static final String date_mouvement = 'date_mouvement';
}
class StockFields {
     static final String id = '_id';
     static final String id_mouvement = 'id_mouvement';
     static final String stock = 'stock';
     static final String date_stock = 'date_stock';
}
class Mouvement {
     late final int id;
     late final int? id_achat;
     late final int? id_vente;
     late final double quantite;
     late final DateTime date_mouvement;

     Mouvement(this.id, this.id_achat, this.id_vente,{ required this.quantite,
      required this.date_mouvement});

}
class Stock{
   late final int id;
   late final int id_mouvement;
   late final double stock ;
   late final DateTime date_stock;

   Stock(this.id, {required this.id_mouvement, required this.stock, required this.date_stock});

}