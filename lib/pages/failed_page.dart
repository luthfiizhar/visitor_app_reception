import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/notif_dialog.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/functions/hive_functions.dart';
import 'package:visitor_app/functions/request_api.dart';
import 'package:visitor_app/main_model.dart';

class FailedPage extends StatelessWidget {
  const FailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
          // appBar: PreferredSize(
          //     preferredSize: Size.fromHeight(75), child: CustAppBar()),
          body: Center(
            child: Container(
                height: MediaQuery.of(context).size.height,
                // color: redBright,
                padding: EdgeInsets.only(
                    top: 120, left: 100, right: 100, bottom: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Container(
                        // color: Colors.black,
                        // height: 400,
                        // width: 520,
                        // child: FittedBox(
                        //   child: Image.asset('assets/welcome_image.png'),
                        //   fit: BoxFit.cover,
                        // ),
                        child: SvgPicture.asset('assets/email failed.svg',
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        // padding: EdgeInsets.only(top: 100),
                        height: 110,
                        width: 600,
                        child: Center(
                          child: Wrap(children: [
                            Column(
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Registration Failed!',
                                    style: TextStyle(
                                        color: eerieBlack,
                                        fontSize: 48,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: 'Please try again',
                                        style: TextStyle(
                                            color: iconBlack,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: SizedBox(
                          width: 300,
                          height: 80,
                          child: RegularButton(
                            title: 'OK',
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home', (Route<dynamic> route) => false);
                              // print(model.listSelectedVisitor);
                              // if (model.isEdit) {
                              //   confirmAttendants(model.listSelectedVisitor)
                              //       .then((value) {
                              //     if (value['Status'] == '200') {
                              //       clearVisitorData();
                              //       model.resetAll();
                              //       notifDialog(context, true).then((value) {
                              //         Navigator.of(context)
                              //             .pushNamedAndRemoveUntil('/home',
                              //                 (Route<dynamic> route) => false);
                              //       });
                              //     }
                              //     if (value['Status'] == '400') {
                              //       clearVisitorData();
                              //       model.resetAll();
                              //       notifDialog(context, false).then((value) {
                              //         Navigator.of(context)
                              //             .pushNamedAndRemoveUntil('/home',
                              //                 (Route<dynamic> route) => false);
                              //       });
                              //     }
                              //   });
                              // } else {
                              //   onSiteCheckin(
                              //           model.firstName,
                              //           model.lastName,
                              //           model.email,
                              //           model.reason,
                              //           model.gender,
                              //           model.origin,
                              //           model.phoneCode,
                              //           model.phoneNumber,
                              //           model.photo)
                              //       .then((value) {
                              //     if (value['Status'] == '200') {
                              //       notifDialog(context, true).then((value) {
                              //         Navigator.of(context)
                              //             .pushNamedAndRemoveUntil('/home',
                              //                 (Route<dynamic> route) => false);
                              //       });
                              //     } else {
                              //       notifDialog(context, true).then((value) {
                              //         Navigator.of(context)
                              //             .pushNamedAndRemoveUntil('/home',
                              //                 (Route<dynamic> route) => false);
                              //       });
                              //     }
                              //   });
                              // }
                            },
                          )),
                    )
                  ],
                )
                // Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [Text('Welcome!'), Text('Jacques Sierra')])),
                ),
          ),
        ),
      );
    });
  }
}
