import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/product_details/product_details.dart';

import '../../../component/components.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/product_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopLayoutCubit, ShopLayoutStates>(
      builder: (context, state){
        var cubit = ShopLayoutCubit.get(context);

        List<ProductsDataModel> favoriteProducts = cubit.productModel!.products!
            .where((product) => product.inFavorites)
            .toList() ??
            [];
        if (favoriteProducts.isEmpty) {
          return const Center(
            child: Text(
              'No favorites yet!',
              style: TextStyle(fontSize: 18),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context , index){
                var product = favoriteProducts[index];
                return InkWell(
                  onTap: (){
                    SystemSound.play(SystemSoundType.click);
                    navigateTo(context, ProductDetailsScreen(product: product));
                    },
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.0,
                              offset: Offset(0 , 4)
                          )
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            product.images != null && product.images!.isNotEmpty
                                ? product.images![0]
                                : 'https://via.placeholder.com/300x200/cccccc/000000?text=No+Image',
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    '${(product.price ?? 0.0).toStringAsFixed(2)} \$',
                                    style:  TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue
                                    ),
                                  ),
                                  SizedBox(
                                      height: 8
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cubit.changeFavorites(product.id!);
                                          },
                                        icon: Icon(
                                          product.inFavorites ? Icons.favorite : Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                );
              }
              ),
        );
        },
    );


  }
}
