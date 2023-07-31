// appointment_model.dart
import 'dart:io';

class Appointment {
  String? appointmentId; // Unique identifier for the appointment
  String? description; // Unique identifier for the appointment
  String? doctorId,
      doctorName,
      customerName,
      customerId; // The ID of the doctor for this appointment
  DateTime? appointmentDateTime, submitTime;
  bool? status;
  File? reportFile;
  String? reportFileName, reportFileLink;
  List<String>? symptomsList;

  Appointment({
    this.appointmentId,
    this.doctorId,
    this.customerId,
    this.appointmentDateTime,
    this.submitTime,
    this.status,
    this.reportFile,
    this.reportFileName,
    this.reportFileLink,
    this.symptomsList,
    this.description,
    this.customerName,
    this.doctorName,
  });

  factory Appointment.fromJson(parsedJson) {
    print('Customer Data: $parsedJson');
    return Appointment(
      appointmentId: parsedJson['appointmentId'],
      doctorName: parsedJson['doctorName'],
      doctorId: parsedJson['doctorId'],
      customerName: parsedJson['customerName'],
      customerId: parsedJson['customerId'],
      appointmentDateTime: DateTime.parse(parsedJson['appointmentDateTime']),
      submitTime: DateTime.parse(parsedJson['submitTime']),
      status: parsedJson['status'],
      reportFileName: parsedJson['reportFileName'],
      reportFileLink: parsedJson['reportFileLink'],
      symptomsList: getSymptoms(line: parsedJson['symptomsList']),
      description: parsedJson['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentId'] = appointmentId;
    data['doctorName'] = doctorName;
    data['doctorId'] = doctorId;
    data['customerName'] = customerName;
    data['customerId'] = customerId;
    data['submitTime'] = DateTime.now().toString();
    data['appointmentDateTime'] = appointmentDateTime.toString();
    data['status'] = false;
    data['reportFileName'] = reportFileName;
    data['reportFileLink'] = reportFileLink;
    print('m called2');
    data['symptomsList'] = makeSymptomsString(data: symptomsList!);
    data['description'] = description;
    return data;
  }

  static List<String> getSymptoms({required String line}) {
    List<String> data = [];
    data = line.split('-sd-');

    return data;
  }

  static String makeSymptomsString({required List<String> data}) {
    String line = '';
    print('m called3');

    for (var element in data) {
      if (line.isEmpty) {
        line = element;
      } else {
        line = '$line-sd-$element';
      }
    }

    return line;
  }

  static dynamic getObjectList(Map<dynamic, dynamic> items) {
    List<Appointment> list = [];
    items.forEach((key, value) {
      list.add(Appointment.fromJson(value));
    });
    return list;
  }
}
