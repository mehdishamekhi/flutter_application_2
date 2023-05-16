import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(
      String username, String password, String passwordconfirm);
  Future<String> login(String username, String password);
}

class AuthenticationRemote extends IAuthenticationDatasource {
  final Dio _dio = locator.get();

  @override
  Future<void> register(
      String username, String password, String passwordconfirm) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'username': username,
        'password': password,
        'passwordConfirm': passwordconfirm,
      });
      print(response.statusCode);
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'register reror');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      final response =
          await _dio.post('collections/users/auth-with-password', data: {
        'identity': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        return response.data['token'];
      }
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'login reror');
    }
    return '';
  }
}
