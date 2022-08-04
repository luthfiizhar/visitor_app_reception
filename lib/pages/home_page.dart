import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/home_button.dart';
import 'package:visitor_app/components/notif_dialog.dart';
import 'package:visitor_app/main_model.dart';
import 'package:visitor_app/pages/new_guest_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({Key? key}) : super(key: key);
  // HomeButton qrCodeButton = HomeButton(
  //     file: 'assets/icons/qr_code.png',
  //     title: 'QR Code',
  //     title2: '',
  //     routeName: 'qr');

  // HomeButton invitationButton = HomeButton(
  //   file: 'assets/icons/mail.png',
  //   title: 'Invitation',
  //   title2: 'Code',
  //   routeName: 'invite',
  // );

  // HomeButton newGuestButton = HomeButton(
  //   file: 'assets/icons/person_add.png',
  //   title: 'New',
  //   title2: 'Guest',
  //   routeName: 'new',
  // );

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            Positioned(
                top: 0,
                right: -20,
                // left: ,
                child: Container(
                  padding: EdgeInsets.zero,
                  width: 300,
                  height: 100,
                  // color: Colors.blue,
                  child: SvgPicture.asset(
                    'assets/klg_main_logo_old.svg',
                    color: eerieBlack,
                    fit: BoxFit.cover,
                    // height: 100,
                    // width: 300,
                  ),
                )
                // Container(
                //   height: 75,
                //   width: 232,
                //   // color: Colors.black,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           fit: BoxFit.fitHeight,
                //           image: AssetImage('assets/KLG_Main_logo_tagline.png'))),
                // ),
                ),
            // Positioned(
            //     bottom: -120,
            //     left: 0,
            //     // left: ,
            //     child: Container(
            //       height: 500,
            //       width: 500,
            //       // color: Colors.black,
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //               fit: BoxFit.fitWidth,
            //               image: AssetImage('assets/decor_black_2.png'))),
            //     )),
            Positioned(
                right: 60,
                bottom: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Facility Management',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: silver),
                    ),
                    Text(
                      '2022',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: silver),
                    ),
                  ],
                )),
            Center(
              child: Container(
                padding: EdgeInsets.only(left: 100, right: 100),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: SizedBox(
                          width: 615,
                          height: 300,
                          child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 600,
                                      height: 210,
                                      child: Wrap(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Welcome to ',
                                              style: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 64,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Helvetica',
                                                  color: onyxBlack),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Kawan Lama Head Office',
                                                  style: TextStyle(
                                                    letterSpacing: 1,
                                                    fontSize: 96,
                                                    fontWeight: FontWeight.w700,
                                                    color: eerieBlack,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                                // Row(
                                //   children: [
                                //     Text(
                                //       'Welcome to',
                                // style: TextStyle(
                                //     fontSize: 48,
                                //     fontWeight: FontWeight.w400,
                                //     color: Color(0xFFA80038)),
                                //       textAlign: TextAlign.left,
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     Container(
                                //       height: 300,
                                //       child: Wrap(children: [
                                //         Text(
                                //           'Kawan Lama Head Office',
                                //           style: GoogleFonts.workSans(
                                //             textStyle: TextStyle(
                                //                 fontSize: 64,
                                //                 fontWeight: FontWeight.w600),
                                //           ),
                                //           textAlign: TextAlign.left,
                                //         ),
                                //       ]),
                                //     ),
                                //   ],
                                // )
                              ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 170,
                        ),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Please select your check in method:',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    HomeButton(
                                        file: 'assets/icons/qr_code.png',
                                        title: 'Scan QR',
                                        title2: '',
                                        onTap: () {
                                          model.resetAll();
                                          model.setisEdit(true);
                                          Navigator.pushNamed(context, '/qr');
                                          // notifDialog(context, false);
                                          // Navigator.of(context).push(
                                          //   NotifDialog(isSuccess: true),
                                          // );
                                        }),
                                    // ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    HomeButton(
                                      file: 'assets/icons/mail.png',
                                      title: 'Invitation',
                                      title2: 'Code',
                                      onTap: () {
                                        model.resetAll();
                                        model.setisEdit(true);
                                        Navigator.pushNamed(context, '/invite');
                                      },
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    HomeButton(
                                      file: 'assets/icons/person_add.png',
                                      title: 'New',
                                      title2: 'Guest',
                                      onTap: () {
                                        model.resetAll();
                                        model.setisEdit(false);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        NewGuestPage(
                                                          isEdit: false,
                                                        )));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ]),
        ),
      );
    });
  }
}
