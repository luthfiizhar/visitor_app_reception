import 'dart:convert';
import 'dart:io';

import 'package:visitor_app/constant.dart';
import 'package:http/http.dart' as http;
import 'package:visitor_app/main_model.dart';

Future getVisitorDetail(String visitorId) async {
  var url = Uri.https(apiUrl,
      '/VisitorManagementBackend/public/api/visitor/get-visitor-detail-list');
  Map<String, String> requestHeader = {
    'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
    'Content-Type': 'application/json'
  };
  var bodySend = """ 
      {
          "Visitors" : [
              {
                  "VisitorID" : "$visitorId"
              }
          ]
      }
    """;
  try {
    var response = await http.post(url, headers: requestHeader, body: bodySend);
    var data = json.decode(response.body);
    print(data['Status']);
    return data;
  } on SocketException catch (e) {
    print(e);
  }
}

Future getVisitorState(dynamic list, int index, MainModel model) async {
  print(list);
  var url = Uri.https(
      apiUrl, '/VisitorManagementBackend/public/api/visitor/get-visitor-state');
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
    if (data != null) {
      model.setButtonLoading(false);
    }
    if (data['Data']['LastVisitor'] == true) {
      model.setIsLastVisitor(true);
    } else {
      model.setIsLastVisitor(false);
    }
    print(data['Status']);
    return data;
  } on SocketException catch (e) {
    model.setButtonLoading(false);
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
    MainModel model) async {
  print('savevisitorform');
  var url = Uri.https(
      apiUrl, '/VisitorManagementBackend/public/api/visitor/visitor-form-tab');
  Map<String, String> requestHeader = {
    'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
    'Content-Type': 'application/json'
  };
  var bodySend = """ 
      {
            "VisitorID" : "$id",
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
    if (data != null) {
      model.setButtonLoading(false);
    }
    print(data);
    return data;
  } on SocketException catch (e) {
    model.setButtonLoading(false);
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
  String employee,
  MainModel model,
) async {
  var url = Uri.https(apiUrl,
      '/VisitorManagementBackend/public/api/visitor/add-visitor-onsite');
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
            "EmployeeName" : "$employee",
            "Photo" : "data:image/jpeg;base64,$photo"

      }
    """;

  print(bodySend);
  try {
    var response = await http.post(url, headers: requestHeader, body: bodySend);
    var data = json.decode(response.body);
    model.setButtonLoading(false);
    print(data);
    return data;
  } on SocketException catch (e) {
    model.setButtonLoading(false);
    print(e);
  }
}

Future confirmAttendants(String listAttendant, MainModel model) async {
  var url = Uri.https(apiUrl,
      '/VisitorManagementBackend/public/api/visitor/confirm-visitors-multiple');
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
    model.setButtonLoading(false);
    return data;
  } on SocketException catch (e) {
    model.setButtonLoading(false);
    print(e);
  }
}
