import 'package:employee_book/screens/employee_notifier_future.dart';
import 'package:employee_book/screens/employee_notifier_stream.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late AppDb _db;
  int _selectedIndex = 0;
  final pages = const [
     EmployeeNotifierFutureScreen(),
     EmployeeNotifierStreamScreen(),];

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
          title: const Text('Employee Book',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
          backgroundColor: Colors.deepOrange,
          centerTitle: true,
          
        ),
        body: pages[_selectedIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/add_employee');
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.deepOrange,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: true,
          items: const [ 

            BottomNavigationBarItem(
              icon:  Icon(Icons.list),
              activeIcon: Icon(Icons.list_outlined),
              label: 'Employee Future',
            ),
            BottomNavigationBarItem(
              icon:  Icon(Icons.list_outlined),
              label: 'Employee Stream',
            ),
          ],
        ),
        );
  }
}
