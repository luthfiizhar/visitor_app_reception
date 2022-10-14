import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/notif_dialog.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/functions/hive_functions.dart';
import 'package:visitor_app/functions/request_api.dart';
import 'package:visitor_app/main_model.dart';
import 'package:visitor_app/responsive.dart';

class WelcomeGuestPage extends StatelessWidget {
  const WelcomeGuestPage({Key? key}) : super(key: key);

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
                    top: 0,
                    left: Responsive.isSmallTablet(context) ? 70 : 100,
                    right: Responsive.isSmallTablet(context) ? 70 : 100,
                    bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Container(
                        // color: Colors.black,
                        height: 400,
                        width: 520,
                        // child: FittedBox(
                        //   child: Image.asset('assets/welcome_image.png'),
                        //   fit: BoxFit.cover,
                        // ),
                        child: SvgPicture.asset('assets/welcome_image_new.svg',
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Responsive.isSmallTablet(context) ? 30 : 50),
                      child: Container(
                        // padding: EdgeInsets.only(top: 100),
                        // height: 110,
                        // width: 600,
                        child: Center(
                          child: Wrap(children: [
                            Column(
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Welcome!',
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
                                        text:
                                            'We\'ll inform the host that you\'re here',
                                        style: TextStyle(
                                            color: onyxBlack,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Responsive.isSmallTablet(context) ? 100 : 140),
                      child: SizedBox(
                          width: 300,
                          height: 80,
                          child: RegularButton(
                            title: 'OK',
                            onTap: () {
                              model.resetAll();
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
