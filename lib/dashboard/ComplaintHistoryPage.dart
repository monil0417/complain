import 'package:flutter/material.dart';

class ComplaintHistoryPage extends StatelessWidget {
  const ComplaintHistoryPage({Key? key, required List complaints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Make sure to handle the null or empty complaints list
    final complaints = args?['complaints'] as List<Map<String, String>>? ?? [];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Complaint History', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: complaints.isEmpty
          ? const Center(child: Text("No complaints submitted yet.", style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return ListTile(
            title: Text(complaint['category']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(complaint['issue']!, style: const TextStyle(color: Colors.white)),
            trailing: Text(
              complaint['status']!,
              style: TextStyle(
                color: complaint['status'] == 'Resolved' ? Colors.green : Colors.orange,
              ),
            ),
          );
        },
      ),
    );
  }
}
