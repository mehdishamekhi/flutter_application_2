import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../datasource/banner_datasource.dart';
import '../model/banner.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannersList>>> getbanner();
}

class BannerRepository extends IBannerRepository {
  final IBannerDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<BannersList>>> getbanner() async {
    try {
      var response = await _datasource.getbanners();
      return right(response);
    } on DioError catch (ex) {
      return left(ex.message ?? 'خطای بنر ریپ محتوا ندارد!');
    }
  }
}
