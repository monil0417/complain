import 'package:flutter/material.dart';

import 'dashboard.dart';

class EditProfilePage extends StatefulWidget {
  final String customerID;
  final String customerName;

  const EditProfilePage({Key? key, required this.customerID, required this.customerName}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _customerIDController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customerName);
    _customerIDController = TextEditingController(text: widget.customerID);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _customerIDController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Simulate saving to backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated Successfully!")),
      );

      // Return to Dashboard with updated data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(
            customerID: _customerIDController.text,
            customerName: _nameController.text, email: '', phone: '',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Customer ID",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              TextFormField(
                controller: _customerIDController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Customer ID"),
                validator: (value) => value!.isEmpty ? "Customer ID is required" : null,
              ),
              const SizedBox(height: 20),
              const Text(
                "Full Name",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Full Name"),
                validator: (value) => value!.isEmpty ? "Name cannot be empty" : null,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Save Changes", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.teal),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.teal),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.teal, width: 2),
      ),
    );
  }
}
