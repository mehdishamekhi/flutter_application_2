import 'package:dartz/dartz.dart';

import '../../data/model/product.dart';

abstract class CategoryProductState {}

class CategoryProductLoadingState extends CategoryProductState {}

class CategoryProductResponseState extends CategoryProductState {
  Either<String, List<Products>> productlist;
  CategoryProductResponseState(this.productlist);
}
