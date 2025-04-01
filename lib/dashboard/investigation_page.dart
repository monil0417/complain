import 'package:flutter/material.dart';

class InvestigationPage extends StatelessWidget {
  final String customerID;
  final bool isValidComplaint;

  const InvestigationPage({
    Key? key,
    required this.customerID,
    required this.isValidComplaint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Investigation"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display different message based on complaint validity
            Text(
              isValidComplaint
                  ? "Your complaint is under investigation and is valid."
                  : "Your complaint is under investigation but is invalid.",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
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
