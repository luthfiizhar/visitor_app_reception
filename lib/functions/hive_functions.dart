import 'package:hive/hive.dart';

Future saveVisitorData(
    String firstName,
    String lastName,
    String gender,
    String email,
    String phoneCode,
    String phoneNumber,
    String origin,
    String employee,
    String reason,
    bool completed) async {
  var box = await Hive.openBox('visitorBox');
  box.put('firstName', firstName != null ? firstName : "");
  box.put('lastName', lastName != null ? lastName : "");
  box.put('gender', gender != null ? gender : "");
  box.put('email', email != null ? email : "");
  box.put('phoneCode', phoneCode != null ? phoneCode : "");
  box.put('phoneNumber', phoneNumber != null ? phoneNumber : "");
  box.put('origin', origin != null ? origin : "");
  box.put('employee', employee != null ? employee : "");
  box.put('reason', reason != null ? reason : "");
  box.put('completed', completed);

  var name;
  name = box.get('firstName');
  print('saved');
  // print(name);
}

Future clearVisitorData() async {
  var box = await Hive.openBox('visitorBox');
  box.delete('firstName');
  // box.delete('firstName', '');
  box.delete('lastName');
  box.delete('gender');
  box.delete('email');
  box.delete('phoneCode');
  box.delete('phoneNumber');
  box.delete('origin');
  box.delete('employee');
  box.delete('reason');
  print('deleted');
}
