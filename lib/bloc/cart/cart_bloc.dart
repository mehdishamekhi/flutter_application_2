import 'package:bloc/bloc.dart';
import 'package:flutter_application_2/bloc/cart/cart_state.dart';
import 'package:flutter_application_2/data/repository/cart_add_item_repository.dart';
import 'package:flutter_application_2/di/di.dart';

import 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitState()) {
    ICartAddItemRepository repository = locator.get();
    on<CartFechHiveEvent>((event, emit) async {
      var cartlist = await repository.addallcartitems();
      var finalprice = await repository.getfinalprice();
      emit(CartFetchdataState(cartlist, finalprice));
    });
  }
}
