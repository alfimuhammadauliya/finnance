// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  final List<Map<String, dynamic>> _foods = [
    {'icon': Icons.local_pizza, 'title': 'Pizza', 'desc': 'Italian cheese pizza', 'price': 'Rp45.000'},
    {'icon': Icons.ramen_dining, 'title': 'Ramen', 'desc': 'Japanese hot ramen', 'price': 'Rp38.000'},
    {'icon': Icons.icecream, 'title': 'Ice Cream', 'desc': 'Sweet vanilla scoop', 'price': 'Rp20.000'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeIn,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          title: const Text('Food'),
          backgroundColor: Colors.orangeAccent,
          elevation: 0,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: _foods.length,
          itemBuilder: (context, index) {
            final item = _foods[index];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(color: Colors.orangeAccent.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: ListTile(
                leading: Icon(item['icon'], color: Colors.orangeAccent, size: 36),
                title: Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(item['desc']),
                trailing: Text(item['price'], style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
              ),
            );
          },
        ),
      ),
    );
  }
}
