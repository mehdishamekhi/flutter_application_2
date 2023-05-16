import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../constants/colors.dart';
import '../data/model/banner.dart';
import '../data/model/category.dart';
import '../data/model/product.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_single_item.dart';
import '../widgets/item_of_products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeRequestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: <Widget>[
                const _SearchBar(),
                if (state is HomeLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: LinearProgressIndicator(),
                  ),
                } else ...{
                  if (state is HomeResponseState) ...[
                    state.getbanner.fold((errormessage) {
                      return SliverToBoxAdapter(
                        child: Text(errormessage),
                      );
                    }, (bannerlist) {
                      return _BannerSlider(bannerlist);
                    })
                  ],
                  const _CategoryTitle(),
                  if (state is HomeResponseState) ...[
                    state.getcategories.fold((errormessage) {
                      return SliverToBoxAdapter(
                        child: Text(errormessage),
                      );
                    }, (categorylists) {
                      return _Categorylist(categorylists);
                    })
                  ],
                  const _TheMosSellTitle(),
                  if (state is HomeResponseState) ...[
                    state.getbestseller.fold((errormessage) {
                      return SliverToBoxAdapter(
                        child: Text(errormessage),
                      );
                    }, (bestsellist) {
                      return _TheMostSellList(bestsellist);
                    }),
                  ],
                  const _TheMostViewTitle(),
                  if (state is HomeResponseState) ...[
                    state.gethotest.fold((errormessage) {
                      return SliverToBoxAdapter(
                        child: Text(errormessage),
                      );
                    }, (hotestlist) {
                      return _TheMosViewList(hotestlist);
                    })
                  ],
                }
              ],
            );
          },
        )),
      ),
    );
  }
}

class _TheMosViewList extends StatelessWidget {
  final List<Products> getproduct;
  const _TheMosViewList(this.getproduct);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 230,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: getproduct.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemOfProducts(getproduct[index]);
          },
        ),
      ),
    );
  }
}

class _TheMostViewTitle extends StatelessWidget {
  const _TheMostViewTitle();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 25),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            const Text(
              'پر بازدید ترین ها',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 16,
                color: CustomColor.grey,
              ),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                  fontFamily: 'SM',
                  fontSize: 16,
                  color: CustomColor.blue,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/images/icon_left_categroy.png',
            ),
          ],
        ),
      ),
    );
  }
}

class _TheMostSellList extends StatelessWidget {
  final List<Products> productlist;
  const _TheMostSellList(this.productlist);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 230,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productlist.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemOfProducts(productlist[index]);
          },
        ),
      ),
    );
  }
}

class _TheMosSellTitle extends StatelessWidget {
  const _TheMosSellTitle();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 25),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            const Text(
              'پرفروش ترین ها',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 16,
                color: CustomColor.grey,
              ),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(
                  fontFamily: 'SM',
                  fontSize: 16,
                  color: CustomColor.blue,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/images/icon_left_categroy.png',
            ),
          ],
        ),
      ),
    );
  }
}

class _Categorylist extends StatelessWidget {
  final List<Categories> categlist;
  const _Categorylist(this.categlist);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        right: 44,
      ),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categlist.length,
            itemBuilder: (BuildContext context, int index) {
              return CategorySingleItem(categlist[index]);
            },
          ),
        ),
      ),
    );
  }
}

class _CategoryTitle extends StatelessWidget {
  const _CategoryTitle();

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.only(
        right: 44,
        top: 32,
        bottom: 20,
      ),
      sliver: SliverToBoxAdapter(
        child: Text(
          'دسته بندی',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'SM',
            fontSize: 16,
            color: CustomColor.grey,
          ),
        ),
      ),
    );
  }
}

class _BannerSlider extends StatelessWidget {
  final List<BannersList> bannerlist;
  const _BannerSlider(this.bannerlist);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: BannerSlider(bannerlist),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 44, vertical: 32),
      sliver: SliverToBoxAdapter(
        child: SearchBar(),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Image.asset('assets/images/icon_search.png'),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'جستچوی محصولات',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 16,
                color: CustomColor.grey,
              ),
            ),
            const Spacer(),
            Image.asset('assets/images/icon_apple_blue.png'),
          ],
        ),
      ),
    );
  }
}
