import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'Screens/Signup/signup_screen.dart';
import 'dashboard/ComplaintHistoryPage.dart';
import 'dashboard/complaint_closure_page.dart';
import 'dashboard/complaint_status_page.dart';
import 'dashboard/customer_feedback_page.dart';
import 'dashboard/dashboard.dart';
import 'dashboard/delete_profile_page.dart';
import 'dashboard/investigation_page.dart';
import 'dashboard/profile.dart';
import 'dashboard/resolution_implementation_page.dart';
import 'dashboard/submit_complaint.dart';
import 'dashboard/settings_page.dart'; // ✅ Added Settings Page
import 'dashboard/edit_profile_page.dart'; // ✅ Added Edit Profile Page

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      initialRoute: '/signup', // Start from SignUp
      onGenerateRoute: (settings) {
        if (settings.name == '/dashboard') {
          final args = settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => DashboardPage(
              customerID: args?['customerID'] ?? 'Unknown',
              customerName: args?['customerName'] ?? 'Customer',
              email: args?['email'] ?? '',
              phone: args?['phone'] ?? '',
            ),
          );
        }
        if (settings.name == '/profile') {
          final args = settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => ProfilePage(
              customerID: args?['customerID'] ?? '',
              name: args?['customerName'] ?? '',
              email: args?['email'] ?? '',
              phone: args?['phone'] ?? '',
            ),
          );
        }
        return null;
      },
      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/submit_complaint': (context) => ComplaintSubmissionPage(),
        '/complaint_status': (context) => ComplaintStatusPage(),
        '/complaint_history': (context) => const ComplaintHistoryPage(complaints: []),
        '/customer_feedback': (context) => CustomerFeedbackPage(customerID: ""), // ✅ FIXED ROUTE
        '/investigation': (context) => InvestigationPage(
          customerID: "",
          isValidComplaint: false,  // Defaulting to false
        ),
        '/resolution': (context) => ResolutionImplementationPage(customerID: ""),
        '/closure': (context) => ComplaintClosurePage(customerID: ""),
        '/delete_profile': (context) => const DeleteProfilePage(),
        '/settings': (context) => const SettingsPage(), // ✅ FIXED ROUTE
        '/edit_profile': (context) => const EditProfilePage(customerName: '', customerID: '',), // ✅ FIXED ROUTE
      },
    );
  }
}
