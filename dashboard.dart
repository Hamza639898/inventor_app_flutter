import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'db_helper.dart';
import 'inventory_screen.dart';
import 'users_screen.dart';
import 'activity_logs_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String username;
  final String userType;

  const DashboardScreen({Key? key, required this.username, required this.userType}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;
  int _userCount = 0;
  int _inventoryCount = 0;
  int _activityLogsCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _fetchCounts() async {
    final userCount = (await DBHelper().getUsers()).length;
    final inventoryCount = (await DBHelper().getItems()).length;
    final activityLogsCount = (await DBHelper().getLogs()).length;

    setState(() {
      _userCount = userCount;
      _inventoryCount = inventoryCount;
      _activityLogsCount = activityLogsCount;
    });
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: [
        'imges/1.jpg',
        'imges/2.jpg',
        'imges/3.jpg',
      ].map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildOverviewTab() {

    return Column(

      children: [
        // Carousel Section
        _buildCarousel(),

        // Cards Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildStatsCard('Users', '$_userCount', Icons.person, Colors.orange),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatsCard('Inventory', '$_inventoryCount', Icons.inventory, Colors.blue),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildStatsCard('Activity Logs', '$_activityLogsCount', Icons.history, Colors.red),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatsCard('Welcome', widget.username, Icons.waving_hand, Colors.teal),
              ),
            ],
          ),
        ),

        // About Developers Section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'About Developers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Column(
                          children: [
                            Icon(Icons.person, size: 40, color: Colors.indigo),
                            Text('Hamza'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.person, size: 40, color: Colors.indigo),
                            Text('Cabdala'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.person, size: 40, color: Colors.indigo),
                            Text('Yasiin'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.person, size: 40, color: Colors.indigo),
                            Text('Axmad'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToInventory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InventoryScreen()),
    );
  }

  void _navigateToUsers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UsersScreen()),
    );
  }

  void _navigateToActivityLogs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ActivityLogsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2C),

        title: Row(

          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.indigo),
            ),
            const SizedBox(width: 8),
            Text(widget.username),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _selectedTab == 0
                ? _buildOverviewTab()
                : const Center(child: Text('Select a tab to view content.')),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.dashboard, color: Colors.indigo),
                  onPressed: () => setState(() => _selectedTab = 0),
                ),
                IconButton(
                  icon: const Icon(Icons.inventory, color: Colors.blue),
                  onPressed: _navigateToInventory,
                ),
                if (widget.userType == 'Admin')
                  IconButton(
                    icon: const Icon(Icons.people, color: Colors.orange),
                    onPressed: _navigateToUsers,
                  ),
                IconButton(
                  icon: const Icon(Icons.history, color: Colors.red),
                  onPressed: _navigateToActivityLogs,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
