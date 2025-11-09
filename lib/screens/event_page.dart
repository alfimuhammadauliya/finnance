// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  final List<Map<String, String>> _events = [
    {'title': 'Music Fest 2025', 'date': '12 Jan 2025', 'place': 'Jakarta'},
    {'title': 'Startup Conference', 'date': '8 Feb 2025', 'place': 'Surabaya'},
    {'title': 'Marathon Run', 'date': '3 Mar 2025', 'place': 'Bali'},
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
          title: const Text('Events'),
          backgroundColor: Colors.purpleAccent,
          elevation: 0,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: _events.length,
          itemBuilder: (context, index) {
            final event = _events[index];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(color: Colors.purpleAccent.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.event, color: Colors.purpleAccent, size: 36),
                title: Text(event['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${event['date']}  •  ${event['place']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
