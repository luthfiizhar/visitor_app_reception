import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/notif_dialog.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:http/http.dart' as http;
import 'package:visitor_app/constant.dart';
import 'package:visitor_app/main_model.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({Key? key}) : super(key: key);

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  TextEditingController textEditingController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  // StreamController<ErrorAnimationType>? errorController;

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
    var response = await http.post(url, headers: requestHeader, body: bodySend);
    var data = json.decode(response.body);
    debugPrint(data.toString());
    if (data != null) {
      setState(() {});
      model.setButtonLoading(false);
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
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 80,
      height: 100,
      // padding: EdgeInsets.only(right: 20),
      textStyle: TextStyle(
          fontSize: 56, color: eerieBlack, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: graySand,
        border: Border.all(color: grayStone, width: 2.5),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      boxShadow: [
        BoxShadow(
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
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 400, left: 127, right: 127),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text('Please input your invitation code',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    color: onyxBlack)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: focusedPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  errorTextStyle:
                                      TextStyle(color: silver, fontSize: 18),
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
                                      debugPrint(value['Data'].toString());
                                      model.setInviteCode(
                                          inviteCode!.toUpperCase());
                                      model.setEmployee(
                                          value['Data']['Employee']);
                                      model.setVisitDate(value['Data']['Date']);
                                      Navigator.pushNamed(
                                          context, '/guestList');
                                    }).onError((error, stackTrace) {
                                      notifDialog(context, false,
                                          'Invite code not correct!');
                                    });
                                  }
                                },
                              ),
                      )
                    ],
                  ),
                ),
                // child: Form(
                //   // key: formKey,
                //   child: Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                //       child: PinCodeTextField(
                //         appContext: context,
                //         length: 6,
                //         obscureText: false,
                //         animationType: AnimationType.fade,
                //         validator: (v) {
                //           if (v!.length < 3) {
                //             return "I'm from validator";
                //           } else {
                //             return null;
                //           }
                //         },
                //         pinTheme: PinTheme(
                //             shape: PinCodeFieldShape.box,
                //             borderRadius: BorderRadius.circular(5),
                //             fieldHeight: 100,
                //             fieldWidth: 80,
                //             borderWidth: 2.5,
                //             selectedFillColor: Color(0xFFEEEEEE),
                //             activeColor: Color.fromARGB(255, 182, 68, 68),
                //             disabledColor: Color(0xFFEEEEEE),
                //             inactiveColor: Color(0xFFEEEEEE),
                //             selectedColor: Color(0xFFEEEEEE),
                //             activeFillColor: Color(0xFFEEEEEE),
                //             errorBorderColor: Color(0xFFEEEEEE),
                //             inactiveFillColor: Color(0xFFEEEEEE)),
                //         // backgroundColor: Color(0xFFEEEEEE),
                //         cursorColor: Colors.black,
                //         animationDuration: const Duration(milliseconds: 300),
                //         enableActiveFill: true,
                //         errorAnimationController: errorController,
                //         controller: textEditingController,
                //         keyboardType: TextInputType.text,
                //         // boxShadows: const <BoxShadow>[
                //         //   BoxShadow(
                //         //     // offset: Offset(0.1, 0.75),
                //         //     color: Color(0xFFA80038),
                //         //     blurRadius: 20,
                //         //   )
                //         // ],
                //         onCompleted: (v) {
                //           debugPrint("Completed");
                //         },
                //         // onTap: () {
                //         //   print("Pressed");
                //         // },
                //         onChanged: (value) {
                //           debugPrint(value);
                //           setState(() {
                //             currentText = value;
                //           });
                //         },
                //         beforeTextPaste: (text) {
                //           debugPrint("Allowing to paste $text");
                //           //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //           //but you can show anything you want here, like your pop up saying wrong paste format or etc
                //           return true;
                //         },
                //       )),
                // ),
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
