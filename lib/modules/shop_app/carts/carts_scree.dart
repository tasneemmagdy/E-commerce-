import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/modules/shop_app/carts/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/carts/cubit/states.dart';
import 'package:shop_app/modules/shop_app/checkout/checkout_screen.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';

class CartsScree extends StatelessWidget {
  const CartsScree({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartsCubit , CartsStates>(
        listener: (context , state){} ,
      builder: (context , state){
          var cubit = CartsCubit.get(context);
          var cart = cubit.cartsModel;

          if (state is CartsLoadingState) {
            return  Center(child: CircularProgressIndicator());
          }

          if (cart == null || cart.products == null || cart.products!.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty 🛒',
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'My Cart',
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
            padding: const EdgeInsets.all(16),
                      separatorBuilder: (_, __) =>  SizedBox(height: 12),
                      itemCount: cart.products!.length,
                      itemBuilder: (context , index){
                        var product = cart.products![index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  product.thumbnail!,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.contain,
                                ),
                              ),
                               SizedBox(
                                   width: 12
                               ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(
                                  product.title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                 SizedBox(
                                height: 6
                                ),
                                Text(
                                  '${product.price} \$',
                                  style:  TextStyle(
                                      color: Colors.blue
                                  ),
                                ),
                                 SizedBox(
                                     height: 6
                                 ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (product.quantity! > 1) {
                                          cubit.updateQuantity(
                                            cartId: cart.id!,
                                            productId: product.id!,
                                            quantity: product.quantity! - 1,
                                          );
                                        }
                                      },
                                      icon:  Icon(
                                          Icons.remove
                                      ),
                                    ),
                                    Text(
                                      product.quantity.toString(),
                                      style: TextStyle(
                                          fontSize: 16
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                        cubit.updateQuantity(
                        productId: product.id!,
                        quantity: product.quantity!+ 1,
                        cartId: cart.id!
                        );
                        },
                                      icon:  Icon(
                                          Icons.add
                                      ),
                                    ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.removeFromCarts(
                                      userId: CasheHelper.getData(key: 'userId'),
                                      productId: product.id!
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 6)
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '${cart.total} \$',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                       SizedBox(
                           height: 12
                       ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            navigateTo(
                                context,
                                CheckoutScreen(cart: CartsCubit.get(context).cartsModel!),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
      },
    );
  }
}