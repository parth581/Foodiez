import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/order_tracking_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery Address
                  const Text(
                    'Delivery Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('JL, Kampung HekerHo. 32'),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Payment Method
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildPaymentMethod('Credit/Debit Card', true),
                  _buildPaymentMethod('PayPal', false),
                  _buildPaymentMethod('Cash on Delivery', false),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Order Summary
                  const Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildOrderSummaryItem('Beef Burger', '\$18.99 x 2', '\$37.98'),
                  _buildOrderSummaryItem('Delivery Fee', '', '\$5.00'),
                  _buildOrderSummaryItem('Taxes', '', '\$4.50'),
                  _buildOrderSummaryItem('Discount', 'Vijay', '-\$2.00'),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  _buildOrderSummaryItem('Total', '', '\$45.48', isTotal: true),
                ],
              ),
            ),
          ),

          // Place Order Button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderTrackingScreen()),
                  );
                },
                child: const Text('Place Order'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(String method, bool isSelected) {
    return ListTile(
      leading: Radio(
        value: isSelected,
        groupValue: true,
        onChanged: (value) {},
      ),
      title: Text(method),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  Widget _buildOrderSummaryItem(String name, String details, String price, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: isTotal
                    ? const TextStyle(fontWeight: FontWeight.bold)
                    : null,
              ),
              if (details.isNotEmpty)
                Text(
                  details,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),
          Text(
            price,
            style: isTotal
                ? const TextStyle(fontWeight: FontWeight.bold)
                : null,
          ),
        ],
      ),
    );
  }
}