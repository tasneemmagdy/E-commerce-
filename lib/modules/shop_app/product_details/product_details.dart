import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/product_model.dart';
import 'package:shop_app/modules/shop_app/carts/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/checkout/checkout_screen.dart';
import 'package:shop_app/modules/shop_app/order_success/order_success_screen.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductsDataModel product;
  const ProductDetailsScreen({super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context , index){},
      builder: (context , index)
      {
        var cubit = ShopLayoutCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            title: Text(
              product.title ?? 'Product',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      " Brand : ${product.category}  "" ",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF0047AB)
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              product.images!.first,
                            ),
                            fit: BoxFit.contain
                        )
                    ),
                    width: double.infinity,
                    height: 300.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                              fontSize: 22.0
                          ),
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
                  SizedBox(
                    height: 0,
                  ),
                  Text(
                    product.brand ?? "",
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "${product.price!.round()} \$",
                        style:TextStyle(
                            fontSize: 18.0,
                            // fontWeight: FontWeight.bold,
                            color: Colors.blue
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if ((product.discountPercentage ?? 0) > 0)
                        Text(
                          '-${product.discountPercentage!.round()} %',
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.red,
                          ),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    product.description ?? "No description available",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                          'Delivary : '
                      ),
                      Text(
                        product.shippingInformation ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'In Stock : ${product.stock}' ,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16.0
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: ()
                    {
                      CartsCubit.get(context).addToCarts(
                          userId: CasheHelper.getData(key: 'userId'),
                          productId: product.id!,
                          productQuantity: 1
                      );
                    },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.amber),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        var cart = CartsCubit.get(context).cartsModel;
                        if (cart != null && cart.products != null && cart.products!.isNotEmpty) {
                          navigateTo(
                            context,
                            CheckoutScreen(cart: cart),
                          );
                        } else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Your cart is empty!'
                                ),
                                duration: Duration(
                                    seconds: 2
                                ),
                              )
                          );
                        }
                      },
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 20,
                  ),
                  Text(
                    'Reviews',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                      'Rate : ${product.rating!.round()}'
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: product.reviews!.length,
                    itemBuilder: (context,index){
                      var reviews = product.reviews![index];
                      return Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    reviews.reviewerName ?? ""
                                ),
                                Text(
                                    reviews.reviewerEmail ?? ""
                                ),
                                Icon(
                                    Icons.star,
                                    color: Colors.orange
                                ),
                                Text(
                                  reviews.rating.toString(),
                                  style: TextStyle(
                                      color: Colors.orange
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 5
                            ),
                            Text(
                                reviews.comment ?? ""
                            ),
                            Text(
                                reviews.date ?? ""
                            ),

                          ],
                        ),
                      );

                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
