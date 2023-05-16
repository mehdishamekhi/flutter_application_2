import 'package:dartz/dartz.dart';

import '../../data/model/category.dart';

abstract class Categorystate {}

class CategoryInintState extends Categorystate {}

class CategoryLoadingState extends Categorystate {}

class CategoryResponseState extends Categorystate {
  Either<String, List<Categories>> getcategories;

  CategoryResponseState(this.getcategories);
}
