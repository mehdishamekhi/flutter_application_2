class Products {
  String? categoryid;
  String? collectionId;
  String? description;
  int? discountprice;
  String? id;
  String? name;
  String? popularity;
  int? price;
  int? quantity;
  String? thumbnail;
  int? realprice;
  num? percentprice;
  Products(
    this.categoryid,
    this.collectionId,
    this.description,
    this.discountprice,
    this.id,
    this.name,
    this.popularity,
    this.price,
    this.quantity,
    this.thumbnail,
  ) {
    realprice = price! + discountprice!;
    percentprice = ((price! - realprice!) / price!) * 100;
  }
  factory Products.fromMapjson(Map<String, dynamic> jsonoject) {
    return Products(
      jsonoject['category'],
      jsonoject['collectionId'],
      jsonoject['description'],
      jsonoject['discount_price'],
      jsonoject['id'],
      jsonoject['name'],
      jsonoject['popularity'],
      jsonoject['price'],
      jsonoject['quantity'],
      'http://startflutter.ir/api/files/${jsonoject['collectionId']}/${jsonoject['id']}/${jsonoject['thumbnail']}',
    );
  }
}
