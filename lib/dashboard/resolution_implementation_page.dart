import 'package:flutter/material.dart';

class ResolutionImplementationPage extends StatelessWidget {
  final String customerID;

  const ResolutionImplementationPage({Key? key, required this.customerID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resolution Implementation"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Resolution is being implemented.",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 20),
            const Icon(Icons.build, size: 60, color: Colors.white),
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
