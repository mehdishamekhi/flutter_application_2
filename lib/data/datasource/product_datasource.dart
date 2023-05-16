import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../model/product.dart';

abstract class IProductDatasource {
  Future<List<Products>> getproduct();
  Future<List<Products>> getbestseller();
  Future<List<Products>> gethotest();
}

class ProductRemoteDatasource extends IProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Products>> getproduct() async {
    try {
      var productresponse = await _dio.get('collections/products/records');
      return productresponse.data['items']
          .map<Products>((jsonoject) => Products.fromMapjson(jsonoject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'ex.response!.statusmessage');
    }
  }

  @override
  Future<List<Products>> getbestseller() async {
    try {
      Map<String, String> qparams = {'filter': 'popularity="Best Seller"'};
      var productresponse = await _dio.get(
        'collections/products/records',
        queryParameters: qparams,
      );
      return productresponse.data['items']
          .map<Products>((jsonoject) => Products.fromMapjson(jsonoject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'bestsellerdatasourceerere');
    }
  }

  @override
  Future<List<Products>> gethotest() async {
    try {
      Map<String, String> qparam = {'filter': 'popularity="Hotest"'};
      var producthotestresponse = await _dio.get(
        'collections/products/records',
        queryParameters: qparam,
      );
      return producthotestresponse.data['items']
          .map<Products>((jsonoject) => Products.fromMapjson(jsonoject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'producthotestdatasourceeror');
    }
  }
}
