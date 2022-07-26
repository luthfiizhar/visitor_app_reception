import 'dart:convert';
import 'dart:io';

import 'package:visitor_app/constant.dart';
import 'package:http/http.dart' as http;
import 'package:visitor_app/main_model.dart';

Future getVisitorState(dynamic list, int index, MainModel model) async {
  print(list);
  var url = Uri.http(apiUrl, '/api/visitor/get-visitor-state');
  Map<String, String> requestHeader = {
    'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
    'Content-Type': 'application/json'
  };
  var bodySend = """ 
      {
          "Index": $index,
          "Attendants": $list
      }
    """;

  print(bodySend);
  try {
    var response = await http.post(url, headers: requestHeader, body: bodySend);
    var data = json.decode(response.body);
    if (data['Data']['LastVisitor'] == true) {
      model.setIsLastVisitor(true);
    } else {
      model.setIsLastVisitor(false);
    }
    print(data['Status']);
    return data;
  } on SocketException catch (e) {
    print(e);
  }
}

Future saveVisitorForm(
  String id,
  String firstName,
  String lastName,
  String email,
  int reason,
  int gender,
  String origin,
  String code,
  String number,
  String photo,
) async {
  print('savevisitorform');
  var url = Uri.http(apiUrl, '/api/visitor/visitor-form-tab');
  Map<String, String> requestHeader = {
    'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
    'Content-Type': 'application/json'
  };
  var bodySend = """ 
      {
            "VisitorID" : "$id",
            "FirstName" : "${firstName}",
            "LastName" : "${lastName}",
            "Email" : "${email}",
            "VisitReason" : $reason,
            "Gender" : $gender,
            "CompanyName" : "$origin",
            "Code" : "$code",
            "PhoneNumber" : "$number",
            "Photo" : "data:image/jpeg;base64,$photo"

      }
    """;

  print(bodySend);
  try {
    var response = await http.post(url, headers: requestHeader, body: bodySend);
    var data = json.decode(response.body);
    print(data);
    return data;
  } on SocketException catch (e) {
    print(e);
  }
}

Future onSiteCheckin(
  String firstName,
  String lastName,
  String email,
  int reason,
  int gender,
  String origin,
  String code,
  String number,
  String photo,
) async {
  var url = Uri.http(apiUrl, '/api/visitor/add-visitor-onsite');
  Map<String, String> requestHeader = {
    'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
    'Content-Type': 'application/json'
  };
  var bodySend = """ 
      {
            "FirstName" : "${firstName}",
            "LastName" : "${lastName}",
            "Email" : "${email}",
            "Reason" : $reason,
            "Gender" : $gender,
            "Company" : "$origin",
            "Code" : "$code",
            "PhoneNumber" : "$number",
            "Declaration" : 1,
            "Photo" : "data:image/jpeg;base64,$photo"

      }
    """;

  print(bodySend);
  try {
    var response = await http.post(url, headers: requestHeader, body: bodySend);
    var data = json.decode(response.body);
    print(data);
    return data;
  } on SocketException catch (e) {
    print(e);
  }
}

Future confirmAttendants(String listAttendant) async {
  var url = Uri.http(apiUrl, '/api/visitor/confirm-visitors-multiple');
  Map<String, String> requestHeader = {
    'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
    'Content-Type': 'application/json'
  };
  var bodySend = """ 
      {
            "Attendants": $listAttendant
      }
    """;

  print(bodySend);
  try {
    var response = await http.post(url, headers: requestHeader, body: bodySend);
    var data = json.decode(response.body);
    print(data);
    return data;
  } on SocketException catch (e) {
    print(e);
  }
}
