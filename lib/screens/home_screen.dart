import 'package:flutter/material.dart';
import 'health_page.dart';
import 'travel_page.dart';
import 'food_page.dart';
import 'event_page.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late AnimationController _staggerController;
  late List<Animation<double>> _staggerAnimations;

  int? _hoveredCardIndex;
  int? _hoveredCategoryIndex;
  int _selectedIndex = 1; 

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);
    _fadeController.forward();

    _slideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _slideController.forward();

    _staggerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _staggerAnimations = List.generate(5, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(index * 0.2, 1.0, curve: Curves.easeOut),
        ),
      );
    });
    _staggerController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  Widget _buildBankCard({
    required int index,
    required String name,
    required String balance,
    required List<Color> gradientColors,
  }) {
    final bool isHovered = _hoveredCardIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredCardIndex = index),
      onExit: (_) => setState(() => _hoveredCardIndex = null),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        height: isHovered ? 175 : 160,
        width: isHovered ? 295 : 280,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(isHovered ? 0.4 : 0.2),
              blurRadius: isHovered ? 24 : 16,
              offset: Offset(0, isHovered ? 12 : 8),
              spreadRadius: isHovered ? 2 : 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              right: -30,
              top: -30,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isHovered ? 0.3 : 0.2,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),
            Positioned(
              left: -20,
              bottom: -20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isHovered ? 0.2 : 0.1,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.credit_card,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "Available Balance",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    balance,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory({
    required int index,
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final bool isHovered = _hoveredCategoryIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredCategoryIndex = index),
      onExit: (_) => setState(() => _hoveredCategoryIndex = null),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: isHovered ? 100 : 90,
          height: isHovered ? 100 : 90,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String amount, String category, int index) {
    return AnimatedBuilder(
      animation: _staggerAnimations[index],
      builder: (context, child) {
        return Opacity(
          opacity: _staggerAnimations[index].value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _staggerAnimations[index].value)),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    category == "Food"
                        ? Icons.coffee
                        : category == "Travel"
                            ? Icons.motorcycle_outlined
                            : category == "Health"
                                ? Icons.fitness_center_sharp
                                : Icons.attach_money,
                    color: Colors.black,
                    size: 28,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: amount.startsWith('-') ? Colors.redAccent : Colors.green,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),

        // ======== BODY ========
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFBBDEFB), Color(0xFFFDFDFD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== HEADER =====
                  SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Halo Alfi !",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.create_new_folder_outlined, color: Color.fromARGB(255, 5, 5, 5), size: 32),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Tambah Bank diklik")),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ===== BANK CARDS =====
                  SlideTransition(
                    position: _slideAnimation,
                    child: SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 16),
                        children: [
                          _buildBankCard(
                            index: 0,
                            name: "BCA",
                            balance: "Rp 11.500.000",
                            gradientColors: [Colors.black, Colors.grey.shade700],
                          ),
                          _buildBankCard(
                            index: 1,
                            name: "Mandiri",
                            balance: "Rp 8.340.000",
                            gradientColors: [Colors.amber.shade700, Colors.brown.shade300],
                          ),
                          _buildBankCard(
                            index: 2,
                            name: "BNI",
                            balance: "Rp 6.120.000",
                            gradientColors: [Colors.grey, Colors.black],
                          ),
                          _buildBankCard(
                            index: 3,
                            name: "BRI",
                            balance: "Rp 9.560.000",
                            gradientColors: [Colors.blueAccent, Colors.indigo.shade100],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ===== CATEGORIES =====
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCategory(
                        index: 0,
                        label: "Health",
                        icon: Icons.health_and_safety,
                        color: Colors.redAccent,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HealthPage()),
                        ),
                      ),
                      _buildCategory(
                        index: 1,
                        label: "Travel",
                        icon: Icons.flight_takeoff,
                        color: Colors.blueAccent,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TravelPage()),
                        ),
                      ),
                      _buildCategory(
                        index: 2,
                        label: "Food",
                        icon: Icons.fastfood,
                        color: Colors.orangeAccent,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FoodPage()),
                        ),
                      ),
                      _buildCategory(
                        index: 3,
                        label: "Event",
                        icon: Icons.event,
                        color: Colors.purpleAccent,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const EventPage()),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ===== TRANSACTIONS =====
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildTransactionItem("Coffee Shop", "-Rp35.000", "Food", 0),
                  _buildTransactionItem("Grab Ride", "-Rp25.000", "Travel", 1),
                  _buildTransactionItem("Gym Membership", "-Rp150.000", "Health", 2),
                  _buildTransactionItem("Salary", "+Rp5.000.000", "Income", 3),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),

        // ======== BOTTOM NAVBAR ========
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 3, 3, 3),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor:   Color.fromARGB(255, 164, 208, 245),
            unselectedItemColor: const Color.fromARGB(255, 109, 108, 108),
            showUnselectedLabels: true,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Menu ${["Home", "Dompet", "Insight", "Profile"][index]} diklik")),
              );
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Dompet'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Insight'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
