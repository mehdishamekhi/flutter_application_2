import 'package:bloc/bloc.dart';

import '../../data/repository/category_repository.dart';
import '../../di/di.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, Categorystate> {
  final ICategoryRepository _repository = locator.get();
  CategoryBloc() : super(CategoryInintState()) {
    on<CategoryRequestEvent>(
      (event, emit) async {
        emit(CategoryLoadingState());
        var response = await _repository.getcategories();
        emit(
          CategoryResponseState(response),
        );
      },
    );
  }
}
