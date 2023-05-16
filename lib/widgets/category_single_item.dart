import 'package:flutter/material.dart';
import 'package:flutter_application_2/util/extenstions/string_extenstion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/categoryproduct/category_product_bloc.dart';
import '../data/model/category.dart';
import '../screens/most_selling_product_screen.dart';
import 'cahed_image.dart';

class CategorySingleItem extends StatelessWidget {
  final Categories ctegries;
  const CategorySingleItem(
    this.ctegries, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => CategoryProductBloc(),
                child: MostSellingProductScreen(ctegries),
              ),
            ),
          );
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: ShapeDecoration(
                    shadows: [
                      BoxShadow(
                        color: ctegries.color.toString().parsetocolor(),
                        blurRadius: 30,
                        spreadRadius: -10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    color: ctegries.color.toString().parsetocolor(),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Center(
                    child: CachedImage(
                      imageurl: ctegries.icon,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              ctegries.title ?? 'محصول',
              style: const TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
