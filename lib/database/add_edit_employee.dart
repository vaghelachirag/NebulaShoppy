import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/database/database_helper.dart';
import 'package:nebulashoppy/database/employee.dart';
import 'package:nebulashoppy/database/employees_list.dart';

class AddEditEmployee extends StatefulWidget {
  bool isEdit;
  Employee selectedEmployee;

  AddEditEmployee(this.isEdit, this.selectedEmployee);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddEditEmployeeState();
  }
}

class AddEditEmployeeState extends State<AddEditEmployee> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerSalary = new TextEditingController();
  TextEditingController controllerAge = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (widget.isEdit) {
      controllerName.text = widget.selectedEmployee.empName;
      controllerSalary.text = widget.selectedEmployee.empSalary.toString();
      controllerAge.text = widget.selectedEmployee.empAge.toString();
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Employee Name:", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(controller: controllerName),
                    )
                  ],
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Employee Salary:", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                          controller: controllerSalary,
                          keyboardType: TextInputType.number),
                    )
                  ],
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Employee Age:", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                          controller: controllerAge,
                          keyboardType: TextInputType.number),
                    )
                  ],
                ),
                SizedBox(height: 100),
                RaisedButton(
                  color: Colors.grey,
                  child: Text("Submit",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  onPressed: () {
                    var getEmpName = controllerName.text;
                    var getEmpSalary = controllerSalary.text;
                    var getEmpAge = controllerAge.text;
                    if (getEmpName.isNotEmpty &&
                        getEmpSalary.isNotEmpty &&
                        getEmpAge.isNotEmpty) {
                      if (widget.isEdit) {
                        Employee updateEmployee = new Employee(
                            empId: widget.selectedEmployee.empId,
                            empName: getEmpName,
                            empSalary: getEmpSalary,
                            empAge: getEmpAge);
                        DatabaseHelper.instance.update(updateEmployee.toMap());
                      } else {
                        Employee addEmployee = new Employee(
                            empName: getEmpName,
                            empSalary: getEmpSalary,
                            empAge: getEmpAge, empId: 0);
                        DatabaseHelper.instance
                            .insert(addEmployee.toMapWithoutId());
                      }
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => EmployeesList()),
                              (r) => false);
                    }
                  },
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
