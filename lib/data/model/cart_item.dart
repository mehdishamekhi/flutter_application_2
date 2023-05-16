import 'package:hive/hive.dart';
part 'cart_item.g.dart';

@HiveType(typeId: 0)
class CartItems {
  @HiveField(0)
  String? categoryid;
  @HiveField(1)
  String? collectionId;
  @HiveField(2)
  int? discountprice;
  @HiveField(3)
  String? id;
  @HiveField(4)
  String? name;
  @HiveField(5)
  int? price;
  @HiveField(6)
  String? thumbnail;
  @HiveField(7)
  int? realprice;
  @HiveField(8)
  num? percentprice;

  CartItems(
    this.categoryid,
    this.collectionId,
    this.discountprice,
    this.id,
    this.name,
    this.price,
    this.thumbnail,
  ) {
    realprice = price! + discountprice!;
    percentprice = ((price! - realprice!) / price!) * 100;
  }
}
