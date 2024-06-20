import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  
  // CREATE
  Future<void> addEmployeeDetails(Map<String, dynamic> employeeInfoMap, String id) async {
    employeeInfoMap["createdAt"] = FieldValue.serverTimestamp(); // Add timestamp
    await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }

  // READ
  Stream<QuerySnapshot> getEmployeeDetails() {
    return FirebaseFirestore.instance.collection("Employee").orderBy("createdAt", descending: true).snapshots();
  }

  // UPDATE
  Future<void> updateEmployeeDetail(String id, Map<String, dynamic> updateInfo) async {
    await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .update(updateInfo);
  }

  // DELETE
  Future<void> deleteEmployeeDetail(String id) async {
    await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .delete();
  }
}
