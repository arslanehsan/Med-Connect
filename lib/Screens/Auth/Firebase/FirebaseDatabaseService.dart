import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medconnect/Objects/DoctorObject.dart';

import '../../../Objects/CutomerObject.dart';

class AuthFirebaseDatabaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  Future<CustomerObject?> getCustomerProfile() async {
    CustomerObject customer = CustomerObject();

    DatabaseReference dbf = _firebaseDatabase
        .ref()
        .child('Customers')
        .child(FirebaseAuth.instance.currentUser!.uid);
    await dbf.once().then((snapshot) {
      customer = CustomerObject.fromJson(snapshot.snapshot.value);
    });

    return customer;
  }

  Future<void> saveDoctorInfoToDatabase(DoctorObject doctor) async {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('Doctors');

    databaseReference.push().set({
      doctor.toJson(),
    });
  }
}
