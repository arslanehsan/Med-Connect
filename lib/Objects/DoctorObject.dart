import 'package:image_picker/image_picker.dart';

class DoctorObject {
  String? id; // Unique identifier for the doctor
  String? name;
  String? specialist;
  String? qualification;
  String? clinicName;
  String? clinicAddress;
  String? email;
  String? phone;
  XFile? profileImage;
  String? profileImageName, profileImageLink;
  DateTime? registrationDate;
  bool? available;
  // List<String>? availableDays;
  // List<String>? availableTimeSlots;

  DoctorObject({
    this.id,
    this.name,
    this.specialist,
    this.qualification,
    this.clinicName,
    this.clinicAddress,
    this.email,
    this.phone,
    this.profileImage,
    this.profileImageLink,
    this.profileImageName,
    this.registrationDate,
    this.available,
    //  this.availableDays,
    //  this.availableTimeSlots,
  });

  factory DoctorObject.fromJson(parsedJson) {
    print('Customer Data: $parsedJson');
    return DoctorObject(
      id: parsedJson['id'],
      name: parsedJson['name'],
      email: parsedJson['email'],
      phone: parsedJson['phone'],
      available: parsedJson['available'],
      registrationDate: DateTime.parse(parsedJson['registrationDate']),
      profileImageName: parsedJson['profileImageName'],
      profileImageLink: parsedJson['profileImageLink'],
      specialist: parsedJson['specialist'],
      qualification: parsedJson['qualification'],
      clinicName: parsedJson['clinicName'],
      clinicAddress: parsedJson['clinicAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['available'] = true;
    data['registrationDate'] = DateTime.now().toString();
    data['profileImageName'] = profileImageName;
    data['profileImageLink'] = profileImageLink;
    data['specialist'] = specialist;
    data['qualification'] = qualification;
    data['clinicName'] = clinicName;
    data['clinicAddress'] = clinicAddress;
    return data;
  }

  static dynamic getObjectList(Map<dynamic, dynamic> items) {
    List<DoctorObject> list = [];
    items.forEach((key, value) {
      list.add(DoctorObject.fromJson(value));
    });
    return list;
  }
}
