import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../model/banner.dart';

abstract class IBannerDatasource {
  Future<List<BannersList>> getbanners();
}

class BannerRemoteDatasource extends IBannerDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<BannersList>> getbanners() async {
    try {
      var bannerresponse = await _dio.get('collections/banner/records');
      return bannerresponse.data['items']
          .map<BannersList>((jsonobject) => BannersList.frommapjson(jsonobject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'bannerdseror');
    }
  }
}
