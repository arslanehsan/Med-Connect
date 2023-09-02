import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medconnect/Objects/DoctorObject.dart';

import '../Objects/AppSettingsObject.dart';
import '../Objects/AppointmentObject.dart';

class FirebaseDatabaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  Future<List<DoctorObject>> getDoctors() async {
    List<DoctorObject> checkoutsData = [];

    final dbf = _firebaseDatabase.ref().child('Doctors');

    await dbf.once().then((snapshot) {
      Map<dynamic, dynamic>? value =
          snapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (value != null) {
        checkoutsData = DoctorObject.getObjectList(value);
      }
    });
    return checkoutsData
      ..sort((a, b) => b.registrationDate!.compareTo(a.registrationDate!));
  }

  Future<AppSettingsObject?> getAppSettings() async {
    AppSettingsObject? appSettings;

    final topUserPostsRef = FirebaseDatabase.instance.ref('AppSettings');
    try {
      await topUserPostsRef.once().then((snapshot) {
        Map<dynamic, dynamic>? value =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;
        if (value != null) {
          appSettings = AppSettingsObject.fromJson(value);
        }
      });

      return appSettings;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Appointment>> getAppointments() async {
    List<Appointment> appointmentsData = [];

    final dbf = _firebaseDatabase
        .ref()
        .child('Appointments')
        .orderByChild('customerId')
        .equalTo(FirebaseAuth.instance.currentUser!.uid);

    await dbf.once().then((snapshot) {
      Map<dynamic, dynamic>? value =
          snapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (value != null) {
        appointmentsData = Appointment.getObjectList(value);
      }
    });
    return appointmentsData
      ..sort(
          (a, b) => b.appointmentDateTime!.compareTo(a.appointmentDateTime!));
  }
}
