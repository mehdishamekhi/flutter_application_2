import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../datasource/product_datasource.dart';
import '../model/product.dart';

abstract class IProductRepository {
  Future<Either<String, List<Products>>> getproductlist();
  Future<Either<String, List<Products>>> getproductbestseller();
  Future<Either<String, List<Products>>> getproducthotest();
}

class ProductRepository extends IProductRepository {
  final IProductDatasource _productDatasource = locator.get();

  @override
  Future<Either<String, List<Products>>> getproductlist() async {
    try {
      var productrresponse = await _productDatasource.getproduct();
      return right(productrresponse);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'ProductRepositoryEror');
    }
  }

  @override
  Future<Either<String, List<Products>>> getproductbestseller() async {
    try {
      var bestselresponse = await _productDatasource.getbestseller();
      return right(bestselresponse);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'besselrepositoryeror');
    }
  }

  @override
  Future<Either<String, List<Products>>> getproducthotest() async {
    try {
      var hotestresponse = await _productDatasource.gethotest();
      return right(hotestresponse);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'hotestresponsedatasourceeror');
    }
  }
}
