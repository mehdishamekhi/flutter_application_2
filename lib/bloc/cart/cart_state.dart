import 'package:dartz/dartz.dart';
import 'package:flutter_application_2/data/model/cart_item.dart';

abstract class CartState {}

class CartInitState extends CartState {}

class CartFetchdataState extends CartState {
  Either<String, List<CartItems>> carttiems;
  int cartfinalprice;
  CartFetchdataState(this.carttiems, this.cartfinalprice);
}
