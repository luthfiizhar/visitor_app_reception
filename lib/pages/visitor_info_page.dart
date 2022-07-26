import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/constant.dart';
import 'package:visitor_app/functions/hive_functions.dart';
import 'package:visitor_app/functions/request_api.dart';
import 'package:visitor_app/main_model.dart';
import 'package:visitor_app/pages/new_guest_page.dart';

class VisitorInfoPage extends StatefulWidget {
  VisitorInfoPage({
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

  @override
  State<VisitorInfoPage> createState() => _VisitorInfoPageState();
}

class _VisitorInfoPageState extends State<VisitorInfoPage> {
  // var box;
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
  //     Provider.of<MainModel>(navKey.currentState!.context, listen: false).photo;
  // Uint8List? photoBase64;

  Uint8List convertBase64Image(String base64String) {
    return Base64Decoder().convert(base64String.split(',').last);
  }

  Future getDataVisitor() async {
    var box = await Hive.openBox('visitorBox');
    setState(() {
      firstName = box.get('firstName');
      lastName = box.get('lastName');
      gender = box.get('gender');
      email = box.get('email');
      origin = box.get('origin');
      phoneCode = box.get('phoneCode');
      phoneNumber = box.get('phoneNumber');
      employee = box.get('employee');
      reason = box.get('reason');
      photo = box.get('photo');
    });
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
    origin = widget.origin;
    switch (widget.visitReason) {
      case 0:
        reason = "Business";
        break;
      case 1:
        reason = "Training";
        break;
      case 2:
        reason = "Visit";
        break;
      case 3:
        reason = "Meeting";
        break;
      case 4:
        reason = "Others";
        break;
      default:
        reason = "";
    }
    gender = widget.gender.toString();
    email = widget.email;
    employee = widget.employee;
    visitDate = widget.visitDate;
    photo = widget.photo;
    // if (widget.gender == null) {
    //   gender = widget.genderString;
    // }
    // if (widget.visitReason == null) {
    //   reason = widget.reasonString;
    // }
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
                            Base64Decoder().convert(photo!),
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
                                      model.gender == 1 ? 'Male' : 'Female',
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
                                      '+${model.phoneCode} ${model.phoneNumber}',
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
                    detailInfo: '${visitDate}',
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
                        if (model.isEdit == true) {
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
                                    widget.photo!)
                                .then((value) {
                              if (value['Status'] == "200") {
                                Navigator.pushNamed(context, '/declaration');
                              }
                              if (value['Status'] == '400') {
                                Navigator.pushNamed(context, '/declaration');
                              } else {
                                Navigator.pushNamed(context, '/declaration');
                              }
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
                                    widget.photo!)
                                .then((value) {
                              if (value['Status'] == "200") {
                                getNextVisitorList(model);
                              }
                              if (value['Status'] == '400') {
                                getNextVisitorList(model);
                              }
                            });

                            // Navigator.pushNamed(context, '/welcome');
                          }
                        } else {
                          onSiteCheckin(
                                  widget.firstName!,
                                  widget.lastName!,
                                  widget.email!,
                                  widget.visitReason!,
                                  widget.gender!,
                                  widget.origin!,
                                  widget.phoneCode!,
                                  widget.phoneNumber!,
                                  widget.photo!)
                              .then((value) {
                            if (value['Success'] == '200') {
                              Navigator.of(context).pushNamed('/declaration');
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
      ));
    });
  }

  getNextVisitorList(
    MainModel model,
  ) {
    var list = json.decode(model.listSelectedVisitor);
    model.updateIndex(model.indexPage + 1);
    getVisitorState(model.listSelectedVisitor, model.indexPage, model)
        .then((value) {
      print(value);
      if (value['Data']['VisitorStatus'] == "INVITED") {
        model.setIsLastVisitor(value['Data']['LastVisitor']);
        model.setVisitorId(value['Data']['VisitorData']['VisitorID']);
        model.setFirstName(value['Data']['VisitorData']['FirstName']);
        model.setLastName(value['Data']['VisitorData']['LastName']);
        model.setEmail(value['Data']['VisitorData']['Email']);
        model.setGender(1);
        model.setReason(0);
        model.setOrigin("");
        model.setPhoto("");
        model.setPhoneCode("");
        model.setPhoneNumber("");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => NewGuestPage(
              isEdit: true,
            ),
          ),
        );
      }
      if (value['Data']['VisitorStatus'] == "RESERVED") {
        model.setFirstName(value['Data']['VisitorData']['FirstName']);
        model.setLastName(value['Data']['VisitorData']['LastName']);
        model.setEmail(value['Data']['VisitorData']['Email']);
        model.setVisitorId(value['Data']['VisitorData']['VisitorID']);
        model.setPhoneCode(value['Data']['VisitorData']['CountryCode']);
        model.setPhoneNumber(value['Data']['VisitorData']['PhoneNumber']);
        model.setOrigin(value['Data']['VisitorData']['CompanyName']);
        model.setPhoto(value['Data']['VisitorData']['VisitorPhoto']
            .toString()
            .split(',')
            .last);
        // model.setVisitDate(
        //     value['Data']['VisitorData']['VisitTime']);
        model.setGender(value['Data']['VisitorData']['Gender']);
        model.setReason(value['Data']['VisitorData']['VisitReason']);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VisitorInfoPage(
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
              // photo: model.photo,
              phoneCode: model.phoneCode,
              phoneNumber: model.phoneNumber,
              // genderString: value['Data']['VisitorData']
              //     ['Gender'],
              // reasonString: value['Data']['VisitorData']
              //     ['VisitReason'],
            ),
          ),
        );
      }
      if (value['Data']['VisitorStatus'] == "APPROVED") {
        model.setFirstName(value['Data']['VisitorData']['FirstName']);
        model.setLastName(value['Data']['VisitorData']['LastName']);
        model.setEmail(value['Data']['VisitorData']['Email']);
        model.setVisitorId(value['Data']['VisitorData']['VisitorID']);
        model.setPhoneCode(value['Data']['VisitorData']['CountryCode']);
        model.setPhoneNumber(value['Data']['VisitorData']['PhoneNumber']);
        model.setOrigin(value['Data']['VisitorData']['CompanyName']);
        model.setPhoto(value['Data']['VisitorData']['VisitorPhoto']
            .toString()
            .split(',')
            .last);
        // model.setVisitDate(
        //     value['Data']['VisitorData']['VisitTime']);
        model.setGender(value['Data']['VisitorData']['Gender']);
        model.setReason(value['Data']['VisitorData']['VisitReason']);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VisitorInfoPage(
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
              // photo: model.photo,
              phoneCode: model.phoneCode,
              phoneNumber: model.phoneNumber,
              // genderString: value['Data']['VisitorData']
              //     ['Gender'],
              // reasonString: value['Data']['VisitorData']
              //     ['VisitReason'],
            ),
          ),
        );
      }
      if (value['Status'] == '400') {}
    });
  }
}

class DetailInfoText extends StatelessWidget {
  const DetailInfoText({Key? key, this.label, this.detailInfo})
      : super(key: key);

  final String? label;
  final String? detailInfo;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$label',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w400, color: eerieBlack),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            '$detailInfo',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }
}
