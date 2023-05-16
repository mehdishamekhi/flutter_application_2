import 'package:dartz/dartz.dart';

import '../../data/model/banner.dart';
import '../../data/model/category.dart';
import '../../data/model/product.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<BannersList>> getbanner;
  Either<String, List<Categories>> getcategories;
  Either<String, List<Products>> getproducts;
  Either<String, List<Products>> getbestseller;
  Either<String, List<Products>> gethotest;
  HomeResponseState(this.getbanner, this.getcategories, this.getproducts,
      this.getbestseller, this.gethotest);
}
