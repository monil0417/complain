import 'package:flutter/material.dart';

class CustomerFeedbackPage extends StatelessWidget {
  final String customerID;

  const CustomerFeedbackPage({Key? key, required this.customerID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Feedback"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Please provide your feedback:",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Write your feedback here...",
                hintStyle: TextStyle(color: Colors.white60),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Feedback Submitted!")),
                );
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              child: const Text("Submit"),
            ),
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
