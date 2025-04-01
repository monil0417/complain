import 'package:flutter/material.dart';
import 'dart:math';

class SignUpForm extends StatefulWidget {
  final VoidCallback onSignUpSuccess;

  const SignUpForm({Key? key, required this.onSignUpSuccess}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String _customerName = "";
  String _email = "";
  String _mobile = "";
  String _otp = "";
  String _generatedOtp = "";
  String _password = "";
  String _confirmPassword = "";
  String _customerID = "";
  bool _otpSent = false;
  bool _otpVerified = false;

  // Generate Customer ID
  void _generateCustomerID() {
    _customerID = "CUST${DateTime.now().millisecondsSinceEpoch}";
  }

  // Generate and Send OTP
  void _sendOTP() {
    if (_mobile.isNotEmpty || _email.isNotEmpty) {
      setState(() {
        _generatedOtp = (1000 + Random().nextInt(9000)).toString(); // 4-digit OTP
        _otpSent = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Sent: $_generatedOtp (For testing only)")),
      );
    }
  }

  // Verify OTP
  void _verifyOTP() {
    if (_otp == _generatedOtp) {
      setState(() {
        _otpVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP Verified Successfully!")),
      );
    } else {
      setState(() {
        _otpVerified = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Account",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Name Field
            _buildTextField(
              label: "Full Name",
              icon: Icons.person,
              onChanged: (value) => _customerName = value,
              validator: (value) => value!.isEmpty ? "Full Name is required" : null,
            ),
            const SizedBox(height: 10),

            // Email Field
            _buildTextField(
              label: "Email",
              icon: Icons.email,
              onChanged: (value) => _email = value,
              validator: (value) {
                if (value!.isEmpty) return "Email is required";
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "Enter a valid email";
                return null;
              },
            ),
            const SizedBox(height: 10),

            // Mobile Field
            _buildTextField(
              label: "Mobile Number",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              onChanged: (value) => _mobile = value,
              validator: (value) {
                if (value!.isEmpty) return "Mobile number is required";
                if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return "Enter a valid 10-digit mobile number";
                return null;
              },
            ),
            const SizedBox(height: 10),

            // OTP Send Button
            !_otpSent
                ? Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.orange,
                ),
                onPressed: _sendOTP,
                child: const Text("Send OTP", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            )
                : Column(
              children: [
                const SizedBox(height: 10),
                _buildOtpField(),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Colors.green,
                    ),
                    onPressed: _verifyOTP,
                    child: const Text("Verify OTP", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Password Field (only visible after OTP verification)
            if (_otpVerified) ...[
              _buildPasswordField(
                label: "Password",
                onChanged: (value) => _password = value,
              ),
              const SizedBox(height: 10),
              _buildPasswordField(
                label: "Confirm Password",
                onChanged: (value) => _confirmPassword = value,
              ),
              const SizedBox(height: 20),
            ],

            // Sign-Up Button (Disabled until OTP is verified)
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  backgroundColor: _otpVerified ? Colors.blueAccent : Colors.grey,
                ),
                onPressed: _otpVerified
                    ? () {
                  if (_formKey.currentState!.validate()) {
                    _generateCustomerID();
                    widget.onSignUpSuccess();
                  }
                }
                    : null, // Button disabled if OTP is not verified
                child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Text Field
  Widget _buildTextField({
    required String label,
    required IconData icon,
    required Function(String) onChanged,
    required String? Function(String?) validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.black54,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: Colors.white54),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(color: Colors.white),
    );
  }

  // OTP Field (4-digit)
  Widget _buildOtpField() {
    return _buildTextField(
      label: "Enter OTP",
      icon: Icons.verified,
      keyboardType: TextInputType.number,
      onChanged: (value) => _otp = value,
      validator: (value) {
        if (value!.isEmpty) return "OTP is required";
        if (value.length != 4) return "Enter a 4-digit OTP";
        return null;
      },
    );
  }

  // Password Field
  Widget _buildPasswordField({required String label, required Function(String) onChanged}) {
    return _buildTextField(
      label: label,
      icon: Icons.lock,
      obscureText: true,
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) return "$label is required";
        if (value.length < 6) return "Password must be at least 6 characters";
        return null;
      },
    );
  }
}
