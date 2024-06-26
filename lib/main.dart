import 'package:employee_book/data/local/db/app_db.dart';
import 'package:employee_book/notifier/address_change_notifier.dart';
import 'package:employee_book/notifier/employee_change_notifier.dart';
import 'package:employee_book/routes/routes_generate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: AppDb()),
        ChangeNotifierProxyProvider<AppDb,EmployeeChangeNotifier>(
          create: (context) => EmployeeChangeNotifier(), 
          update: (context, db, notifier) => notifier!..initAppDb(db)..getEmployeeFuture(),
        ),
        ChangeNotifierProxyProvider<AppDb,EmployeeAddressChangeNotifier>(
          create: (context) => EmployeeAddressChangeNotifier(), 
          update: (context,appDb,notifier) =>  notifier!..initAppDb(appDb),
          lazy: true,
        )
                
      ],
      child: const MyApp(),      
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('object');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(       
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute      
    );
  }
}

