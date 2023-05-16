import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/cart/cart_bloc.dart';
import 'package:flutter_application_2/data/model/product.dart';
import 'package:flutter_application_2/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';
import '../screens/detailed_product_screen.dart';
import 'cahed_image.dart';

class ItemOfProducts extends StatelessWidget {
  final Products productlistss;
  const ItemOfProducts(this.productlistss, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider<CartBloc>.value(
                value: locator.get<CartBloc>(),
                child: DetailedProductScreen(productlistss),
              ),
            ),
          );
        },
        child: Container(
          height: 216,
          width: 160,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      top: 10,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: CachedImage(
                          imageurl: productlistss.thumbnail.toString(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          productlistss.name.toString(),
                          maxLines: 1,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            fontFamily: 'sm',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Image.asset(
                        'assets/images/active_fav_product.png',
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 6,
                      child: Container(
                        height: 20,
                        width: 35,
                        decoration: const BoxDecoration(
                          color: CustomColor.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              7.5,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '٪${productlistss.percentprice!.round().toString()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'sb',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 53,
                decoration: const BoxDecoration(
                  color: CustomColor.blue,
                  boxShadow: [
                    BoxShadow(
                      color: CustomColor.blue,
                      blurRadius: 30,
                      spreadRadius: -10,
                      offset: Offset(0, 15),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset(
                          'assets/images/icon_right_arrow_cricle.png',
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productlistss.price.toString(),
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2.2,
                              fontFamily: 'sb',
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            productlistss.realprice.toString(),
                            style: const TextStyle(
                              fontFamily: 'sb',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Text(
                        'تومان',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
