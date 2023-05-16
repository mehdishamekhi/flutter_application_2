import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../datasource/product_detailed_datasource.dart';
import '../model/category.dart';
import '../model/detailed_image.dart';
import '../model/product_variant.dart';
import '../model/property.dart';
import '../model/variant.dart';
import '../model/variant_type.dart';

abstract class IDetailedProductRepository {
  Future<Either<String, List<DetailedImage>>> getgalleries(String productid);
  Future<Either<String, List<VariantType>>> getvaraintype();
  Future<Either<String, List<Variants>>> getvariant(String productid);
  Future<Either<String, List<ProductVariant>>> getproductvariant(
      String productid);
  Future<Either<String, Categories>> getcategory(String categoryid);
  Future<Either<String, List<Property>>> getproperties(String productid4);
}

class DetailedProductRepository extends IDetailedProductRepository {
  final IDetailedProductDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<DetailedImage>>> getgalleries(
      String productid) async {
    try {
      var response = await _datasource.getgallery(productid);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'getgalleryrepositoryeror');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getvaraintype() async {
    try {
      var responst = await _datasource.getvarianttypelist();
      return right(responst);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'getvarianttyperepositoryeror');
    }
  }

  @override
  Future<Either<String, List<Variants>>> getvariant(String productid) async {
    try {
      var response = await _datasource.getvariantlist(productid);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'getvariantrepositoryeror');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getproductvariant(
      String productid) async {
    try {
      var response = await _datasource.getproductvariantlist(productid);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'getproductvariantrepositoryeror');
    }
  }

  @override
  Future<Either<String, Categories>> getcategory(String categoryid) async {
    try {
      var response = await _datasource.getcategory(categoryid);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'getcategoryrepositorydetaledscreen');
    }
  }

  @override
  Future<Either<String, List<Property>>> getproperties(
      String productid4) async {
    try {
      var response = await _datasource.getproperty(productid4);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? ' getpropertyrepositoryerore');
    }
  }
}
