import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardPage extends StatefulWidget {
  final String customerID;
  final String customerName;
  final String email;
  final String phone;

  const DashboardPage({
    Key? key,
    required this.customerID,
    required this.customerName,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool isDarkMode = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, color: isDarkMode ? Colors.white : Colors.black),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      drawer: _buildDrawer(), // Drawer added
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: dashboardItems.length,
              itemBuilder: (context, index) {
                return DashboardCard(
                  icon: dashboardItems[index]['icon'],
                  label: dashboardItems[index]['label'],
                  onTap: () => Navigator.pushNamed(context, dashboardItems[index]['route'], arguments: {
                    'customerID': widget.customerID,
                    'customerName': widget.customerName,
                    'email': widget.email,
                    'phone': widget.phone,
                  }),
                  isDarkMode: isDarkMode,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Drawer Widget
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: isDarkMode ? Colors.grey[900] : Colors.blueGrey),
              accountName: Text(widget.customerName, style: const TextStyle(fontSize: 18)),
              accountEmail: Text(widget.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text(widget.customerName[0], style: const TextStyle(fontSize: 30, color: Colors.white)),
              ),
            ),
            _buildDrawerItem(FontAwesomeIcons.gear, "Settings", "/settings"),
            _buildDrawerItem(FontAwesomeIcons.user, "Profile", "/profile"),
            _buildDrawerItem(FontAwesomeIcons.edit, "Edit Profile", "/edit_profile"),
            _buildDrawerItem(FontAwesomeIcons.trash, "Delete Profile", "/delete_profile"),
            _buildDrawerItem(FontAwesomeIcons.signOutAlt, "Logout", "/login"),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label, String route) {
    return ListTile(
      leading: FaIcon(icon, color: isDarkMode ? Colors.white : Colors.black),
      title: Text(label, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDarkMode;

  const DashboardCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.white24 : Colors.black12,
            blurRadius: 5,
            offset: const Offset(2, 2),
          )
        ],
      ),
      child: ListTile(
        leading: FaIcon(icon, color: isDarkMode ? Colors.white : Colors.black),
        title: Text(label, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
        onTap: onTap,
      ),
    );
  }
}

// Updated Dashboard Items (Removed "Complaint List" and "Inside Board Page")
final List<Map<String, dynamic>> dashboardItems = [
  {'icon': FontAwesomeIcons.circlePlus, 'label': 'Submit Complaint', 'route': '/submit_complaint'},
  {'icon': FontAwesomeIcons.history, 'label': 'Complaint History', 'route': '/complaint_history'},
  {'icon': FontAwesomeIcons.magnifyingGlass, 'label': 'Track Status', 'route': '/complaint_status'},
  {'icon': FontAwesomeIcons.search, 'label': 'Investigation', 'route': '/investigation'},
  {'icon': FontAwesomeIcons.tools, 'label': 'Resolution', 'route': '/resolution'},
  {'icon': FontAwesomeIcons.comment, 'label': 'Customer Feedback', 'route': '/customer_feedback'}, // ✅ FIXED ROUTE
  {'icon': FontAwesomeIcons.checkCircle, 'label': 'Complaint Closure', 'route': '/closure'},
  {'icon': FontAwesomeIcons.gear, 'label': 'Settings', 'route': '/settings'}, // ✅ FIXED ROUTE
  {'icon': FontAwesomeIcons.user, 'label': 'Profile', 'route': '/profile'},
  {'icon': FontAwesomeIcons.edit, 'label': 'Edit Profile', 'route': '/edit_profile'}, // ✅ FIXED ROUTE
  {'icon': FontAwesomeIcons.trash, 'label': 'Delete Profile', 'route': '/delete_profile'},
  {'icon': FontAwesomeIcons.signOutAlt, 'label': 'Logout', 'route': '/login'},
];
