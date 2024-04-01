import 'package:employee_book/data/local/db/app_db.dart';
import 'package:employee_book/notifier/employee_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmployeeNotifierFutureScreen extends StatefulWidget {
  const EmployeeNotifierFutureScreen({super.key});

  @override
  State<EmployeeNotifierFutureScreen> createState() =>
      _EmployeeNotifierFutureScreenState();
}

class _EmployeeNotifierFutureScreenState
    extends State<EmployeeNotifierFutureScreen> {
  // late AppDb _db;

  @override
  void initState() {
    // _db = AppDb();
    super.initState();
  }

  @override
  void dispose() {
    // _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final employees = context.watch<EmployeeChangeNotifier>().employeeListFuture;
    final isLoading = context.select<EmployeeChangeNotifier,bool>((notifier) => notifier.isLoading,);
    final employees = context.select<EmployeeChangeNotifier,List<EmployeeData>>((notifier) => notifier.employeeListFuture,);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Future'),
      ),
      body: isLoading ? 
      const Center(child: CircularProgressIndicator(),):
      ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final EmployeeData employee = employees[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/edit_employee',
                arguments: employee.id),
            child: Card(
              color: Colors.grey[200],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                side: BorderSide(
                  color: Colors.deepOrange,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(employee.id.toString()),
                    Text(employee.userName.toString()),
                    Text(employee.firstName.toString()),
                    Text(employee.lastName.toString()),
                    Text(DateFormat('dd-MM-yyyy').format(employee.dateOfBirth)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
