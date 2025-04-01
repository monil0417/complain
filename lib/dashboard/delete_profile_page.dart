import 'package:flutter/material.dart';

class DeleteProfilePage extends StatelessWidget {
  const DeleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Delete Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.warning, color: Colors.red, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Are you sure you want to delete your profile?",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton("Cancel", Colors.grey, () {
                  Navigator.pop(context);
                }),
                const SizedBox(width: 20),
                _buildButton("Delete", Colors.red, () {
                  _deleteProfile(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }

  void _deleteProfile(BuildContext context) {
    print("Deleting profile..."); // Debugging
    Navigator.of(context).pushNamedAndRemoveUntil('/signup', (route) => false);
  }
}
