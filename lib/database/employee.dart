import 'package:flutter/cupertino.dart';

class Employee{

  int empId;
  String empName,empSalary, empAge;

  Employee({required this.empId, required this.empName, required this.empSalary, required this.empAge});

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["emp_name"] = empName;
    map["emp_salary"] = empSalary;
    map["emp_age"] = empAge;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["emp_id"] = empId;
    map["emp_name"] = empName;
    map["emp_salary"] = empSalary;
    map["emp_age"] = empAge;
    return map;
  }

  //to be used when converting the row into object
  factory Employee.fromMap(Map<String, dynamic> data) => new Employee(
      empId: data['emp_id'],
      empName: data['emp_name'],
      empSalary: data['emp_salary'],
      empAge: data['emp_age']
  );
}
