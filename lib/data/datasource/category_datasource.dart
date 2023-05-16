import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../model/category.dart';

abstract class ICategoryDatasource {
  Future<List<Categories>> getcategories();
}

class CategoryRemoteDatasource extends ICategoryDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Categories>> getcategories() async {
    try {
      var categoryresponse = await _dio.get('collections/category/records');

      return categoryresponse.data['items']
          .map<Categories>((jsonobject) => Categories.fromMapJson(jsonobject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'categoryrds reror');
    }
  }
}
