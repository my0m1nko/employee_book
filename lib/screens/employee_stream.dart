import 'package:employee_book/data/local/db/app_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmployeeStreamScreen extends StatefulWidget {
  const EmployeeStreamScreen({super.key});

  @override
  State<EmployeeStreamScreen> createState() => _EmployeeStreamScreenState();
}

class _EmployeeStreamScreenState extends State<EmployeeStreamScreen> {
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employee Stream'),
        ),
        body: FutureBuilder<List<EmployeeData>>(
          // future: _db.getAllEmployees(),
          future: Provider.of<AppDb>(context).getAllEmployees(),
          builder: (context, snapshot){
            final List<EmployeeData>? employees = snapshot.data;
            if(snapshot.connectionState != ConnectionState.done){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(snapshot.hasError){
              return  Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if(employees != null){
              return ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index){
                  final EmployeeData employee = employees[index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/edit_employee', arguments: employee.id),
                    child: Card(
                      
                      color: Colors.grey[200],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        
                        ),
                        side:  BorderSide(color: Colors.deepOrange, width: 0.5,
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

              ); 
            
            }
            return const Center(
              child: Text('No data found'),
            );
          
          },
        ),
        );
  }
}
