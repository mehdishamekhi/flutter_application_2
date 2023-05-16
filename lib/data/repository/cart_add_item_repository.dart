import 'package:dartz/dartz.dart';
import 'package:flutter_application_2/data/datasource/cart_add_item_datasource.dart';
import 'package:flutter_application_2/data/model/cart_item.dart';
import 'package:flutter_application_2/di/di.dart';

abstract class ICartAddItemRepository {
  Future<Either<String, String>> addcartitems(CartItems cartitem);
  Future<Either<String, List<CartItems>>> addallcartitems();
  Future<int> getfinalprice();
}

class CartAddItemRepository extends ICartAddItemRepository {
  ICartAddItemDatasource datasource = locator.get();
  @override
  Future<Either<String, String>> addcartitems(CartItems cartitem) async {
    try {
      datasource.addcartitem(cartitem);
      return right('محصول با موفقیت اضافه شد');
    } catch (ex) {
      return left('خطا در اضافه کردن محصول');
    }
  }

  @override
  Future<Either<String, List<CartItems>>> addallcartitems() async {
    try {
      var basketitemlist = await datasource.getallcartitems();
      return right(basketitemlist);
    } catch (ex) {
      return left('خطا در نمایش محصولات');
    }
  }

  @override
  Future<int> getfinalprice() {
    return datasource.getproductfinalprice();
  }
}
