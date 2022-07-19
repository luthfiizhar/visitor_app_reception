import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:visitor_app/class/visitor.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/constant.dart';
import 'package:visitor_app/functions/hive_functions.dart';
import 'package:visitor_app/pages/new_guest_page.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(GuestList(false, 'Ayana Dunne', true));
    items.add(GuestList(false, 'Jacques Sierra', true));
    items.add(GuestList(false, 'Sion Goulding', false));
    items.add(GuestList(false, 'Theodora Neal', false));
    items.add(GuestList(false, 'Coco Mcmillan', true));
    items.add(GuestList(false, 'Yasin Barber', true));

    // visitorList.add(Visitor(
    //     firstName: 'Ayana',
    //     lastName: 'Dunne',
    //     email: 'ayadunne@gmail.com',
    //     phoneCode: '62',
    //     phoneNumber: '8585858585',
    //     origin: 'PT XYZ',
    //     employee: 'Mr A',
    //     reason: '2',
    //     gender: '2',
    //     enabled: false,
    //     completed: true));
    // visitorList.add(Visitor(
    //     firstName: 'Jaques',
    //     lastName: 'Sierra',
    //     email: 'jaques@gmail.com',
    //     phoneCode: '62',
    //     phoneNumber: '8585858585',
    //     origin: 'PT XYZ',
    //     employee: 'Mr B',
    //     reason: '1',
    //     gender: '1',
    //     enabled: false,
    //     completed: true));
    // visitorList.add(Visitor(
    //     firstName: 'Sion',
    //     lastName: 'Goulding',
    //     email: 'sion@gmail.com',
    //     phoneCode: '62',
    //     phoneNumber: '8585858585',
    //     origin: 'PT XYZ',
    //     employee: 'Mr C',
    //     reason: '',
    //     gender: '1',
    //     enabled: false,
    //     completed: true));
    // visitorList.add(Visitor(
    //     firstName: 'Theodora',
    //     lastName: 'Neal',
    //     email: 'theodora@gmail.com',
    //     phoneCode: '62',
    //     phoneNumber: '8585858585',
    //     origin: 'PT XYZ',
    //     employee: 'Mr A',
    //     reason: '',
    //     gender: '2',
    //     enabled: false,
    //     completed: true));
    // items.add(GuestList(false, 'Ayana Dunne', true));
    // checkData();
    // print(visitorList);
    // log(visitorList.toString());
    getAttendants().then((value) {
      // print(value.toString());
      setState(() {});
    });
  }

  Future getVisitorDetail() async {
    var url = Uri.http(apiUrl, '/api/visitor/get-visitor-detail-list');
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

  Future getAttendants() async {
    var listBox = await Hive.openBox('listBox');
    dynamic attendant =
        listBox.get('attendants') != "" ? listBox.get('attendants') : "";
    // attendantList = json.decode(attendants);

    // attendant = json.encode(attendant);
    print(attendant[1]);
    for (var element in attendant) {
      visitorList.add(Visitor(
        firstName: element['FirstName'],
        lastName: element['LastName'],
        completed: element['ApprovementStep'] == 0 ? false : true,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Employee: ',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF393E46)),
                          children: [
                            TextSpan(
                              text: '151839 - Edward Evannov',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
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
                              text: '1st July 2022',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
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
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF393E46)),
                                ),
                                subtitle: !map.completed!
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Data not complete',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: silver),
                                        ),
                                      )
                                    : null,
                                trailing: Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    // fillColor:
                                    //     MaterialStateProperty.resolveWith<Color>(
                                    //         (states) {
                                    //   if (states
                                    //       .contains(MaterialState.disabled)) {
                                    //     return redBright;
                                    //   }
                                    //   return redBright;
                                    // }),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    // checkboxShape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(5),
                                    // ),
                                    checkColor: Colors.white,
                                    activeColor: eerieBlack,
                                    value: map.enabled,
                                    onChanged: (enabled) {
                                      if (enabled!) {
                                        if (selectedVisitor.isNotEmpty) {
                                          selectedVisitor.removeLast();
                                        }
                                        selectedVisitor.add(Visitor(
                                            firstName: map.firstName,
                                            lastName: map.lastName,
                                            email: map.email,
                                            origin: map.origin,
                                            employee: map.employee,
                                            gender: map.gender,
                                            phoneCode: map.phoneCode,
                                            phoneNumber: map.phoneNumber,
                                            completed: map.completed,
                                            reason: map.reason));
                                        print(selectedVisitor);
                                      } else {
                                        selectedVisitor.removeLast();
                                        print(selectedVisitor);
                                      }
                                      for (var element in visitorList) {
                                        element.enabled = false;
                                      }
                                      map.enabled = enabled;
                                      // selectedVisitor.removeLast();
                                      // selectedVisitor.add(
                                      //     Visitor(firstName: map.firstName));
                                      // print(selectedVisitor);
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
                padding: const EdgeInsets.only(top: 100),
                child: SizedBox(
                  height: 80,
                  width: 600,
                  child: RegularButton(
                    title: 'Next',
                    onTap: () {
                      if (selectedVisitor.isEmpty) {
                        print('empty');
                      } else {
                        selectedVisitor.forEach((element) {
                          // clearVisitorData();
                          if (element.completed == true) {
                            getVisitorDetail().then((value) {
                              // for (var x in detailVisitor) {
                              saveVisitorData(
                                      detailVisitor['FirstName'],
                                      detailVisitor['LastName'],
                                      detailVisitor['Gender'],
                                      detailVisitor['Email'],
                                      detailVisitor['Phone']
                                          .toString()
                                          .substring(1, 3),
                                      detailVisitor['Phone']
                                          .toString()
                                          .substring(3),
                                      "origin",
                                      detailVisitor['EmployeeName'],
                                      detailVisitor['VisitReason'],
                                      detailVisitor['VisitorPhoto'],
                                      element.completed!)
                                  .then((value) {
                                Navigator.pushNamed(context, '/visitorInfo')
                                    .then((value) {
                                  setState(() {});
                                });
                              });
                              // }
                            });
                            // saveVisitorData(
                            //     element.firstName.toString(),
                            //     element.lastName.toString(),
                            //     element.gender.toString(),
                            //     element.email.toString(),
                            //     element.phoneCode.toString(),
                            //     element.phoneNumber.toString(),
                            //     element.origin.toString(),
                            //     element.employee.toString(),
                            //     element.reason.toString(),
                            //     element.completed!);

                          } else {
                            // getVisitorDetail();
                            saveVisitorData(
                                element.firstName.toString(),
                                element.lastName.toString(),
                                element.gender.toString(),
                                element.email.toString(),
                                element.phoneCode.toString(),
                                element.phoneNumber.toString(),
                                element.origin.toString(),
                                element.employee.toString(),
                                element.reason.toString(),
                                "",
                                element.completed!);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => NewGuestPage(
                            //       isEdit: true,
                            //     ),
                            //   ),
                            // );
                          }
                        });
                        print(selectedVisitor.toList());
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
