import 'package:dio/dio.dart';
import 'package:flutter_application_2/bloc/cart/cart_bloc.dart';
import 'package:flutter_application_2/data/datasource/cart_add_item_datasource.dart';
import 'package:flutter_application_2/data/repository/cart_add_item_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasource/authentication_datasource.dart';
import '../data/datasource/banner_datasource.dart';
import '../data/datasource/category_datasource.dart';
import '../data/datasource/product_category_datasource.dart';
import '../data/datasource/product_datasource.dart';
import '../data/datasource/product_detailed_datasource.dart';
import '../data/repository/authentication_repository.dart';
import '../data/repository/banner_repository.dart';
import '../data/repository/category_repository.dart';
import '../data/repository/product_category_repository.dart';
import '../data/repository/product_detailed_repository.dart';
import '../data/repository/product_repository.dart';

var locator = GetIt.instance;

Future<void> GetItInit() async {
  //componenets
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'http://startflutter.ir/api/',
      ),
    ),
  );
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  // datasource
  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICategoryDatasource>(() => CategoryRemoteDatasource());
  locator.registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());
  locator.registerFactory<IProductDatasource>(() => ProductRemoteDatasource());
  locator.registerFactory<IDetailedProductDatasource>(
      () => DetailedProductRemoteDatasource());
  locator.registerFactory<IProductCategoryDatasource>(
      () => ProductCategoryRemoteDatasource());
  locator.registerFactory<ICartAddItemDatasource>(
      () => ICartAddItemLocalDatasource());
  //repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
  locator.registerFactory<IDetailedProductRepository>(
      () => DetailedProductRepository());
  locator.registerFactory<IProductCategoryRepository>(
      () => ProductCategoryRepository());
  locator
      .registerFactory<ICartAddItemRepository>(() => CartAddItemRepository());

  //bloc
  locator.registerSingleton<CartBloc>(CartBloc());
}
