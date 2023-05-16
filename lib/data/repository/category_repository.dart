import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../datasource/category_datasource.dart';
import '../model/category.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Categories>>> getcategories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Categories>>> getcategories() async {
    try {
      var categoryresponse = await _datasource.getcategories();
      return right(categoryresponse);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
