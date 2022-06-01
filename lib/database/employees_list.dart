import 'package:flutter/material.dart';
import 'package:nebulashoppy/database/add_edit_employee.dart';
import 'package:nebulashoppy/database/database_helper.dart';
import 'package:nebulashoppy/database/employee.dart';


class EmployeesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmployeesListState();
  }
}

class EmployeesListState extends State<EmployeesList> {
  List<Employee> listEmployees = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Sqflite Sample"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
              
              },
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
                itemCount: listEmployees.length,
                itemBuilder: (context, position) {
                  Employee getEmployee = listEmployees[position];
                  var salary = getEmployee.empSalary;
                  var age = getEmployee.empAge;
                  return Card(
                    elevation: 8,
                    child: Container(
                      height: 80,
                      padding: EdgeInsets.all(15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(getEmployee.empName,
                                  style: TextStyle(fontSize: 18))),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 45),
                              child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AddEditEmployee(
                                                true, getEmployee)));
                                  }),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: (){
                                  DatabaseHelper.instance.delete(getEmployee.empId);
                                  setState(() => {
                                    listEmployees.removeWhere((item) => item.empId == getEmployee.empId)
                                  });
                                }),
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Salary: $salary | Age: $age",
                                  style: TextStyle(fontSize: 18))),
                        ],
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
