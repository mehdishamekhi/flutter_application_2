import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../model/category.dart';
import '../model/detailed_image.dart';
import '../model/product_variant.dart';
import '../model/property.dart';
import '../model/variant.dart';
import '../model/variant_type.dart';

abstract class IDetailedProductDatasource {
  Future<List<DetailedImage>> getgallery(String productid1);
  Future<List<VariantType>> getvarianttypelist();
  Future<List<Variants>> getvariantlist(String productid2);
  Future<List<ProductVariant>> getproductvariantlist(String productid3);
  Future<Categories> getcategory(String categoryid);
  Future<List<Property>> getproperty(String productid4);
}

class DetailedProductRemoteDatasource extends IDetailedProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<DetailedImage>> getgallery(String productid1) async {
    try {
      Map<String, String> qparam = {'filter': 'product_id="$productid1"'};
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qparam);
      return response.data['items']
          .map<DetailedImage>(
              (jsonobject) => DetailedImage.frommapjson(jsonobject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'getgallerydatasourceeror');
    }
  }

  @override
  Future<List<VariantType>> getvarianttypelist() async {
    try {
      var response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VariantType>((jsonobject) => VariantType.frommapjson(jsonobject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'getvarianttypelistdatasourceeror');
    }
  }

  @override
  Future<List<Variants>> getvariantlist(String productid2) async {
    try {
      Map<String, String> qparams = {'filter': 'product_id="$productid2"'};
      var responses = await _dio.get('collections/variants/records',
          queryParameters: qparams);
      return responses.data['items']
          .map<Variants>((jsonject) => Variants.fromMapjson(jsonject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'getvariantdatasourceeror');
    }
  }

  @override
  Future<List<ProductVariant>> getproductvariantlist(String productid3) async {
    var varianttypelist = await getvarianttypelist();
    var variantlist = await getvariantlist(productid3);

    List<ProductVariant> productvarilist = [];
    for (var esmal in varianttypelist) {
      var shahla =
          variantlist.where((element) => element.typeid == esmal.id).toList();
      productvarilist.add(ProductVariant(esmal, shahla));
    }
    return productvarilist;
  }

  @override
  Future<Categories> getcategory(String categoryid) async {
    try {
      Map<String, String> qpara = {'filter': 'id="$categoryid"'};
      var response = await _dio.get('collections/category/records',
          queryParameters: qpara);

      return Categories.fromMapJson(response.data['items'][0]);
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    }
  }

//vbgquqch1pzqgb2
  @override
  Future<List<Property>> getproperty(String productid4) async {
    try {
      Map<String, String> qparams = {'filter': 'product_id="$productid4"'};
      var response = await _dio.get('collections/properties/records',
          queryParameters: qparams);
      return response.data['items']
          .map<Property>((jsonobject) => Property.frommapobject(jsonobject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'getpropertydatasourceereo');
    }
  }
}
