import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/regular_button.dart';

class VisitorInfoPage extends StatefulWidget {
  const VisitorInfoPage({Key? key}) : super(key: key);

  @override
  State<VisitorInfoPage> createState() => _VisitorInfoPageState();
}

class _VisitorInfoPageState extends State<VisitorInfoPage> {
  // var box;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? origin;
  String? phoneCode;
  String? phoneNumber;
  String? employee;
  String? reason;
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
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataVisitor();
  }

  @override
  Widget build(BuildContext context) {
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
                    children: [
                      Container(
                        width: 200,
                        child: Image.asset('assets/avatars/avatar_male.png'),
                        // child: SvgPicture.asset(
                        //   'assets/avatars/male_avatar.svg',
                        //   // fit: BoxFit.cover,
                        // ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Container(
                            child: Column(
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
                                    gender == '1' ? 'Male' : 'Female',
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
                                    '+$phoneCode $phoneNumber',
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
                  detailInfo: '$origin',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 30),
                child: DetailInfoText(
                  label: 'Visit Reason',
                  detailInfo: '$reason',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 30),
                child: DetailInfoText(
                  label: 'Meeting With',
                  detailInfo: '$employee',
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
                      Navigator.pushNamed(context, '/welcome');
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
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
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
