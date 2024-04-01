import 'package:employee_book/data/local/db/app_db.dart';
import 'package:employee_book/notifier/employee_change_notifier.dart';
import 'package:employee_book/routes/routes_generate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      // Provider(create:(context)=> AppDb(),
      // child: const MyApp(),
      // dispose: (context, AppDb db) => db.close() ,
      // ),

    MultiProvider(
    providers: [
      Provider.value(value: AppDb()),
      ChangeNotifierProxyProvider<AppDb, EmployeeChangeNotifier>(
          create: (context) => EmployeeChangeNotifier(), 
          update: (context, db, notifier) => notifier!
            ..initAppDb(db)
            ..getEmployeeFuture())
    ],
    child: const MyApp(),
  )
  );
  
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
