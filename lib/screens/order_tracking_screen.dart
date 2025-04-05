import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/camera_screen.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Tracking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '9:41',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Tracking',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Icon(
                Icons.delivery_dining,
                size: 100,
                color: Color(0xFF00BFA6),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your order is already on its way to you!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text(
              'Delivery Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('JL_Kampung Melon No. 32'),
            const SizedBox(height: 16),
            const Text(
              'Arrive in',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('12 minutes'),
            const SizedBox(height: 16),
            const Text(
              'Bambang Suryana',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('AB 1234 CDE'),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to review screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CameraScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFA6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Submit Review'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: const BorderSide(color: Color(0xFF00BFA6)),
                ),
                child: const Text(
                  'Skip Review',
                  style: TextStyle(color: Color(0xFF00BFA6)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}