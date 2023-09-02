import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medconnect/Admin/AdminFirebaseHelper/AdminFirebaseDatabaseService.dart';
import 'package:medconnect/Objects/AppointmentObject.dart';
import 'package:medconnect/Utils/Colors.dart';

class AdminAppointmentsView extends StatefulWidget {
  const AdminAppointmentsView({super.key});

  @override
  State<AdminAppointmentsView> createState() => _AdminAppointmentsViewState();
}

class _AdminAppointmentsViewState extends State<AdminAppointmentsView> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  String deleting = '';
  List<Appointment> _appointments = [];

  Future<void> _getAppointments() async {
    await AdminFirebaseDatabaseService()
        .getAppointments()
        .then((appointmentsData) {
      if (appointmentsData.isNotEmpty) {
        setState(() {
          _appointments = appointmentsData;
        });
      }
    });
  }

  @override
  void initState() {
    _getAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: Container(
        height: _screenHeight,
        width: _screenWidth,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        child: ListView.builder(
            itemCount: _appointments.length,
            itemBuilder: (listContext, listIndex) {
              return _singleAppointmentView(
                  appointment: _appointments[listIndex], index: listIndex);
            }),
      ),
    );
  }

  Widget _singleAppointmentView(
      {required Appointment appointment, required int index}) {
    double boxWidth = _screenWidth;
    return GestureDetector(
      // onTap: () async => await AdminRouterClass()
      //     .adminEditAppointmentScreenRoute(
      //   context: context,
      //   appointment: appointment,
      // )
      //     .then(() {
      //   _getAppointments();
      // }),
      child: Container(
        width: boxWidth,
        // color: Colors.transparent,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppThemeColor.pureWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${index + 1} Appointment'),
                Text('Status: ${appointment.status! ? 'Complete' : 'Pending'}'),
              ],
            ),
            Text('Name: ${appointment.customerName}'),
            Text('Doctor Name: ${appointment.doctorName}'),
            Text(
                'Date: ${DateFormat('EEEE d MMMM hh:mm aa').format(appointment.appointmentDateTime!)}'),
          ],
        ),
      ),
    );
  }
}
