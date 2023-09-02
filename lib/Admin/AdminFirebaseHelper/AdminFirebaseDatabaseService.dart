import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:medconnect/Objects/AppointmentObject.dart';
import 'package:medconnect/Objects/DoctorObject.dart';

class AdminFirebaseDatabaseService {
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

  Future<List<Appointment>> getAppointments() async {
    List<Appointment> appointmentsData = [];

    final dbf = _firebaseDatabase.ref().child('Appointments');

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

  Future<bool> deleteDoctor({required DoctorObject doctor}) async {
    DatabaseReference dbf = _firebaseDatabase.ref();
    bool done = false;
    try {
      await FirebaseStorage.instance
          .ref()
          .child('DoctorProfileImages')
          .child('${doctor.profileImageName}')
          .delete()
          .then((uploadTask) async {
        await dbf.child('Doctors').child(doctor.id!).remove().then((value) {
          done = true;
        });
      });

      return done;
    } catch (e) {
      print("Delete Category Error");
      print(e);
      return false;
    }
  }
}
