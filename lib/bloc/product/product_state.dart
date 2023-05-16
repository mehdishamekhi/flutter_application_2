import 'package:dartz/dartz.dart';

import '../../data/model/category.dart';
import '../../data/model/detailed_image.dart';
import '../../data/model/product_variant.dart';
import '../../data/model/property.dart';

abstract class ProductDetailedState {}

class ProductDetailInitState extends ProductDetailedState {}

class ProductLoadingState extends ProductDetailedState {}

class ProductResponseState extends ProductDetailedState {
  Either<String, List<DetailedImage>> getdetailedstate;
  Either<String, List<ProductVariant>> productvairant;
  Either<String, Categories> categorys;
  Either<String, List<Property>> propertylist;
  ProductResponseState(
    this.propertylist,
    this.categorys,
    this.getdetailedstate,
    this.productvairant,
  );
}
