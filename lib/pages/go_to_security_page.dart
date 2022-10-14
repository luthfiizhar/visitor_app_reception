import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/nip_dialog.dart';
import 'package:visitor_app/components/notif_dialog.dart';
import 'package:visitor_app/components/override_login_dialog.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/functions/hive_functions.dart';
import 'package:visitor_app/functions/request_api.dart';
import 'package:visitor_app/main_model.dart';
import 'package:visitor_app/responsive.dart';

class GoToSecurityPage extends StatelessWidget {
  const GoToSecurityPage({Key? key}) : super(key: key);

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
                padding:
                    EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Container(
                        // color: Colors.black,
                        height: 380,
                        width: 480,
                        // child: FittedBox(
                        //   child: Image.asset('assets/welcome_image.png'),
                        //   fit: BoxFit.cover,
                        // ),
                        child: SvgPicture.asset('assets/cek_security.svg',
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
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
                                    text: 'Uh Oh!',
                                    style: TextStyle(
                                        color: eerieBlack,
                                        fontSize:
                                            Responsive.isSmallTablet(context)
                                                ? 44
                                                : 48,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text:
                                            'Please check your invitation code on Security Guard!',
                                        style: TextStyle(
                                            color: onyxBlack,
                                            fontSize: Responsive.isSmallTablet(
                                                    context)
                                                ? 28
                                                : 32,
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
                      padding: EdgeInsets.only(top: 170),
                      child: SizedBox(
                          width: 300,
                          height: 80,
                          child: RegularButton(
                            title: 'OK',
                            onTap: () {
                              Navigator.of(context).pop();
                              // model.resetAll();
                              // Navigator.of(context).pushNamedAndRemoveUntil(
                              //     '/home', (Route<dynamic> route) => false);
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
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return NipDialog();
                          },
                        );
                      },
                      child: const Text(
                        'Override',
                        style: TextStyle(
                          fontSize: 36,
                          color: eerieBlack,
                        ),
                      ),
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
