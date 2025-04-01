import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ComplaintAcknowledgmentPage extends StatelessWidget {
  final String complaintID;
  final String customerName;
  final String customerID;
  final String email;
  final String phone;
  final String issueDescription;
  final String date;

  ComplaintAcknowledgmentPage({
    required this.complaintID,
    required this.customerName,
    required this.customerID,
    required this.email,
    required this.phone,
    required this.issueDescription,
    required this.date,
  });

  // Method to generate the PDF
  Future<void> _generatePDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Complaint Acknowledgment', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text('Complaint ID: $complaintID', style: pw.TextStyle(fontSize: 18)),
              pw.Text('Customer Name: $customerName', style: pw.TextStyle(fontSize: 18)),
              pw.Text('Customer ID: $customerID', style: pw.TextStyle(fontSize: 18)),
              pw.Text('Email: $email', style: pw.TextStyle(fontSize: 18)),
              pw.Text('Phone: $phone', style: pw.TextStyle(fontSize: 18)),
              pw.Text('Issue Description: $issueDescription', style: pw.TextStyle(fontSize: 18)),
              pw.Text('Date: $date', style: pw.TextStyle(fontSize: 18)),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complaint Acknowledgment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Complaint ID: $complaintID', style: TextStyle(fontSize: 18)),
            Text('Customer Name: $customerName', style: TextStyle(fontSize: 18)),
            Text('Customer ID: $customerID', style: TextStyle(fontSize: 18)),
            Text('Email: $email', style: TextStyle(fontSize: 18)),
            Text('Phone: $phone', style: TextStyle(fontSize: 18)),
            Text('Issue Description: $issueDescription', style: TextStyle(fontSize: 18)),
            Text('Date: $date', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _generatePDF,  // Call the function to generate the PDF
                child: const Text("Download as PDF"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
