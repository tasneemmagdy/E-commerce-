import 'package:flutter/material.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/models/shop_app/carts_model.dart';
import 'package:shop_app/modules/shop_app/carts/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/order_success/order_success_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final CartsModel cart;
  const CheckoutScreen({super.key, required this.cart});
  @override
  Widget build(BuildContext context) {
    final cartCubit = CartsCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(
            'Checkout'
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Address',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding:  EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow:  [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4
                  )
                ],
              ),
              child: Text(
                'Cairo, Egypt\nStreet 10, Building 5',
              ),
            ),
              SizedBox(
                  height: 20
              ),
            Text(
              'Order Summary',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
                height: 10
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartCubit.cartsModel!.products!.length,
                itemBuilder: (context, index) {
                  final item = cartCubit.cartsModel!.products![index];
                  return ListTile(
                    title: Text(item.title!),
                    subtitle: Text(
                      'Qty: ${item.quantity}',
                    ),
                    trailing: Text(
                      '${item.price! * item.quantity!} \$',
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                Text(
                  '${cartCubit.cartsModel!.total!} \$',
                  style:  TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ],
            ),
                SizedBox(
                    height: 16
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      cartCubit.clearCart();
                      navigateTo(
                          context,
                          OrderSuccessScreen(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    child: Text(
                      'Confirm Order',
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
            ),

          ],
        ),
      ),
    );

  }
}
