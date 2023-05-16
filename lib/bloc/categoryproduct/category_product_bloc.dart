import 'package:bloc/bloc.dart';

import '../../data/repository/product_category_repository.dart';
import '../../di/di.dart';
import 'category_product_event.dart';
import 'category_product_state.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  CategoryProductBloc() : super(CategoryProductLoadingState()) {
    final IProductCategoryRepository repository = locator.get();

    on<CategoryProductInitializeEvent>((event, emit) async {
      var productcategory =
          await repository.getproductcategorylist(event.categoryid);
      emit(CategoryProductResponseState(productcategory));
    });
  }
}
