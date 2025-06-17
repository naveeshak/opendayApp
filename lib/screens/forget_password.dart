import 'package:openday/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Screen for handling password reset requests
class forgotPasswordScreen extends StatefulWidget {
  const forgotPasswordScreen({super.key});

  @override
  State<forgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<forgotPasswordScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controller for email input field
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed to prevent memory leaks
    _emailController.dispose();
    super.dispose();
  }

  // Function to handle password reset link sending
  void _sendResetLink() async {
    // Validate form inputs before proceeding
    if (_formKey.currentState!.validate()) {
      // Trim whitespace from email input
      final email = _emailController.text.trim();

      try {
        // Make HTTP POST request to password reset endpoint
        final response = await http.post(
          Uri.parse('https://d645-212-104-231-219.ngrok-free.app/reset-password'),
          headers: {'Content-Type': 'application/json'}, // Set content type header
          body: jsonEncode({'email': email}), // Convert email to JSON format
        );

        // Parse the JSON response from server
        final data = jsonDecode(response.body);

        // Check response status code
        if (response.statusCode == 200) {
          // Show success message if request was successful
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reset link sent to $email')),
          );
        } else {
          // Show error message from server or default message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Failed to send reset link')),
          );
        }
      } catch (e) {
        // Handle any exceptions that occur during the request
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
        child: Form(
          key: _formKey, // Associate the form key with this Form widget
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
            children: [
              // Screen title
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10), // Spacer between title and subtitle

              // Instructions text
              const Text(
                "Enter your email address below to receive a password reset link.",
                style: TextStyle(color: Colors.grey), // Grey text for secondary information
              ),
              const SizedBox(height: 30), // Spacer between text and input field

              // Email input field
              TextFormField(
                controller: _emailController, // Connect to controller
                keyboardType: TextInputType.emailAddress, // Set keyboard type
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email), // Email icon
                  hintText: "Email Address",
                  filled: true, // Enable fill color
                  fillColor: Colors.blue[100], // Light blue background
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    borderSide: BorderSide.none, // Remove default border
                  ),
                ),
                // Validation logic for email field
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email'; // Empty field validation
                  }
                  // Regular expression for email validation
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null; // Return null if validation succeeds
                },
              ),
              const SizedBox(height: 20), // Spacer between input and button

              // Submit button
              SizedBox(
                width: double.infinity, // Full width button
                height: 50, // Fixed button height
                child: ElevatedButton(
                  onPressed: _sendResetLink, // Trigger reset function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Send Reset Link",
                    style: TextStyle(fontSize: 18, color: Colors.white), // Button text style
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacer between button and navigation text

              // Navigation back to sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center row contents
                children: [
                  const Text("Remember your password?"), // Prompt text
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
