import 'package:employee_book/data/local/db/app_db.dart';
import 'package:flutter/material.dart';

class EmployeeChangeNotifier extends ChangeNotifier {
  AppDb? _appDb;

  void initAppDb(AppDb db) {
    _appDb = db;
  }

  List<EmployeeData> _employeeListFuture = [];
  List<EmployeeData> get employeeListFuture => _employeeListFuture;
  List<EmployeeData> _employeeListStream = [];
  List<EmployeeData> get employeeListStream => _employeeListStream;
  EmployeeData? _employeeData;
  EmployeeData get employeeData => _employeeData!;
  String _error = '';
  String get error => _error;
  bool _isAdded = false;
  bool get added => _isAdded;
  bool _isUpdated = false;
  bool get isUpdated => _isUpdated;
  bool _isDeleted = false;
  bool get isDeleted => _isDeleted;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void getEmployeeFuture() {
    _isLoading = true;
    _appDb?.getAllEmployees().then((value) {
      _employeeListFuture = value;
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _error = error.toString();
      _isLoading = false;
      notifyListeners();
    });
  }

  void getEmployeeStream() {
    _isLoading = true;
    _appDb?.getEmployeeStream().listen((event) {
      _employeeListStream = event;
    });
      _isLoading = false;
      notifyListeners();

  }

  void getSingleEmployee(int id) {
    _isLoading = true;
    _appDb?.getEmpyloyeeById(id).then((value) {
      _employeeData = value;
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _error = error.toString();
      _isLoading = false;
      notifyListeners();
    });
  }

  void createEmployee(EmployeeCompanion employee) {
    _appDb?.insertEmployee(employee).then((value) {
      _isAdded = value >= 1 ? true : false;
      notifyListeners();
    }).catchError((error) {
      _error = error.toString();
      notifyListeners();
    });
  }

  updateEmployee(EmployeeCompanion employee) {
    _appDb?.updateEmployee(employee).then((value) {
      _isUpdated = value;
      notifyListeners();
    }).onError((error, stackTrace) {
      _error = error.toString();
      notifyListeners();
    });
  }

  void deleteEmployee(int id) {
    _appDb?.deleteEmployee(id).then((value) {
      _isDeleted = value == 1 ? true : false;
      notifyListeners();
    }).catchError((error) {
      _error = error.toString();
      notifyListeners();
    });
  }
}
