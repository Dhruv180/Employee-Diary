import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_project/Pages/employee.dart';
import 'package:crud_project/services/database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<QuerySnapshot> employeeStream;

  @override
  void initState() {
    super.initState();
    // Initialize the stream only once in initState
    employeeStream = DatabaseMethods().getEmployeeDetails();
  }

  void getEmployeeDetails() {
    setState(() {
      employeeStream = DatabaseMethods().getEmployeeDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Employee()),
          ).then((_) => getEmployeeDetails());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "EMPLOYEE",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "  DETAILS",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: StreamBuilder(
          stream: employeeStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No Employees found"));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text("Name: ${ds["Name"]}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Age: ${ds["Age"]}"),
                        Text("location: ${ds["location"]}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Navigate to edit screen
                            navigateToEditScreen(ds);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Show confirmation dialog
                            showDeleteDialog(ds.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void navigateToEditScreen(DocumentSnapshot ds) {
    TextEditingController nameController = TextEditingController(text: ds["Name"]);
    TextEditingController ageController = TextEditingController(text: ds["Age"].toString());
    TextEditingController locationController = TextEditingController(text: ds["location"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Employee"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _RangeTextInputFormatter(min: 1, max: 100),
              ],
              decoration: InputDecoration(
                labelText: "Age",
              ),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: "location",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              String id = ds.id;
              Map<String, dynamic> updateInfo = {
                "Name": nameController.text.trim(),
                "Age": int.tryParse(ageController.text.trim()) ?? 0,
                "location": locationController.text.trim(),
              };
              if (updateInfo["Name"].isEmpty || updateInfo["Age"] == 0) {
                // Optionally show a snackbar or alert for invalid input
                return;
              }
              await DatabaseMethods().updateEmployeeDetail(id, updateInfo);
              Navigator.pop(context);
              getEmployeeDetails(); // Refresh the employee list
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Employee"),
        content: Text("Are you sure you want to delete this employee?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await DatabaseMethods().deleteEmployeeDetail(id);
              Navigator.pop(context);
              getEmployeeDetails(); // Refresh the employee list
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }
}

class _RangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  _RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return TextEditingValue();
    }

    try {
      final number = int.parse(newValue.text);
      if (number < min || number > max) {
        return oldValue;
      }
      return newValue;
    } catch (e) {
      return oldValue;
    }
  }
}
