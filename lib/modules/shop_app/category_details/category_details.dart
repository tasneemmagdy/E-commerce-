import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/models/shop_app/category_model.dart';
import 'package:shop_app/models/shop_app/product_model.dart';
import 'package:shop_app/modules/shop_app/category_details/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/category_details/cubit/states.dart';
import 'package:shop_app/modules/shop_app/product_details/product_details.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryProductsScreen({
    super.key,
    required this.categoryName,
  });


  @override
  Widget build(BuildContext context) {

    var layoutCubit = ShopLayoutCubit.get(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: ShopLayoutCubit.get(context),
        ),
        BlocProvider(
          create: (context) => ShopCategoriesDetailsCubit()..getCategoriesDetails(categoryName),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              categoryName
          ),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: BlocConsumer<ShopCategoriesDetailsCubit, ShopCategoriesDetailsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ShopCategoriesDetailsCubit.get(context);
            if (state is ShopCategoriesDetailsLoadingStates) {
              return GridView.builder(
                padding:  EdgeInsets.all(16),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => buildGridViewShimmer(),
              );
            }
            return GridView.builder(
              padding:  EdgeInsets.all(16),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: cubit.categoriesDetails.length,
              itemBuilder: (context, index) {
                var product = cubit.categoriesDetails[index];
                return InkWell(
                  onTap: () {
                    SystemSound.play(SystemSoundType.click);
                    navigateTo(
                      context,
                      ProductDetailsScreen(product: product),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                  margin:  EdgeInsets.all(4),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                  BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset:  Offset(0, 4),
                  ),
                  ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius:BorderRadius.vertical(
                                top: Radius.circular(16)
                            ),
                            child: Image.network(
                            product.images != null && product.images!.isNotEmpty
                                ? product.images![0]
                                : 'https://via.placeholder.com/300x200/cccccc/000000?text=No+Image',
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                         ],
                      ),
                      Expanded(
                        child: Padding (
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  height: 1.3
                                ),
                              ),
                               SizedBox(
                                   height: 8
                               ),
                              Text(
                                '${(product.price ?? 0.0).toStringAsFixed(2)} \$',
                                style:TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                   Icon(
                                       Icons.star,
                                       color: Colors.amber,
                                       size: 18
                                   ),
                                   SizedBox(
                                       width: 4
                                   ),
                                  Text(
                                    '${(product.rating ?? 0.0).toStringAsFixed(1)}',
                                    style:  TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                   Spacer(),
                                  IconButton(
                                    onPressed: ()
                                    {
                                      ShopLayoutCubit.get(context).changeFavorites(product.id!);
                                      ShopCategoriesDetailsCubit.get(context).updateLocalFavorite(product.id!);
                                    },
                                    icon:  Icon(
                                      product.inFavorites ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

Widget buildGridViewShimmer() => Shimmer.fromColors(
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 16, width: 130, color: Colors.white),
              const SizedBox(height: 8),
              Container(height: 16, width: 90, color: Colors.white),
              const SizedBox(height: 8),
              Container(height: 16, width: 70, color: Colors.white),
            ],
          ),
        ),
      ],
    ),
  ),
);










