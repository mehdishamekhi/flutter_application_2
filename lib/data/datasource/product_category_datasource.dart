import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../model/product.dart';

abstract class IProductCategoryDatasource {
  Future<List<Products>> getproductcategorylist(String productid);
}

class ProductCategoryRemoteDatasource extends IProductCategoryDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Products>> getproductcategorylist(String productid) async {
    try {
      Map<String, String> qparams = {'filter': 'category="$productid"'};
      Response<dynamic> response;
      if (productid == '78q8w901e6iipuk') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: qparams);
      }
      return response.data['items']
          .map<Products>((jsonoject) => Products.fromMapjson(jsonoject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'productcategorydatasourceeror');
    }
  }
}
