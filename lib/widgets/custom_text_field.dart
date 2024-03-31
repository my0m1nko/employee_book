import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController controller,
    required String labeltxt,
    required String hinttxt,
  })  : _controller = controller,
        _labeltxt = labeltxt,
        _hinttxt = hinttxt;

  final TextEditingController _controller;
  final String _labeltxt;
  final String _hinttxt;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $_labeltxt';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: _labeltxt,
        hintText: _hinttxt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
