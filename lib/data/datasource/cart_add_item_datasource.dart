import 'package:hive_flutter/hive_flutter.dart';

import '../model/cart_item.dart';

abstract class ICartAddItemDatasource {
  Future<void> addcartitem(CartItems cartiem);
  Future<List<CartItems>> getallcartitems();
  Future<int> getproductfinalprice();
}

class ICartAddItemLocalDatasource extends ICartAddItemDatasource {
  var box = Hive.box<CartItems>('Cardbox');

  @override
  Future<void> addcartitem(CartItems cartiem) async {
    box.add(cartiem);
  }

  @override
  Future<List<CartItems>> getallcartitems() async {
    return box.values.toList();
  }

  @override
  Future<int> getproductfinalprice() async {
    var list = box.values.toList();
    var finalprice = list.fold(
        0, (accumulator, product) => accumulator + product.realprice!);
    return finalprice;
  }
}
