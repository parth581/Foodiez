import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'restaurant_screen.dart';

class NearMeScreen extends StatefulWidget {
  final String? address;
  
  const NearMeScreen({super.key, this.address});

  @override
  State<NearMeScreen> createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen> {
  String _currentAddress = 'Loading location...';

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    if (widget.address != null) {
      setState(() {
        _currentAddress = widget.address!;
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentAddress = prefs.getString('user_address') ?? 'Location not set';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFF00BFA6)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Location',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    _currentAddress,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Hungry? We\'ve Got You Covered!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('What do you want to eat?'),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Near Me',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Choose From Nearby Restaurants\nWith Deliciousness Awaiting'),
          const SizedBox(height: 16),
          const Text('What do you want to eat?'),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCuisineFilter('Cuisines'),
                const SizedBox(width: 8),
                _buildCuisineFilter('Rated 4.5+'),
                const SizedBox(width: 8),
                _buildCuisineFilter('Promo'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildRestaurantCard(
            context,
            'Bubur Ayam Pak Yono',
            'Porridge, Rice, Chicken',
            'Rp 10.000',
            '12 min - 1 km',
            'Best Seller',
            '4.9 - 400+ ratings',
          ),
          _buildRestaurantCard(
            context,
            'Sate Kambing Pak Slamet',
            'Satay, Chicken, Heat',
            'Rp 10.000',
            '20 min - 1.2 km',
            'Promo',
            '4.7 - 200+ ratings',
          ),
          _buildRestaurantCard(
            context,
            'Bakmi Ayam Bangka 78',
            'Noodle, Chicken',
            'Rp 12.000',
            '25 min - 2.4 km',
            null,
            null,
          ),
        ],
      ),
    );
  }

  Widget _buildCuisineFilter(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text),
    );
  }

  Widget _buildRestaurantCard(
    BuildContext context,
    String name,
    String description,
    String price,
    String deliveryInfo,
    String? tag,
    String? rating,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RestaurantScreen(restaurantName: name)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(description),
              const SizedBox(height: 8),
              Text(
                price,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(deliveryInfo),
              if (tag != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: tag == 'Best Seller' ? Colors.orange[100] : Colors.green[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: tag == 'Best Seller' ? Colors.orange[800] : Colors.green[800],
                    ),
                  ),
                ),
              ],
              if (rating != null) ...[
                const SizedBox(height: 8),
                Text(
                  rating,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}