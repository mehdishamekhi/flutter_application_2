import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/model/cart_item.dart';
import 'package:flutter_application_2/widgets/cahed_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart';
import '../constants/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SafeArea(child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Stack(
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 44, vertical: 20),
                      child: Container(
                        width: 340,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Image.asset('assets/images/icon_apple_blue.png'),
                              const SizedBox(
                                width: 100,
                              ),
                              const Text(
                                'سبد خرید',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: CustomColor.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state is CartFetchdataState) ...{
                    state.carttiems.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (cartitemlists) {
                        return SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return MostDetailedProductItem(
                              cartitemlists[index],
                            );
                          }, childCount: cartitemlists.length),
                        );
                      },
                    ),
                  },
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 100,
                    ),
                  ),
                ],
              ),
              if (state is CartFetchdataState) ...{
                Positioned(
                  bottom: 20,
                  right: 44,
                  left: 44,
                  child: SizedBox(
                    height: 53,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.green,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        state.cartfinalprice == 0
                            ? 'سبد خرید شما خالیست'
                            : ' ${state.cartfinalprice.toString()} ',
                        style: const TextStyle(
                          fontSize: 26,
                          fontFamily: 'sb',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              }
            ],
          );
        },
      )),
    );
  }
}

class MostDetailedProductItem extends StatelessWidget {
  final CartItems cartitem;
  const MostDetailedProductItem(
    this.cartitem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 44,
        right: 44,
        top: 20,
      ),
      height: 239,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SizedBox(
                        height: 25,
                        width: 200,
                        child: Text(
                          cartitem.name.toString(),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            fontFamily: 'sb',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'گارانتی ۱۸ ماه مدیاپردازش',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'sm',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 25,
                            height: 15,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7.5),
                              ),
                              color: Colors.red,
                            ),
                            child: const Center(
                              child: Text(
                                '٪۳',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'sm',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'تومان',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'sm',
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Text(
                            cartitem.price.toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'sm',
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 24,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.white,
                              border: Border.all(
                                color: CustomColor.grey,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    'سبز کله غازی',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'sm',
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 33, 103, 35),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 24,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.white,
                              border: Border.all(
                                color: CustomColor.grey,
                                width: 1,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ' گیگابایت 256',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'sm',
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15, top: 10),
                          height: 24,
                          width: 62,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white,
                            border: Border.all(
                              color: CustomColor.red,
                              width: 1,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                Text(
                                  'حذف',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'sm',
                                    color: Colors.red,
                                  ),
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                    height: 104,
                    width: 100,
                    child: CachedImage(
                      imageurl: cartitem.thumbnail,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: DottedLine(
              direction: Axis.horizontal,
              lineLength: double.infinity,
              lineThickness: 2.0,
              dashLength: 6.0,
              dashColor: CustomColor.grey,
              dashGapLength: 7.0,
              dashGapColor: Colors.transparent,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'تومان',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'sm',
                  color: Colors.black,
                ),
              ),
              Text(
                cartitem.realprice.toString(),
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'sm',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
