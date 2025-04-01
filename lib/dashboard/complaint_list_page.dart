import 'package:flutter/material.dart';

class ComplaintListPage extends StatefulWidget {
  final String customerID;
  const ComplaintListPage({Key? key, required this.customerID}) : super(key: key);

  @override
  _ComplaintListPageState createState() => _ComplaintListPageState();
}

class _ComplaintListPageState extends State<ComplaintListPage> {
  final List<Map<String, String>> complaints = [
    {'category': 'Billing', 'issue': 'Incorrect charge', 'status': 'Received'},
    {'category': 'Technical', 'issue': 'Internet not working', 'status': 'In Progress'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Complaint List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: complaints.isEmpty
          ? const Center(child: Text("No complaints found", style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final Map<String, String>? complaint = complaints[index];

          if (complaint == null) return const SizedBox(); // Prevent errors

          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              key: ValueKey(index),
              title: Text(
                complaint['category'] ?? 'Unknown',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                complaint['issue'] ?? 'No issue specified',
                style: const TextStyle(color: Colors.white),
              ),
              trailing: Text(
                complaint['status'] ?? 'Unknown',
                style: TextStyle(
                  color: (complaint['status'] == 'Received') ? Colors.orange : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
