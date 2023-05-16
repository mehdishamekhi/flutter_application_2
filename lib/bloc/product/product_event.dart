import 'package:flutter_application_2/data/model/product.dart';

abstract class ProductDetailedEvent {}

class ProductDetailInitializeEvent extends ProductDetailedEvent {
  String productid;
  String categoryid;
  ProductDetailInitializeEvent(this.productid, this.categoryid);
}

class ProductAddtoCart extends ProductDetailedEvent {
  Products product;
  ProductAddtoCart(this.product);
}
