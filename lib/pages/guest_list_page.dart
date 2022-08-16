import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/class/visitor.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/notif_dialog.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/constant.dart';
import 'package:visitor_app/functions/hive_functions.dart';
import 'package:visitor_app/functions/request_api.dart';
import 'package:visitor_app/main_model.dart';
import 'package:visitor_app/pages/go_to_security_page.dart';
import 'package:visitor_app/pages/new_guest_page.dart';
import 'package:http/http.dart' as http;
import 'package:visitor_app/pages/visitor_info_page.dart';
import 'package:visitor_app/pages/visitor_info_reserved_page.dart';

class GuestListPage extends StatefulWidget {
  const GuestListPage({Key? key}) : super(key: key);

  @override
  State<GuestListPage> createState() => _GuestListPageState();
}

class _GuestListPageState extends State<GuestListPage> {
  bool checkGuest = false;
  List<GuestList> items = [];
  List<Visitor> visitorList = [];
  List<Visitor> attendantList = [];
  dynamic detailVisitor;
  final List<Visitor> selectedVisitor = [];
  bool firstNameEmpty = false;
  bool lastNameEmpty = false;
  bool phoneCodeEmpty = false;
  bool phoneNumberEmpty = false;
  bool originEmpty = false;
  bool reasonEmpty = false;
  bool employeeEmpty = false;

  List reasonVisitList = [];

  var listSelected;

  Future checkGuestStatus(List<Visitor> list) async {
    var status = false;
    for (var element in list) {
      if (element.status!.contains("RESERVED")) {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => GoToSecurityPage(),
        // ));
        print('status reserved');
        status = true;
      }
    }
    // list.map((e) {});
    return status;
  }

  @override
  void initState() {
    super.initState();
    getAttendants().then((value) {
      // print(value.toString());
      setState(() {});
    });
  }

  Future getVisitorDetail() async {
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
                  "VisitorID" : "VT-4"
              }
          ]
      }
    """;
    try {
      var response =
          await http.post(url, headers: requestHeader, body: bodySend);
      var data = json.decode(response.body);
      detailVisitor = data['Data'][0];
      print(detailVisitor);
    } on SocketException catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future getVisitReason() async {
    var url = Uri.https(
        apiUrl, '/VisitorManagementBackend/public/api/visitor/visit-reason');
    Map<String, String> requestHeader = {
      'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
      'Content-Type': 'application/json'
    };
    try {
      var response = await http.get(url, headers: requestHeader);
      var data = json.decode(response.body);
      print(data);
    } on SocketException catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future getAttendants() async {
    var listBox = await Hive.openBox('listBox');
    dynamic attendant =
        listBox.get('attendants') != "" ? listBox.get('attendants') : "";
    // attendantList = json.decode(attendants);

    // attendant = json.encode(attendant);
    print(attendant);
    for (var element in attendant) {
      visitorList.add(Visitor(
        visitorId: element['VisitorID'],
        firstName: element['FirstName'],
        lastName: element['LastName'] != null ? element['LastName'] : "",
        completed: element['ApprovementStep'] == 0 ? false : true,
        status: element['Status'],
        enabled: false,
      ));
    }
    // return attendants;
  }

  checkData() {
    setState(() {
      for (var element in visitorList) {
        if (element.firstName == "" ||
            element.lastName == "" ||
            element.email == "" ||
            element.origin == "" ||
            element.employee == "" ||
            element.phoneCode == "" ||
            element.phoneNumber == "" ||
            element.gender == "" ||
            element.reason == "") {
          // setState(() {
          element.completed = false;
          // });
        } else {
          // setState(() {
          element.completed = true;
          // });
        }
      }
    });

    // visitorList.map((element) {
    //   if (element.firstName == "" ||
    //       element.lastName == "" ||
    //       element.email == "" ||
    //       element.origin == "" ||
    //       element.employee == "" ||
    //       element.phoneCode == "" ||
    //       element.phoneNumber == "" ||
    //       element.gender == "" ||
    //       element.reason == "") {
    //     element.completed = false;
    //   } else {
    //     element.completed = true;
    //   }
    // });
    // var completed = visitorList.every((element) {
    //   if (element.firstName! == "" ||
    //       element.lastName! == "" ||
    //       element.email! == "" ||
    //       element.origin! == "" ||
    //       element.employee! == "" ||
    //       element.phoneCode! == "" ||
    //       element.phoneNumber! == "") {
    //     element.completed = false;
    //     return false;
    //   }
    //   element.completed = true;
    //   return true;
    // });
    // return true;
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => checkData());
    // String selected = "";
    return Consumer<MainModel>(builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(75), child: CustAppBar()),
          body: Container(
            padding: EdgeInsets.only(top: 20, left: 100, right: 100),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Visitor List',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                          color: eerieBlack),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        RichText(
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          text: TextSpan(
                              text: 'Employee: ',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF393E46)),
                              children: [
                                TextSpan(
                                  text: '${model.employee}',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF393E46)),
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Invitation Code: ',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF393E46)),
                            children: [
                              TextSpan(
                                text: '${model.inviteCode}',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF393E46)),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Date: ',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF393E46)),
                            children: [
                              TextSpan(
                                text: '${model.visitDate}',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF393E46)),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 700,
                  padding: EdgeInsets.only(top: 50),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: visitorList
                        .map((map) => Column(
                              children: [
                                ListTile(
                                  contentPadding:
                                      EdgeInsets.only(top: 30, bottom: 30),
                                  title: Text(
                                    map.firstName.toString() +
                                        " " +
                                        map.lastName.toString(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w300,
                                        color: onyxBlack),
                                  ),
                                  subtitle: map.status == "INVITED"
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            'Data not complete',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w300,
                                                color: orangeRed),
                                          ),
                                        )
                                      : map.status == "RESERVED"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                'Visitor not verified',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w300,
                                                    color: orangeRed),
                                              ),
                                            )
                                          : map.status == "CHECKED IN"
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Text(
                                                    'Already Checked In',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: onyxBlack),
                                                  ),
                                                )
                                              : null,
                                  trailing: Transform.scale(
                                    scale: 1.5,
                                    child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      checkColor: scaffoldBg,
                                      activeColor: onyxBlack,
                                      value: map.status == "CHECKED IN"
                                          ? false
                                          : map.enabled,
                                      onChanged: (enabled) {
                                        print(enabled);
                                        if (enabled!) {
                                          if (selectedVisitor.isNotEmpty) {
                                            // selectedVisitor.removeLast();
                                          }
                                          if (map.status != "CHECKED IN") {
                                            model.setStatusVisitor(map.status!);
                                            selectedVisitor.add(Visitor(
                                                visitorId: map.visitorId,
                                                firstName: map.firstName,
                                                lastName: map.lastName,
                                                status: map.status,
                                                email: map.email,
                                                origin: map.origin,
                                                employee: map.employee,
                                                gender: map.gender,
                                                phoneCode: map.phoneCode,
                                                phoneNumber: map.phoneNumber,
                                                completed: map.completed,
                                                reason: map.reason));
                                          }
                                          setState(() {
                                            listSelected =
                                                json.encode(selectedVisitor);
                                          });
                                          print(listSelected);
                                        } else {
                                          print('uncheck');
                                          selectedVisitor.removeWhere(
                                              (element) =>
                                                  element.visitorId ==
                                                  map.visitorId);
                                          // selectedVisitor.remove(map.visitorId);
                                          // setState(() {});
                                          setState(() {
                                            listSelected =
                                                json.encode(selectedVisitor);
                                          });
                                          print(listSelected);
                                        }
                                        map.enabled = enabled;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                                // CheckboxListTile(
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(5),
                                //   ),
                                //   checkboxShape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(5),
                                //   ),
                                //   checkColor: Colors.white,
                                //   activeColor: redBright,
                                //   contentPadding:
                                //       EdgeInsets.only(top: 30, bottom: 30),
                                //   title: Text(
                                //     map.label,
                                //     style: GoogleFonts.workSans(
                                //         textStyle: TextStyle(
                                //           fontSize: 30,
                                //           fontWeight: FontWeight.w400,
                                //         ),
                                //         color: Color(0xFF393E46)),
                                //   ),
                                //   value: map.enabled,
                                //   onChanged: (enabled) {
                                //     setState(() {
                                //       map.enabled = enabled!;
                                //     });
                                //   },
                                // ),
                                Divider(
                                  color: eerieBlack,
                                  thickness: 2,
                                )
                              ],
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 55, bottom: 20),
                  child: model.buttonLoading
                      ? CircularProgressIndicator(
                          color: eerieBlack,
                        )
                      : SizedBox(
                          height: 80,
                          width: 600,
                          child: RegularButton(
                            title: 'Next',
                            onTap: () {
                              var index = model.indexPage;
                              setState(() {
                                model.setButtonLoading(true);
                              });
                              // index++;
                              model.updateIndex(1);
                              print(model.indexPage);
                              if (selectedVisitor.isEmpty) {
                                // print('empty');
                                notifDialog(
                                        context, false, 'Please select visitor')
                                    .then((value) {
                                  setState(() {});
                                  model.setButtonLoading(false);
                                });
                              } else {
                                checkGuestStatus(selectedVisitor).then((value) {
                                  // setState(() {
                                  //   model.setButtonLoading(false);
                                  // });
                                  print(value);
                                  if (!value) {
                                    model.setListSelectedVisitor(listSelected);
                                    print(model.listSelectedVisitor);
                                    getVisitorState(listSelected,
                                            model.indexPage, model)
                                        .then((value) {
                                      model.setStatusVisitor(
                                          value['Data']['VisitorStatus']);
                                      setState(() {});
                                      print(value);
                                      model.setisEdit(true);
                                      if (value['Status'] == '200') {
                                        model.setIsLastVisitor(
                                            value['Data']['LastVisitor']);
                                        if (value['Data']['VisitorStatus'] ==
                                            'INVITED') {
                                          model.setFirstName(value['Data']
                                              ['VisitorData']['FirstName']);
                                          model.setLastName(value['Data']
                                                  ['VisitorData']['LastName'] ??
                                              "");
                                          model.setEmail(value['Data']
                                              ['VisitorData']['Email']);
                                          model.setVisitorId(value['Data']
                                              ['VisitorData']['VisitorID']);
                                          model.setButtonLoading(false);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  NewGuestPage(
                                                isEdit: true,
                                              ),
                                            ),
                                          ).then((value) {
                                            setState(() {});
                                            for (var element in visitorList) {
                                              element.enabled = false;
                                            }
                                            selectedVisitor.clear();
                                          });
                                        }
                                        if (value['Data']['VisitorStatus'] ==
                                            'RESERVED') {
                                          print('reserved');
                                          model.setFirstName(value['Data']
                                              ['VisitorData']['FirstName']);
                                          model.setLastName(value['Data']
                                                          ['VisitorData']
                                                      ['LastName'] !=
                                                  null
                                              ? value['Data']['VisitorData']
                                                  ['LastName']
                                              : "");
                                          model.setEmail(value['Data']
                                              ['VisitorData']['Email']);
                                          model.setVisitorId(value['Data']
                                              ['VisitorData']['VisitorID']);
                                          model.setPhoneCode(value['Data']
                                              ['VisitorData']['CountryCode']);
                                          model.setPhoneNumber(value['Data']
                                              ['VisitorData']['PhoneNumber']);
                                          model.setOrigin(value['Data']
                                              ['VisitorData']['CompanyName']);
                                          model.setPhoto(value['Data']
                                                      ['VisitorData']
                                                  ['VisitorPhoto']
                                              .toString()
                                              .split(',')
                                              .last);
                                          model.setGender(value['Data']
                                              ['VisitorData']['Gender']);
                                          model.setReason(value['Data']
                                              ['VisitorData']['VisitReason']);
                                          model.setCompletePhoneNumber('+' +
                                              value['Data']['VisitorData']
                                                  ['CountryCode'] +
                                              value['Data']['VisitorData']
                                                  ['PhoneNumber']);
                                          model.setButtonLoading(false);
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VisitorInfoPage(
                                                visitorId: model.visitorId,
                                                firstName: model.firstName,
                                                lastName: model.lastName,
                                                email: model.email,
                                                gender: model.gender,
                                                visitReason: model.reason,
                                                employee: model.employee,
                                                visitDate: model.visitDate,
                                                origin: model.origin,
                                                photo: model.photo,
                                                phoneCode: model.phoneCode,
                                                phoneNumber: model.phoneNumber,
                                                completePhoneNumber:
                                                    model.completePhoneNumber,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            selectedVisitor.clear();
                                            for (var element in visitorList) {
                                              element.enabled = false;
                                            }
                                            setState(() {});
                                          });
                                        }
                                        if (value['Data']['VisitorStatus'] ==
                                            'APPROVED') {
                                          print('approved');
                                          model.setFirstName(value['Data']
                                              ['VisitorData']['FirstName']);
                                          model.setLastName(value['Data']
                                                          ['VisitorData']
                                                      ['LastName'] !=
                                                  null
                                              ? value['Data']['VisitorData']
                                                  ['LastName']
                                              : "");
                                          model.setEmail(value['Data']
                                              ['VisitorData']['Email']);
                                          model.setVisitorId(value['Data']
                                              ['VisitorData']['VisitorID']);
                                          model.setPhoneCode(value['Data']
                                              ['VisitorData']['CountryCode']);
                                          model.setPhoneNumber(value['Data']
                                              ['VisitorData']['PhoneNumber']);
                                          model.setOrigin(value['Data']
                                              ['VisitorData']['CompanyName']);
                                          model.setPhoto(value['Data']
                                                      ['VisitorData']
                                                  ['VisitorPhoto']
                                              .toString()
                                              .split(',')
                                              .last);
                                          // model.setVisitDate(
                                          //     value['Data']['VisitorData']['VisitTime']);
                                          model.setGender(value['Data']
                                              ['VisitorData']['Gender']);
                                          model.setReason(value['Data']
                                              ['VisitorData']['VisitReason']);
                                          model.setCompletePhoneNumber('+' +
                                              value['Data']['VisitorData']
                                                  ['CountryCode'] +
                                              value['Data']['VisitorData']
                                                  ['PhoneNumber']);
                                          model.setButtonLoading(false);
                                          setState(() {});
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VisitorInfoPage(
                                                visitorId: model.visitorId,
                                                firstName: model.firstName,
                                                lastName: model.lastName,
                                                email: model.email,
                                                gender: model.gender,
                                                visitReason: model.reason,
                                                employee: model.employee,
                                                visitDate: model.visitDate,
                                                origin: model.origin,
                                                photo: model.photo,
                                                phoneCode: model.phoneCode,
                                                phoneNumber: model.phoneNumber,
                                                completePhoneNumber:
                                                    model.completePhoneNumber,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            selectedVisitor.clear();
                                            for (var element in visitorList) {
                                              element.enabled = false;
                                            }
                                            setState(() {});
                                          });
                                        }
                                      } else {
                                        print('Failed');
                                      }
                                    });
                                    print(selectedVisitor.toList());
                                  } else {
                                    model.setButtonLoading(false);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => GoToSecurityPage(),
                                    ));
                                  }
                                });
                              }
                            },
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class GuestList {
  bool enabled;
  String label;
  bool completed;

  GuestList(this.enabled, this.label, this.completed);
}

class Selected {
  String firstName;

  Selected(this.firstName);
}
