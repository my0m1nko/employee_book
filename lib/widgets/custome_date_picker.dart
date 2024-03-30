import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    Key? key,
    required TextEditingController controller,
    required String labeltxt,
    required VoidCallback callback,
  })  : _controller = controller,
        _labeltxt = labeltxt,
        _callback = callback,
        super(key: key);

  final TextEditingController _controller;
  final String _labeltxt;
  final VoidCallback _callback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: _labeltxt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $_labeltxt';
        }
        return null;
      },
      onTap: _callback,
    );
  }
}
