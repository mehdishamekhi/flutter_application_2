import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../datasource/product_category_datasource.dart';
import '../model/product.dart';

abstract class IProductCategoryRepository {
  Future<Either<String, List<Products>>> getproductcategorylist(
      String productid);
}

class ProductCategoryRepository extends IProductCategoryRepository {
  final IProductCategoryDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Products>>> getproductcategorylist(
      String productid) async {
    try {
      var response = await _datasource.getproductcategorylist(productid);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'productcategoryrepositoryeror');
    }
  }
}
