import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String, String, String) onLoginSuccess;

  const LoginForm({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _customerIDController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String customerID = _customerIDController.text.trim();
      String customerName = _customerNameController.text.trim();
      String emailOrPhone = _emailOrPhoneController.text.trim();
      String password = _passwordController.text.trim();

      widget.onLoginSuccess(customerID, customerName, emailOrPhone, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _customerIDController,
            decoration: const InputDecoration(labelText: "Customer ID"),
            validator: (value) {
              if (value == null || value.isEmpty) return "Please enter Customer ID";
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _customerNameController,
            decoration: const InputDecoration(labelText: "Customer Name"),
            validator: (value) {
              if (value == null || value.isEmpty) return "Please enter Customer Name";
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _emailOrPhoneController,
            decoration: const InputDecoration(labelText: "Email or Mobile Number"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter Email or Mobile Number";
              } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value) &&
                  !RegExp(r"^\d{10}$").hasMatch(value)) {
                return "Enter a valid Email or 10-digit Mobile Number";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) return "Please enter Password";
              if (value.length < 6) return "Password must be at least 6 characters";
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
