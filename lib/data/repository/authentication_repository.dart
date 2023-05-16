import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../../util/auth_manager.dart';
import '../datasource/authentication_datasource.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordconfrim);
  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository extends IAuthRepository {
  final IAuthenticationDatasource _datasource = locator.get();
  final SharedPreferences _sharepref = locator.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordconfrim) async {
    try {
      await _datasource.register('mehdishamekhiiiii', '12345678', '12345678');
      return right('ثبت نام با موفقیت انجام شد');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطاییin register repository رخ داد');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.savetoken(token);
        return right('شما با موفقیت وارد شده اید');
      } else {
        return left('خطا در login repository');
      }
    } on ApiException catch (ex) {
      return left(ex.message ?? 'login repositoryخطا در ');
    }
  }
}
