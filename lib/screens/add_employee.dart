import 'package:employee_book/widgets/custom_text_field.dart';
import 'package:employee_book/widgets/custome_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
                controller: _userNameController,
                labeltxt: 'Username',
                hinttxt: "Enter Username"),
            const SizedBox(height: 8.0),
            CustomTextField(
                controller: _firstNameController,
                labeltxt: 'First Name',
                hinttxt: "Enter First Name"),
            const SizedBox(height: 8.0),
            CustomTextField(
                controller: _lastNameController,
                labeltxt: 'Last Name',
                hinttxt: "Enter Last Name"),
            const SizedBox(height: 8.0),
            CustomDatePicker(
                controller: _dobController,
                labeltxt: 'Date Of Birth',
                callback: () {
                  pickDateOfBirth(context);
                }),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.blue,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.blue[100],
        ),
        child: child ?? const Text(''),
      ),
    );

    if (newDate == null) {
      return;
    }

    setState(() {
      _selectedDate = newDate;
      String dob = DateFormat('dd/MM/yyyy').format(newDate);
      _dobController.text = dob;
    });
  }
}
