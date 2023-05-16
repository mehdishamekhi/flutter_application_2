import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/categoryproduct/category_product_bloc.dart';
import '../bloc/categoryproduct/category_product_event.dart';
import '../bloc/categoryproduct/category_product_state.dart';
import '../constants/colors.dart';
import '../data/model/category.dart';
import '../widgets/item_of_products.dart';

class MostSellingProductScreen extends StatefulWidget {
  final Categories category;
  const MostSellingProductScreen(this.category, {super.key});

  @override
  State<MostSellingProductScreen> createState() =>
      _MostSellingProductScreenState();
}

class _MostSellingProductScreenState extends State<MostSellingProductScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductInitializeEvent(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SafeArea(
          child: BlocBuilder<CategoryProductBloc, CategoryProductState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: <Widget>[
              if (state is CategoryProductLoadingState) ...{
                const SliverToBoxAdapter(
                  child: LinearProgressIndicator(),
                ),
              } else ...{
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                            const Icon(Icons.filter_alt),
                            const SizedBox(
                              width: 120,
                            ),
                            Text(
                              widget.category.title!,
                              style: const TextStyle(
                                fontFamily: 'SM',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: CustomColor.blue,
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              'assets/images/icon_back.png',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (state is CategoryProductResponseState) ...{
                  state.productlist.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (categoryproductlist) {
                    return SliverPadding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ItemOfProducts(categoryproductlist[index]);
                          },
                          childCount: categoryproductlist.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 2 / 2.9,
                        ),
                      ),
                    );
                  })
                }
              }
            ],
          );
        },
      )),
    );
  }
}
