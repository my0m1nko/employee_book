import 'package:employee_book/screens/add_employee.dart';
import 'package:employee_book/screens/edit_employee.dart';
import 'package:employee_book/screens/home_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/add_employee':
        return MaterialPageRoute(builder: (_) => const AddEmployee());
      case '/edit_employee':
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => EditEmployee(id: args),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Sorry no route was found!',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    });
  }
}
