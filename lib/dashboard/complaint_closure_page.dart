import 'package:flutter/material.dart';

class ComplaintClosurePage extends StatelessWidget {
  final String customerID;

  const ComplaintClosurePage({Key? key, required this.customerID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaint Closure"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Your complaint has been closed successfully.",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 20),
            const Icon(Icons.done_all, size: 60, color: Colors.green),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
        backgroundColor: Colors.white,
        child: const Icon(Icons.home, color: Colors.black),
      ),
    );
  }
}
