import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category/category_bloc.dart';
import '../bloc/category/category_event.dart';
import '../bloc/category/category_state.dart';
import '../constants/colors.dart';
import '../data/model/category.dart';
import '../widgets/cahed_image.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestEvent());
    super.initState();
  }

  List<Categories>? categorries;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 44, vertical: 20),
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
                          'دسته بندی',
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
            BlocBuilder<CategoryBloc, Categorystate>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return const SliverToBoxAdapter(
                    child: LinearProgressIndicator(),
                  );
                }
                if (state is CategoryResponseState) {
                  return state.getcategories.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (r) {
                      return _CategoryList(
                        categorylist: r,
                      );
                    },
                  );
                }
                return const SliverToBoxAdapter(
                  child: Text('error'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final List<Categories>? categorylist;
  const _CategoryList({this.categorylist});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 44,
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CachedImage(imageurl: categorylist?[index].thumbnail);
          },
          childCount: categorylist?.length ?? 0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
