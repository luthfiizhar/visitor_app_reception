import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/functions/hive_functions.dart';

class WelcomeGuestPage extends StatelessWidget {
  const WelcomeGuestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(75), child: CustAppBar()),
        body: Center(
          child: Container(
              height: MediaQuery.of(context).size.height,
              // color: redBright,
              padding:
                  EdgeInsets.only(top: 120, left: 100, right: 100, bottom: 20),
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
                      child: SvgPicture.asset('assets/welcome_image_new.svg',
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
                            clearVisitorData();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (Route<dynamic> route) => false);
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
  }
}
