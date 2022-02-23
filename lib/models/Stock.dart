const String stock = 'stock';

class StockFields {
  static  List<String>  colonneStock = [
     id,idMouvement,stock,dateStock
  ];
  static const String id = '_id';
  static const String idMouvement = 'idMmouvement';
  static const String stock = 'stock';
  static const String dateStock = 'dateStock';
}
class Stock{
   final int? id;
   final int idMouvement;
   final double stock ;
   final DateTime dateStock;

  Stock({ this.id,required this.idMouvement, required this.stock, required this.dateStock });

  Stock copy({
    int? id,
    int? idMouvement,
    double? stock,
    DateTime? dateStock
  }) => Stock(
      id: id ?? this.id,
      idMouvement: idMouvement ?? this.idMouvement,
      stock: stock ?? this.stock,
      dateStock: dateStock ?? this.dateStock
  );
  static Stock fromJson(Map<String,Object?> json) => Stock(
    id: json[StockFields.id] as int?,
    idMouvement: json[StockFields.idMouvement] as int,
    stock: json[StockFields.stock] as double,
    dateStock: json[StockFields.dateStock] as DateTime

  );

  Map<String,Object?> toJson() => {
    StockFields.id: id,
    StockFields.idMouvement: idMouvement,
    StockFields.stock: stock,
    StockFields.dateStock: dateStock

  };
}