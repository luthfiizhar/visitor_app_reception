import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/class/visitor.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/nip_dialog.dart';
import 'package:visitor_app/components/notif_dialog.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:http/http.dart' as http;
import 'package:visitor_app/constant.dart';
import 'package:visitor_app/functions/request_api.dart';
import 'package:visitor_app/main_model.dart';
import 'package:visitor_app/pages/go_to_security_page.dart';
import 'package:visitor_app/pages/new_guest_page.dart';
import 'package:visitor_app/pages/visitor_info_page.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({Key? key}) : super(key: key);

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  TextEditingController textEditingController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  // StreamController<ErrorAnimationType>? errorController;

  final List<Visitor> selectedVisitor = [];
  var listSelected;

  @override
  void initState() {
    // TODO: implement initState
    // errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  bool hasError = false;
  String currentText = "";
  String? inviteCode;

  String? pinCode;
  TextEditingController _pinCode = TextEditingController();

  Future getVisitorListByInviteCode(MainModel model) async {
    var url = Uri.https(apiUrl,
        '/VisitorManagementBackend/public/api/visitor/get-visitor-invitation');
    Map<String, String> requestHeader = {
      'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
      'Content-Type': 'application/json',
    };
    var bodySend = """ 
      {
          "Code" : "$inviteCode"
      }
    """;
    try {
      var response =
          await http.post(url, headers: requestHeader, body: bodySend);
      var data = json.decode(response.body);
      debugPrint(data.toString());
      if (data != null) {
        // setState(() {});
        // model.setButtonLoading(false);
      }
      if (data['Status'] == "200") {
        var listBox = await Hive.openBox('listBox');
        listBox.put(
            'attendants',
            data['Data']['Attendants'] != null
                ? data['Data']['Attendants']
                : null);
      }
      return data;
      // } on SocketException catch (e) {
      //   return e;
    } on Error catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      // padding: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.only(top: 10),
      width: 80,
      height: 100,
      // padding: EdgeInsets.only(right: 20),
      textStyle: const TextStyle(
          fontSize: 56, color: eerieBlack, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: graySand,
        border: Border.all(color: grayStone, width: 2.5),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      boxShadow: [
        const BoxShadow(
          color: eerieBlack,
          offset: Offset(0.0, 5.0), //(x,y)
          blurRadius: 0,
        )
      ],
      border: Border.all(color: grayStone, width: 2.5),
      borderRadius: BorderRadius.circular(15),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color(0xFFEEEEEE),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0xFFA80038),
        //     offset: Offset(0.0, 5.0), //(x,y)
        //     blurRadius: 0,
        //   )
        // ],
        // border: Border(
        //     bottom: BorderSide(width: 5, color: Color(0xFFA80038)),
        //     top: BorderSide(width: 5, color: Color(0xFF929AAB)),
        //     left: BorderSide(width: 5, color: Color(0xFF929AAB)),
        //     right: BorderSide(width: 5, color: Color(0xFF929AAB)))
      ),
    );
    return Consumer<MainModel>(builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            body: Stack(children: [
              Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 42,
                      color: eerieBlack,
                    )),
              ),
              Align(
                alignment: Alignment.center,
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Please input your invitation code',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w300,
                                  color: onyxBlack)),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Form(
                              key: _formKey,
                              child: Pinput(
                                  controller: _pinCode,
                                  keyboardType: TextInputType.text,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  onCompleted: (pin) {
                                    setState(() {
                                      inviteCode = pin;
                                    });
                                  },
                                  length: 6,
                                  separator: SizedBox(
                                    width: 19,
                                  ),
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: focusedPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  errorTextStyle: const TextStyle(
                                      color: silver, fontSize: 18),
                                  validator: (value) {
                                    // value!.isEmpty || value.length < 6
                                    //     ? 'This field is required'
                                    //     : null;
                                    if (value!.isEmpty) {
                                      return 'This field is required';
                                    } else {
                                      if (value.length < 6) {
                                        return 'This field must be 6 characters';
                                      } else {
                                        return null;
                                      }
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 250),
                      child: model.buttonLoading
                          ? CircularProgressIndicator(
                              color: eerieBlack,
                            )
                          : RegularButton(
                              width: 300,
                              height: 80,
                              title: 'Next',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  setState(() {});
                                  model.setButtonLoading(true);
                                  print(inviteCode);
                                  getVisitorListByInviteCode(model)
                                      .then((value) {
                                    print(value);
                                    if (value['Status'] == "200") {
                                      debugPrint(value['Data'].toString());
                                      model.setInviteCode(
                                          inviteCode!.toUpperCase());
                                      model.setEmployee(
                                          value['Data']['Employee']);
                                      model.setVisitDate(value['Data']['Date']);
                                      model.setVisitorId(value['Data']
                                          ['Attendants'][0]['VisitorID']);
                                      List attendants =
                                          value['Data']['Attendants'];
                                      // attendants = json.encode(attendants);
                                      debugPrint(attendants.length.toString());
                                      print(model.visitorId);
                                      if (attendants.length == 1) {
                                        model.setIsLastVisitor(true);
                                        if (value['Data']['Attendants'][0]
                                                ['Status'] ==
                                            "INVITED") {
                                          model.setStatusVisitor(value['Data']
                                              ['Attendants'][0]['Status']);
                                          selectedVisitor.add(Visitor(
                                            visitorId: model.visitorId,
                                          ));
                                          listSelected =
                                              json.encode(selectedVisitor);
                                          model.setListSelectedVisitor(
                                              listSelected);
                                          print('invited');
                                          getVisitorDetail(model.visitorId)
                                              .then((value) {
                                            print(value['Data'][0]);
                                            model.setFirstName(
                                                value['Data'][0]['FirstName']);
                                            model.setLastName(value['Data'][0]
                                                            ['LastName'] ==
                                                        null ||
                                                    value['Data'][0]
                                                            ['LastName'] ==
                                                        "-"
                                                ? ""
                                                : value['Data'][0]['LastName']);
                                            model.setEmail(value['Data'][0]
                                                            ['Email'] ==
                                                        null ||
                                                    value['Data'][0]['Email'] ==
                                                        "-"
                                                ? ""
                                                : value['Data'][0]['Email']);
                                            model.setButtonLoading(false);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        NewGuestPage(
                                                  isEdit: true,
                                                ),
                                              ),
                                            );
                                          });
                                          // model.setFirstName(value['Data']
                                          //     ['Attendants'][0]['FirstName']);
                                          // model.setLastName(value['Data']
                                          //                 ['Attendants']
                                          //             ['LastName'] !=
                                          //         null
                                          //     ? value['Data']['Attendants'][0]
                                          //         ['LastName']
                                          //     : "");
                                          // model.setEmail(value['Data']
                                          //                 ['Attendants'][0]
                                          //             ['Email'] !=
                                          //         null
                                          //     ? value['Data']['Attendants'][0]
                                          //         ['Email']
                                          //     : "");

                                        }
                                        if (value['Data']['Attendants'][0]
                                                ['Status'] ==
                                            "RESERVED") {
                                          model.setStatusVisitor(value['Data']
                                              ['Attendants'][0]['Status']);
                                          selectedVisitor.add(Visitor(
                                            visitorId: model.visitorId,
                                          ));
                                          listSelected =
                                              json.encode(selectedVisitor);
                                          model.setListSelectedVisitor(
                                              listSelected);
                                          getVisitorDetail(model.visitorId)
                                              .then((value) {
                                            print(value['Data'][0]);
                                            model.setFirstName(
                                                value['Data'][0]['FirstName']);
                                            model.setLastName(value['Data'][0]
                                                            ['LastName'] ==
                                                        "-" ||
                                                    value['Data'][0]
                                                            ['LastName'] ==
                                                        null
                                                ? ""
                                                : value['Data'][0]['LastName']);
                                            model.setEmail(value['Data'][0]
                                                            ['Email'] ==
                                                        "-" ||
                                                    value['Data'][0]['Email'] ==
                                                        null
                                                ? ""
                                                : value['Data'][0]['Email']);
                                            model.setReason(value['Data'][0]
                                                ['VisitReasonID']);
                                            model.setGender(
                                                value['Data'][0]['GenderID']);
                                            model.setOrigin(value['Data'][0]
                                                ['CompanyName']);
                                            model.setPhoto(value['Data'][0]
                                                ['VisitorPhoto']);
                                          });
                                          model.setButtonLoading(false);
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return NipDialog();
                                            },
                                          ).then(
                                            (value) {
                                              if (value) {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        VisitorInfoPage(
                                                      visitorId:
                                                          model.visitorId,
                                                      firstName:
                                                          model.firstName,
                                                      lastName: model.lastName,
                                                      email: model.email,
                                                      gender: model.gender,
                                                      visitReason: model.reason,
                                                      employee: model.employee,
                                                      visitDate:
                                                          model.visitDate,
                                                      origin: model.origin,
                                                      photo: model.photo,
                                                      phoneCode:
                                                          model.phoneCode,
                                                      phoneNumber:
                                                          model.phoneNumber,
                                                      completePhoneNumber: model
                                                          .completePhoneNumber,
                                                      statusVisitor:
                                                          model.statusVisitor,
                                                      isLastVisitor:
                                                          model.isLastVisitor,
                                                      isEdit: model.isEdit,
                                                      index: model.indexPage,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                          // Navigator.of(context)
                                          //     .push(MaterialPageRoute(
                                          //   builder: (context) =>
                                          //       GoToSecurityPage(),
                                          // ));
                                        }
                                        if (value['Data']['Attendants'][0]
                                                ['Status'] ==
                                            "APPROVED") {
                                          model.setStatusVisitor(value['Data']
                                              ['Attendants'][0]['Status']);
                                          selectedVisitor.add(Visitor(
                                            visitorId: model.visitorId,
                                          ));
                                          listSelected =
                                              json.encode(selectedVisitor);
                                          model.setListSelectedVisitor(
                                              listSelected);
                                          getVisitorDetail(model.visitorId)
                                              .then((value) {
                                            print("approved");
                                            print(value['Data'][0]);
                                            model.setFirstName(
                                                value['Data'][0]['FirstName']);
                                            model.setLastName(value['Data'][0]
                                                        ['LastName'] ==
                                                    null
                                                ? ""
                                                : value['Data'][0]['LastName']);
                                            model.setEmail(value['Data'][0]
                                                        ['Email'] ==
                                                    null
                                                ? ""
                                                : value['Data'][0]['Email']);
                                            model.setReason(value['Data'][0]
                                                ['VisitReasonID']);
                                            model.setGender(
                                                value['Data'][0]['GenderID']);
                                            model.setOrigin(value['Data'][0]
                                                ['CompanyName']);
                                            model.setPhoto(value['Data'][0]
                                                ['VisitorPhoto']);
                                            model.setPhoneCode(value['Data'][0]
                                                ['CountryCode']);
                                            model.setPhoneNumber(value['Data']
                                                [0]['PhoneNumberRaw']);
                                            model.setCompletePhoneNumber(
                                                value['Data'][0]['Phone']);
                                            setState(() {});
                                            model.setButtonLoading(false);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
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
                                                  phoneNumber:
                                                      model.phoneNumber,
                                                  completePhoneNumber:
                                                      model.completePhoneNumber,
                                                  statusVisitor:
                                                      model.statusVisitor,
                                                  isLastVisitor:
                                                      model.isLastVisitor,
                                                  isEdit: model.isEdit,
                                                  index: model.indexPage,
                                                ),
                                              ),
                                            ).then((value) {
                                              setState(() {
                                                model.setButtonLoading(false);
                                              });

                                              selectedVisitor.clear();
                                            });
                                            ;
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          model.setButtonLoading(false);
                                        });

                                        Navigator.of(context)
                                            .pushNamed('/guestList');
                                      }
                                    } else {
                                      setState(() {});
                                      model.setButtonLoading(false);
                                      // print(error);
                                      notifDialog(
                                          context, false, value['Message']);
                                    }
                                  }).onError((error, stackTrace) {
                                    setState(() {});
                                    model.setButtonLoading(false);
                                    print(error);
                                    print(stackTrace);
                                    notifDialog(context, false,
                                        'No internet connection.');
                                  });
                                }
                              },
                            ),
                    )
                  ],
                ),
              ),
            ])),
      );
    });
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
