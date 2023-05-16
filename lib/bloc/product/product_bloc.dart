import 'package:bloc/bloc.dart';
import 'package:flutter_application_2/bloc/product/product_event.dart';
import 'package:flutter_application_2/bloc/product/product_state.dart';
import 'package:flutter_application_2/data/repository/cart_add_item_repository.dart';

import '../../data/model/cart_item.dart';
import '../../data/repository/product_detailed_repository.dart';
import '../../di/di.dart';

class ProductDetailBloc
    extends Bloc<ProductDetailedEvent, ProductDetailedState> {
  final IDetailedProductRepository _repository = locator.get();
  final ICartAddItemRepository _addItemRepository = locator.get();
  ProductDetailBloc() : super(ProductDetailInitState()) {
    on<ProductDetailInitializeEvent>((event, emit) async {
      emit(ProductLoadingState());
      var response = await _repository.getgalleries(event.productid);
      var productvariant = await _repository.getproductvariant(event.productid);
      var categoryss = await _repository.getcategory(event.categoryid);
      var property = await _repository.getproperties(event.productid);
      emit(ProductResponseState(
        property,
        categoryss,
        response,
        productvariant,
      ));
    });
    on<ProductAddtoCart>((event, emit) {
      var cartitemsbox = CartItems(
        event.product.categoryid,
        event.product.collectionId,
        event.product.discountprice,
        event.product.id,
        event.product.name,
        event.product.price,
        event.product.thumbnail,
      );
      _addItemRepository.addcartitems(cartitemsbox);
    });
  }
}
