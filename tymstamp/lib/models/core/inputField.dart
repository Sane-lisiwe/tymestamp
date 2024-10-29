import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final IconData? iconData;
  final bool obscure;
  final VoidCallback? onTap; // Add this parameter

  const InputField({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    this.iconData,
    this.obscure = false,
    this.onTap, required widget, // And this
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          // Your text styling
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          readOnly: onTap != null, // Make it read-only if onTap is provided
          onTap: onTap, // Attach the onTap callback
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: iconData != null ? Icon(iconData) : null,
            // Your decoration styling
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
