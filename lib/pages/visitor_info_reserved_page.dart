import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/functions/request_api.dart';
import 'package:visitor_app/main_model.dart';
import 'package:visitor_app/pages/new_guest_page.dart';
import 'package:visitor_app/pages/visitor_info_page.dart';

class VisitorReservedPage extends StatefulWidget {
  VisitorReservedPage({
    this.visitorId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.employee,
    this.gender,
    this.origin,
    this.photo,
    this.visitReason,
    this.visitDate,
    this.genderString,
    this.reasonString,
  });

  String? visitorId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneCode;
  String? phoneNumber;
  int? gender;
  String? origin;
  int? visitReason;
  String? photo;
  String? employee;
  String? visitDate;
  String? genderString;
  String? reasonString;

  @override
  State<VisitorReservedPage> createState() => _VisitorReservedPageState();
}

class _VisitorReservedPageState extends State<VisitorReservedPage> {
  String? visitorId;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? origin;
  String? phoneCode;
  String? phoneNumber;
  String? employee;
  String? reason;
  String? visitDate;
  String? photo;

  Uint8List convertBase64Image(String base64String) {
    return Base64Decoder().convert(base64String.split(',').last);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDataVisitor().then((value) {
    //   print(photo);
    //   photoBase64 = Base64Decoder().convert(
    //       Provider.of<MainModel>(context, listen: false).photo.split(',').last);
    // });
    visitorId = widget.visitorId;
    firstName = widget.firstName;
    lastName = widget.lastName;
    phoneCode = widget.phoneCode;
    phoneNumber = widget.phoneNumber;
    reason = widget.reasonString;
    gender = widget.genderString;
    email = widget.email;
    employee = widget.employee;
    visitDate = widget.visitDate;
    photo = widget.photo;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(75), child: CustAppBar()),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 100, right: 100),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Visitor Info',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                          color: eerieBlack),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    // padding: EdgeInsets.only(top: 50),
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: MemoryImage(
                            Base64Decoder().convert(photo!.split(',').last),
                          ),
                        ),
                        // Container(
                        //   width: 200,
                        //   // child: Image.asset('assets/avatars/avatar_male.png'),
                        //   child: Image.memory(
                        //     convertBase64Image(photo!),
                        //     gaplessPlayback: true,
                        //   ),
                        //   // child: SvgPicture.asset(
                        //   //   'assets/avatars/male_avatar.svg',
                        //   //   // fit: BoxFit.cover,
                        //   // ),
                        // ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${firstName} ${lastName}',
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '${gender}',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '$email',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '${model.phoneNumber}',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 30),
                  child: DetailInfoText(
                    label: 'Origin Company',
                    detailInfo: '${origin}',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40, left: 30),
                  child: DetailInfoText(
                    label: 'Visit Reason',
                    detailInfo: '${reason}',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40, left: 30),
                  child: DetailInfoText(
                    label: 'Meeting With',
                    detailInfo: '${employee}',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40, left: 30),
                  child: DetailInfoText(
                    label: 'Visit Date',
                    detailInfo: '4th July 2022',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 180),
                  child: SizedBox(
                    height: 80,
                    width: 600,
                    child: RegularButton(
                      title: 'Confirm',
                      onTap: () {
                        // print(model.isLastVisitor);
                        if (model.isLastVisitor) {
                          saveVisitorForm(
                                  widget.visitorId!,
                                  widget.firstName!,
                                  widget.lastName!,
                                  widget.email!,
                                  widget.visitReason!,
                                  widget.gender!,
                                  widget.origin!,
                                  widget.phoneCode!,
                                  widget.phoneNumber!,
                                  widget.photo!,
                                  model)
                              .then((value) {
                            if (value['Status'] == "200") {
                              Navigator.pushNamed(context, '/declaration');
                            } else {}
                          });
                        } else {
                          saveVisitorForm(
                                  model.visitorId,
                                  widget.firstName!,
                                  widget.lastName!,
                                  widget.email!,
                                  widget.visitReason!,
                                  widget.gender!,
                                  widget.origin!,
                                  widget.phoneCode!,
                                  widget.phoneNumber!,
                                  widget.photo!,
                                  model)
                              .then((value) {
                            if (value['Status'] == "200") {
                              var list = json.decode(model.listSelectedVisitor);
                              getVisitorState(
                                      model.listSelectedVisitor, 2, model)
                                  .then((value) {
                                print(value);
                                if (value['Data']['VisitorStatus'] ==
                                    "INVITED") {
                                  model.setIsLastVisitor(
                                      value['Data']['LastVisitor']);
                                  model.setVisitorId(value['Data']
                                      ['VisitorData']['VisitorID']);
                                  model.setFirstName(value['Data']
                                      ['VisitorData']['FirstName']);
                                  model.setLastName(value['Data']['VisitorData']
                                              ['LastName'] !=
                                          null
                                      ? value['Data']['VisitorData']['LastName']
                                      : "");
                                  model.setEmail(
                                      value['Data']['VisitorData']['Email']);
                                  model.setGender(1);
                                  model.setReason(0);
                                  model.setOrigin("");
                                  model.setPhoto("");
                                  model.setPhoneCode("");
                                  model.setPhoneNumber("");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          NewGuestPage(
                                        isEdit: true,
                                      ),
                                    ),
                                  );
                                }
                                if (value['Data']['VisitorStatus'] ==
                                    "RESERVED") {}
                              });
                            }
                          });

                          // Navigator.pushNamed(context, '/welcome');
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
    });
  }
}
