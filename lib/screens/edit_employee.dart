import 'package:employee_book/data/local/db/app_db.dart';
import 'package:employee_book/notifier/employee_change_notifier.dart';
import 'package:employee_book/widgets/custom_text_field.dart';
import 'package:employee_book/widgets/custome_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';

class EditEmployee extends StatefulWidget {
  const EditEmployee({super.key,required this.id});
  final int id;

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final _formKey = GlobalKey<FormState>();
  // late AppDb _db;
  late EmployeeData _employeeData;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // _employeeData = _db.getEmpyloyeeById(widget.id);
    // _db = AppDb();
    getEmployee();
  }

  @override
  void dispose() {
    // _db.close();
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              editEmployee();
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(onPressed: (){
              deleteEmployee();
          }, icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             Form(
              key: _formKey,
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

  void editEmployee() {
    final isValidate = _formKey.currentState?.validate();

    if(isValidate != null && !isValidate) {
         final entity = EmployeeCompanion(
      id: drift.Value(widget.id),
      userName: drift.Value(_userNameController.text),
      firstName: drift.Value(_firstNameController.text),
      lastName: drift.Value(_lastNameController.text),
      dateOfBirth: drift.Value(_selectedDate!),
    );
    context.read<EmployeeChangeNotifier>().updateEmployee(entity);
    // Provider.of<AppDb>(context,listen: false).updateEmployee(entity).then((value) =>
    //     ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
    //       content: const Text('Employee Updated:  Successfully'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    //           },
    //           child: const Text(
    //             'Close',
    //             style: TextStyle(color: Colors.grey),
    //           ),
    //         )
    //       ],
    //     )));
    }
   
  }

  Future<void> getEmployee() async{
    _employeeData = await Provider.of<AppDb>(context,listen: false).getEmpyloyeeById(widget.id);
    _userNameController.text = _employeeData.userName;
    _firstNameController.text = _employeeData.firstName;
    _lastNameController.text = _employeeData.lastName;
    _dobController.text = DateFormat('dd/MM/yyyy').format(_employeeData.dateOfBirth);
  }

  void deleteEmployee(){
    context.read<EmployeeChangeNotifier>().deleteEmployee(widget.id);
    // Provider.of<AppDb>(context,listen: false).deleteEmployee(widget.id).then((value) => ScaffoldMessenger.of(context)
    //   .showMaterialBanner(
    //     MaterialBanner(
    //       content: const Text('Employee Deleted Successfully'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    //             Navigator.pop(context);
    //           },
    //           child: const Text(
    //             'Close',
    //             style: TextStyle(color: Colors.grey),
    //           ),
    //         )
    //       ],
    //   ))
    //   );
  }

  void listernProvider(String title){
    ScaffoldMessenger.of(context)
      .showMaterialBanner(
        MaterialBanner(
          content: Text('Employee $title Successfully'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
      ));
  }
}
