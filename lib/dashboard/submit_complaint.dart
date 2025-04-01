import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:math';
import 'complaint_acknowledgment_page.dart';  // Import the ComplaintAcknowledgmentPage

class ComplaintSubmissionPage extends StatefulWidget {
  @override
  _ComplaintSubmissionPageState createState() => _ComplaintSubmissionPageState();
}

class _ComplaintSubmissionPageState extends State<ComplaintSubmissionPage> {
  final _formKey = GlobalKey<FormState>();
  String category = 'Billing';
  String issueDescription = '';
  bool isSubmitting = false;
  DateTime selectedDate = DateTime.now();

  String _generateComplaintID() {
    final random = Random();
    return 'C${random.nextInt(90000) + 10000}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _sendEmail(String complaintID, String customerName, String email, String issue) async {
    final Email complaintEmail = Email(
      body: '''
Dear $customerName,

Your complaint with ID: $complaintID has been received.
Issue: $issue
Date: ${selectedDate.toLocal()}
We will process it soon.

Thank you.
''',
      subject: 'Complaint Acknowledgment - $complaintID',
      recipients: [email],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(complaintEmail);
    } catch (e) {
      print('Failed to send email: $e');
    }
  }

  void _submitComplaint(String customerID, String customerName, String email, String phone) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSubmitting = true;
      });

      final complaintID = _generateComplaintID();
      final complaintDate = selectedDate.toString().split(' ')[0];

      _sendEmail(complaintID, customerName, email, issueDescription);

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ComplaintAcknowledgmentPage(
              complaintID: complaintID,
              customerName: customerName,
              customerID: customerID,
              email: email,
              phone: phone,
              issueDescription: issueDescription,
              date: complaintDate,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String customerID = args?['customerID'] ?? 'Unknown';
    final String customerName = args?['customerName'] ?? 'Anonymous';
    final String email = args?['email'] ?? 'noemail@example.com';
    final String phone = args?['phone'] ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Submit Complaint', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select Category", style: TextStyle(color: Colors.white, fontSize: 16)),
              DropdownButtonFormField<String>(
                value: category,
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                items: ['Billing', 'Technical', 'Service', 'Network Issue', 'Other']
                    .map((String category) => DropdownMenuItem(value: category, child: Text(category)))
                    .toList(),
                onChanged: (newValue) => setState(() => category = newValue!),
              ),
              const SizedBox(height: 10),
              const Text("Describe Issue", style: TextStyle(color: Colors.white, fontSize: 16)),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter complaint details...",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (value) => issueDescription = value,
                validator: (value) => value!.isEmpty ? "Issue description required" : null,
              ),
              const SizedBox(height: 10),
              const Text("Select Date", style: TextStyle(color: Colors.white, fontSize: 16)),
              Row(
                children: [
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.white),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: isSubmitting
                      ? null
                      : () => _submitComplaint(customerID, customerName, email, phone),
                  child: isSubmitting
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                      : const Text("Submit Complaint"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
