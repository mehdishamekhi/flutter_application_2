import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/cart/cart_bloc.dart';
import 'package:flutter_application_2/bloc/cart/cart_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../constants/colors.dart';
import '../data/model/detailed_image.dart';
import '../data/model/product.dart';
import '../data/model/product_variant.dart';
import '../data/model/property.dart';
import '../data/model/variant.dart';
import '../data/model/variant_type.dart';
import '../widgets/cahed_image.dart';

class DetailedProductScreen extends StatefulWidget {
  final Products product;
  const DetailedProductScreen(this.product, {super.key});

  @override
  State<DetailedProductScreen> createState() => _DetailedProductScreenState();
}

class _DetailedProductScreenState extends State<DetailedProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) {
        var bloc = ProductDetailBloc();
        bloc.add(ProductDetailInitializeEvent(
            widget.product.id!, widget.product.categoryid!));
        return bloc;
      }),
      child: DetailedProductContent(parentwidget: widget),
    );
  }
}

class DetailedProductContent extends StatelessWidget {
  const DetailedProductContent({
    super.key,
    required this.parentwidget,
  });

  final DetailedProductScreen parentwidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: BlocBuilder<ProductDetailBloc, ProductDetailedState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                if (state is ProductLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: LinearProgressIndicator(),
                  ),
                } else ...{
                  if (state is ProductResponseState) ...{
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
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
                                Image.asset(
                                    'assets/images/icon_apple_blue.png'),
                                const SizedBox(
                                  width: 125,
                                ),
                                state.categorys.fold((l) {
                                  return const Text(
                                    'دسته بندی',
                                    style: TextStyle(
                                      fontFamily: 'SM',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: CustomColor.blue,
                                    ),
                                  );
                                }, (categorylist) {
                                  return Text(
                                    categorylist.title ?? 'دستبندی',
                                    style: const TextStyle(
                                      fontFamily: 'SM',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: CustomColor.blue,
                                    ),
                                  );
                                }),
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
                  },
                  SliverToBoxAdapter(
                    child: Text(
                      parentwidget.product.name ?? 'محصول',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'sb',
                      ),
                    ),
                  ),
                  if (state is ProductResponseState) ...[
                    state.getdetailedstate.fold((errormessage) {
                      return SliverToBoxAdapter(
                        child: Text(errormessage),
                      );
                    }, (gallerylist) {
                      return GalleryContect(
                          parentwidget.product.thumbnail, gallerylist);
                    })
                  ],
                  if (state is ProductResponseState) ...{
                    state.productvairant.fold(
                      (errormessage) {
                        return SliverToBoxAdapter(
                          child: Text(errormessage),
                        );
                      },
                      (productvarinatlist) {
                        return Variantgenerator(productvarinatlist);
                      },
                    ),
                  },
                  if (state is ProductResponseState) ...{
                    state.propertylist.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (propertylist) {
                      return _ProductProperty(propertylist);
                    })
                  },
                  ProductDiscription(
                      parentwidget.product.description ?? 'فاقد توضیحات'),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 44, vertical: 20),
                      width: 340,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Image.asset('assets/images/icon_left_categroy.png'),
                            const SizedBox(width: 13),
                            const Text(
                              'مشاهده',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'sb',
                                color: CustomColor.blue,
                              ),
                            ),
                            const Spacer(),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 20,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 35,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 45,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '+10',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'sb'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              ': نظرات کاربران',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'sb',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 44,
                        right: 44,
                        top: 20,
                        bottom: 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 140,
                                height: 47,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: CustomColor.green,
                                ),
                              ),
                              Positioned(
                                top: 5,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 20, sigmaY: 20),
                                    child: Container(
                                      width: 160,
                                      height: 53,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'تومان',
                                              style: TextStyle(
                                                fontFamily: 'sm',
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '17,800,000',
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontFamily: 'sm',
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  '16,989,000',
                                                  style: TextStyle(
                                                    fontFamily: 'sm',
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Container(
                                              height: 15,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(7.5),
                                                ),
                                                color: Colors.red,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  '%5',
                                                  style: TextStyle(
                                                    fontFamily: 'sm',
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Stack(
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 140,
                                height: 47,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: CustomColor.blue,
                                ),
                              ),
                              Positioned(
                                top: 5,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 20, sigmaY: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<ProductDetailBloc>().add(
                                            ProductAddtoCart(
                                                parentwidget.product));
                                        context
                                            .read<CartBloc>()
                                            .add(CartFechHiveEvent());
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 53,
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'افزودن به سبد خرید',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'sb',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProductProperty extends StatefulWidget {
  final List<Property> propertylist;
  const _ProductProperty(
    this.propertylist,
  );

  @override
  State<_ProductProperty> createState() => _ProductPropertyState();
}

class _ProductPropertyState extends State<_ProductProperty> {
  bool _isvisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isvisible = !_isvisible;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 44, vertical: 20),
              width: 340,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(width: 13),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'sb',
                        color: CustomColor.blue,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      ': مشخصات فنی ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'sb',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isvisible,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 44, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.propertylist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            '${widget.propertylist[index].title} : ${widget.propertylist[index].value}',
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'sm', height: 1.8),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDiscription extends StatefulWidget {
  final String proudcuctdiscription;

  const ProductDiscription(this.proudcuctdiscription, {super.key});

  @override
  State<ProductDiscription> createState() => _ProductDiscriptionState();
}

class _ProductDiscriptionState extends State<ProductDiscription> {
  bool _isvisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isvisible = !_isvisible;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 44, vertical: 20),
              width: 340,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(width: 13),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'sb',
                        color: CustomColor.blue,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      ': توضیحات محصول ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'sb',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isvisible,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 44, vertical: 5),
              width: 340,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.proudcuctdiscription,
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'sm', height: 1.8),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Variantgenerator extends StatelessWidget {
  final List<ProductVariant> productvaraint;
  const Variantgenerator(
    this.productvaraint, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        for (var variantcontainer in productvaraint) ...{
          if (variantcontainer.variantslist.isNotEmpty) ...{
            Variantgeneratorchild(variantcontainer)
          }
        }
      ],
    ));
  }
}

class Variantgeneratorchild extends StatelessWidget {
  final ProductVariant productvar;
  const Variantgeneratorchild(this.productvar, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 44, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  productvar.varianttypes.title!,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontFamily: 'SB',
                    fontSize: 15,
                  ),
                ),
              ),
              if (productvar.varianttypes.type == VariantTypeEnum.color) ...{
                Choosecolorvariant(productvar.variantslist)
              },
              if (productvar.varianttypes.type == VariantTypeEnum.storage) ...{
                Choosestoragevariant(productvar.variantslist)
              }
            ],
          ),
        ),
      ],
    );
  }
}

class Choosecolorvariant extends StatefulWidget {
  final List<Variants> variantlist;
  const Choosecolorvariant(this.variantlist, {super.key});

  @override
  State<Choosecolorvariant> createState() => _ChoosecolorvariantState();
}

class _ChoosecolorvariantState extends State<Choosecolorvariant> {
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantlist.length,
          itemBuilder: (BuildContext context, int index) {
            String hex = 'FF${widget.variantlist[index].value}';
            int hexcolor = int.parse(hex, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedindex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    border: (_selectedindex == index)
                        ? Border.all(
                            color: CustomColor.blue,
                            width: 3,
                          )
                        : Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(hexcolor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Choosestoragevariant extends StatefulWidget {
  final List<Variants> variantlist;
  const Choosestoragevariant(this.variantlist, {super.key});

  @override
  State<Choosestoragevariant> createState() => _ChoosestoragevariantState();
}

class _ChoosestoragevariantState extends State<Choosestoragevariant> {
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantlist.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedindex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 77,
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  border: (_selectedindex == index)
                      ? Border.all(
                          color: CustomColor.blue,
                          width: 3,
                        )
                      : Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                ),
                child: Center(
                  child: Text(
                    widget.variantlist[index].value!,
                    style:
                        const TextStyle(color: Colors.black, fontFamily: 'sm'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GalleryContect extends StatefulWidget {
  final List<DetailedImage> gallerylist;
  final String? defaultimageurl;
  const GalleryContect(
    this.defaultimageurl,
    this.gallerylist, {
    super.key,
  });

  @override
  State<GalleryContect> createState() => _GalleryContectState();
}

class _GalleryContectState extends State<GalleryContect> {
  int imgeindex = 0;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 44,
          vertical: 20,
        ),
        child: Container(
          height: 284,
          width: 340,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                spreadRadius: -7,
                color: Colors.grey,
                offset: Offset(0, 15),
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            color: Colors.white,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_star.png'),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      '4.6',
                      style: TextStyle(fontFamily: 'sb'),
                    ),
                    const Spacer(),
                    Image.asset('assets/images/icon_favorite_deactive.png'),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                child: SizedBox(
                  height: 170,
                  width: 170,
                  child: CachedImage(
                    imageurl: (widget.gallerylist.isNotEmpty)
                        ? widget.gallerylist[imgeindex].image
                        : widget.defaultimageurl,
                  ),
                ),
              ),
              if (widget.gallerylist.isNotEmpty) ...{
                Positioned(
                  bottom: 30,
                  left: 30,
                  right: 30,
                  child: SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.gallerylist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              imgeindex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.all(5),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                width: 1,
                                color: CustomColor.grey,
                              ),
                            ),
                            child: CachedImage(
                              imageurl: widget.gallerylist[index].image,
                              radius: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
