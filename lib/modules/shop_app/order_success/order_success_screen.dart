import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
             SizedBox(height: 20),
             Text(
              'Order Placed Successfully 🎉',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(
                 height: 10
             ),
             Text(
              'Thank you for shopping with us',
              style: TextStyle(
                  fontSize: 16
              ),
            ),
             SizedBox(
                 height: 30
             ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child:  Text(
                  'Back to Home'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
