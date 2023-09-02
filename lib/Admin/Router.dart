import 'package:flutter/material.dart';
import 'package:medconnect/Admin/Appointments/AdminAppointmentsView.dart';
import 'package:medconnect/Admin/Doctors/AdminAddNewDoctor.dart';
import 'package:medconnect/Objects/DoctorObject.dart';

import 'Doctors/AdminDoctorsView.dart';
import 'Doctors/AdminEditDoctor.dart';

class AdminRouterClass {
  adminDoctorsScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminDoctorsScreen(),
        ),
      );

  adminAppointmentsScreenRoute({required BuildContext context}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminAppointmentsView(),
        ),
      );

  adminAddNewDoctorScreenRoute({required BuildContext context}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminAddNewDoctor(),
        ),
      );

  adminEditDoctorScreenRoute(
          {required BuildContext context, required DoctorObject doctor}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminEditDoctor(
            doctor: doctor,
          ),
        ),
      );
}
