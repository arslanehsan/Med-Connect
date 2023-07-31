import 'package:image_picker/image_picker.dart';

class CustomerObject {
  String? uid;

  String? name, password, email;

  DateTime? registrationDate;

  XFile? profileImage;

  String? profileImageName, profileImageLink;

  CustomerObject({
    this.uid,
    this.name,
    this.password,
    this.email,
    this.profileImage,
    this.profileImageName,
    this.profileImageLink,
    this.registrationDate,
  });

  factory CustomerObject.fromJson(parsedJson) {
    print('Customer Data: $parsedJson');
    return CustomerObject(
      uid: parsedJson['uid'],
      name: parsedJson['name'],
      email: parsedJson['email'],
      registrationDate: DateTime.parse(parsedJson['registrationDate']),
      profileImageLink: parsedJson['profileImageLink'],
      profileImageName: parsedJson['profileImageName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['verified'] = false;
    data['registrationDate'] = DateTime.now().toString();
    data['profileImageName'] = profileImageName;
    data['profileImageLink'] = profileImageLink;

    return data;
  }
}
