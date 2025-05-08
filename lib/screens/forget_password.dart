import 'package:openday/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';

// Stateful widget for the Forgot Password screen
class forgotPasswordScreen extends StatefulWidget {
  const forgotPasswordScreen({super.key});

  @override
  State<forgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<forgotPasswordScreen> {
  // Key to manage form validation
  final _formKey = GlobalKey<FormState>();

  // Controller to manage the input from the email text field
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    _emailController.dispose();
    super.dispose();
  }

  // Function to validate the form and display a snackbar message
  void _sendResetLink() {
    if (_formKey.currentState!.validate()) {
      // If email is valid, show a success message (you can add actual email logic here)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reset link sent to email.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), // Add horizontal padding
        child: Form(
          key: _formKey, // Assign the form key to validate inputs
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
            children: [
              // Title text
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Subtitle / description text
              const Text(
                "Enter your email address below to receive a password reset link.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Email input field with validation
              TextFormField(
                controller: _emailController, // Link the controller
                keyboardType: TextInputType.emailAddress, // Show email keyboard
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email), // Email icon
                  hintText: "Email Address",
                  filled: true,
                  fillColor: Colors.blue[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  // Check if email is empty
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Check if email is valid using regex
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Button to send reset link
              SizedBox(
                width: double.infinity, // Make button full-width
                height: 50,
                child: ElevatedButton(
                  onPressed: _sendResetLink, // Call function to send reset
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Send Reset Link",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Option to go back to Sign In screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Remember your password?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Return to previous screen
                    },
                    child: const Text("Sign in", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
