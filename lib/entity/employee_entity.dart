import 'package:drift/drift.dart';

class Employee extends Table {
  IntColumn get id => integer().autoIncrement()();
}
