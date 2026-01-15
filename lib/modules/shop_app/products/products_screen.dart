import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/category_model.dart';
import 'package:shop_app/models/shop_app/product_model.dart';
import 'package:shop_app/modules/shop_app/category_details/category_details.dart';
import 'package:shop_app/modules/shop_app/category_details/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/product_details/product_details.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit , ShopLayoutStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return ConditionalBuilder(
            condition: ShopLayoutCubit.get(context).productModel != null &&
                ShopLayoutCubit.get(context).categoryModel.isNotEmpty,
            builder: (context) => productBuilder(
                ShopLayoutCubit.get(context).productModel! ,
              ShopLayoutCubit.get(context).categoryModel,
              context
            ),
            fallback: (context) => productShimmer()
        );
      },
    );
  }

  Widget productBuilder(ProductModel model , List<CategoryModel> categories ,BuildContext context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.products!
              .expand((product) => product.images ?? []).map((e) =>
              Image(
                image: NetworkImage('${e}'),
                width: double.infinity,
                fit: BoxFit.contain,
              ),).toList(),
          options: CarouselOptions(
            height: 250.0,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24.0
                ),
              ),
               SizedBox(
                  height:150 ,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    reverse: false,
                    physics: BouncingScrollPhysics(),
                    itemCount:categories.length ,
                    itemBuilder: (context , index){
                      var category = categories[index];
                      return InkWell(
                        onTap: (){
                          SystemSound.play(SystemSoundType.click);
                          navigateTo(
                            context,
                            CategoryProductsScreen(categoryName: category.name ?? ''),
                          );
                        },
                        child: Stack(
                          
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                              Image.network(
                                category.url?.isNotEmpty == true
                                    ? category.url!
                                    : 'https://via.placeholder.com/120/4F46E5/FFFFFF.png?text=${category.name?[0]}',
                                width: 120,
                                height: 140,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  width: 120, height: 120,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.category, size: 40, color: Colors.grey[600]),
                                ),
                              ),
                            Container(
                              color: Colors.black.withOpacity(0.8),
                              width: 100.0,
                              child: Text(
                                category.name ?? "",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context , index) =>
                    SizedBox(
                      width: 20.0,
                    ),
                  ),
                ),
              Text(
                'New Product',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24.0
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        MasonryGridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: model.products!.length,
          itemBuilder: (context , index) {
            var product = model.products![index];
            return InkWell(
              onTap: ()
              {
                SystemSound.play(SystemSoundType.click);
                navigateTo(
                    context,
                    ProductDetailsScreen(
                        product: product
                    ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            product.images![0],
                            width: double.infinity,
                            height: 180 + (index % 3) * 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                        if ((product.discountPercentage ?? 0) > 0)
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              color: Colors.redAccent,
                              padding:  EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              child:  Text(
                                'DISCOUNT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                     SizedBox(
                         height: 8
                     ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle(
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                     SizedBox(
                         height: 4
                     ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            '${product.price!.round()}',
                            style:  TextStyle(
                                color: Colors.blue
                            ),
                          ),
                           SizedBox(
                               width: 5,
                           ),
                          if ((product.discountPercentage ?? 0) > 0)
                            Text(
                              '${product.discountPercentage!.round()}%',
                              style: TextStyle(
                                  color: Colors.green
                              ),
                            ),
                          Spacer(),
                          IconButton(
                            onPressed: ()
                            {
                              ShopLayoutCubit.get(context).changeFavorites(product.id!);
                            },
                            icon:  Icon(
                              product.inFavorites ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                              size: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(
                         height: 8
                     ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget buildCarouselShimmer() => Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: 250,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

Widget buildGridViewShimmer()=> Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
  child:Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      ),
        SizedBox(
            height: 10
        ),
        Container(
          height: 12,
          width: 100,
          color: Colors.grey.shade300,
        ),
        SizedBox(
            height: 10
        ),
        Container(
          height: 12,
          width: 60,
          color: Colors.grey.shade300,
        ),
        SizedBox(
            height: 10
        ),
      ],
    ),
  ),
);

Widget productShimmer () => SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildCarouselShimmer(),
      ),
      SizedBox(
        height: 20.0,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 8,
            itemBuilder: (context , index) => buildGridViewShimmer()
        ),
      )
    ],
  ),
);