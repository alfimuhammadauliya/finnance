// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  final List<Map<String, dynamic>> _healthTips = [
    {'icon': Icons.fitness_center, 'title': 'Workout 30 mins', 'desc': 'Keep your body active daily.'},
    {'icon': Icons.local_drink, 'title': 'Drink Water', 'desc': 'Stay hydrated and fresh.'},
    {'icon': Icons.nightlight, 'title': 'Sleep 8 hours', 'desc': 'Boost recovery and focus.'},
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
          title: const Text('Health'),
          backgroundColor: Colors.redAccent,
          elevation: 0,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: _healthTips.length,
          itemBuilder: (context, index) {
            final item = _healthTips[index];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.redAccent, Color(0xFFFF6F61)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.redAccent.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: ListTile(
                leading: Icon(item['icon'], color: Colors.white, size: 36),
                title: Text(item['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(item['desc'], style: const TextStyle(color: Colors.white70)),
              ),
            );
          },
        ),
      ),
    );
  }
}
