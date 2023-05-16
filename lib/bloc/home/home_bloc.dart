import 'package:bloc/bloc.dart';

import '../../data/repository/banner_repository.dart';
import '../../data/repository/category_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../di/di.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();
  final IProductRepository _productRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeRequestEvent>((event, emit) async {
      emit(
        HomeLoadingState(),
      );
      var response = await _bannerRepository.getbanner();
      var categresponse = await _categoryRepository.getcategories();
      var productresponse = await _productRepository.getproductlist();
      var productbestselresponse =
          await _productRepository.getproductbestseller();
      var producthotestresponse = await _productRepository.getproducthotest();
      emit(
        HomeResponseState(response, categresponse, productresponse,
            productbestselresponse, producthotestresponse),
      );
    });
  }
}
