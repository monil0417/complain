import 'package:flutter/material.dart';

class ComplaintStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get arguments passed from the previous page
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String complaintID = args['complaintID'] ?? 'Unknown';
    final String status = args['status'] ?? 'Pending';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Complaint Status - $complaintID', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display Complaint ID and Status
              Text(
                "Complaint ID: $complaintID",
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Status: $status",
                style: TextStyle(
                  color: status == 'Solved' ? Colors.green : status == 'Unsolved' ? Colors.red : Colors.yellow,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // No button to change status; just viewing the status
              Text(
                'You are viewing the current status of the complaint.',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
