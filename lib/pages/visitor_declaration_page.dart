import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/notif_dialog.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/functions/hive_functions.dart';
import 'package:visitor_app/functions/request_api.dart';
import 'package:visitor_app/main_model.dart';
import 'package:visitor_app/pages/failed_page.dart';
import 'package:visitor_app/responsive.dart';

class VisitorDeclarationPage extends StatefulWidget {
  const VisitorDeclarationPage({Key? key}) : super(key: key);

  @override
  State<VisitorDeclarationPage> createState() => _VisitorDeclarationPageState();
}

class _VisitorDeclarationPageState extends State<VisitorDeclarationPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: AppBar(
              automaticallyImplyLeading: false, // hides leading widget
              // flexibleSpace: SomeWidget(),
              // iconTheme: IconThemeData(
              //     color: Color(0xFFA80038), size: 32 //change your color here
              //     ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        // if (model.isLastVisitor) {
                        //   model.setIsLastVisitor(false);
                        // }
                        // model.updateIndex(model.indexPage - 1);
                        Navigator.pop(context);
                      },
                      // icon: ImageIcon(
                      //   AssetImage('assets/icons/left_arrow.png'),
                      //   size: 100,
                      //   color: eerieBlack,
                      // ),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 42,
                        color: eerieBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: 20,
                  left: Responsive.isSmallTablet(context) ? 50 : 100,
                  right: Responsive.isSmallTablet(context) ? 50 : 100),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Visitor Declaration',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                          color: eerieBlack),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'By filling the form, You declare that:',
                        style: TextStyle(
                          fontSize: Responsive.isSmallTablet(context) ? 26 : 30,
                          fontWeight: FontWeight.w300,
                          color: onyxBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      const DeclarationTextContainer(
                        number: '1',
                        text:
                            'I do not have symptoms of difficulty breathing, fever, cough, runny nose, tiredness & diarrhea.',
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: DeclarationTextContainer(
                          number: '2',
                          text:
                              'I have not had direct or close contact with confirmed COVID-19 patient in the last 14 days.',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: DeclarationTextContainer(
                          number: '3',
                          text:
                              'I have not traveled abroad in the past 14 days.',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: DeclarationTextContainer(
                          number: '4',
                          text:
                              'I am not in recommendation of self-quarantine.',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: DeclarationTextContainer(
                          number: '5',
                          text:
                              'I agree to the term & consent to the collection of My information for the purpose of COVID-19 contact tracing.',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Responsive.isSmallTablet(context) ? 60 : 100,
                            bottom: 30),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: eerieBlack,
                              )
                            : SizedBox(
                                width: 600,
                                height: 80,
                                child: RegularButton(
                                  title: 'Next',
                                  // routeName: '',
                                  onTap: () {
                                    setState(() {});
                                    isLoading = true;
                                    // model.setButtonLoading(true);
                                    print(model.listSelectedVisitor);
                                    if (model.isEdit) {
                                      confirmAttendants(
                                              model.listSelectedVisitor, model)
                                          .then((value) {
                                        setState(() {});
                                        isLoading = false;
                                        // model.setButtonLoading(false);
                                        if (value['Status'] == '200') {
                                          clearVisitorData();
                                          model.resetAll();
                                          // notifDialog(context, true, '')
                                          //     .then((value) {
                                          //   Navigator.of(context)
                                          //       .pushNamedAndRemoveUntil(
                                          //           '/home',
                                          //           (Route<dynamic> route) =>
                                          //               false);
                                          // });
                                          Navigator.pushNamed(
                                              context, '/welcome');
                                        } else {
                                          clearVisitorData();
                                          // model.resetAll();
                                          // notifDialog(context, false).then((value) {
                                          //   Navigator.of(context)
                                          //       .pushNamedAndRemoveUntil('/home',
                                          //           (Route<dynamic> route) => false);
                                          // });
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) => FailedPage(
                                                message: value['Message'],
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            isLoading = false;
                                            setState(() {});
                                          });
                                        }
                                        // else if (value['Status'] == '400') {
                                        //   clearVisitorData();
                                        //   // model.resetAll();
                                        //   // notifDialog(context, false).then((value) {
                                        //   //   Navigator.of(context)
                                        //   //       .pushNamedAndRemoveUntil('/home',
                                        //   //           (Route<dynamic> route) => false);
                                        //   // });
                                        //   Navigator.of(context)
                                        //       .push(
                                        //     MaterialPageRoute(
                                        //       builder: (context) => FailedPage(
                                        //         message: value['Message'],
                                        //       ),
                                        //     ),
                                        //   )
                                        //       .then((value) {
                                        //     isLoading = false;
                                        //     setState(() {});
                                        //   });
                                        // }
                                        // else if (value['Status'] == '500') {
                                        //   clearVisitorData();
                                        //   Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //       builder: (context) => FailedPage(
                                        //         message: value['Message'],
                                        //       ),
                                        //     ),
                                        //   );
                                        // }
                                      }).onError((error, stackTrace) {
                                        setState(() {});
                                        isLoading = false;
                                        model.setButtonLoading(false);
                                        notifDialog(context, false,
                                            'No internet connection.');
                                      });
                                    } else {
                                      onSiteCheckin(
                                              model.firstName,
                                              model.lastName,
                                              model.email,
                                              model.reason,
                                              model.gender,
                                              model.origin,
                                              model.phoneCode,
                                              model.phoneNumber,
                                              model.photo,
                                              model.employee,
                                              model)
                                          .then((value) {
                                        setState(() {});
                                        isLoading = false;
                                        model.setButtonLoading(false);
                                        if (value['Status'] == '200') {
                                          // notifDialog(context, true).then((value) {
                                          //   Navigator.of(context)
                                          //       .pushNamedAndRemoveUntil('/home',
                                          //           (Route<dynamic> route) => false);
                                          // });
                                          Navigator.pushNamed(
                                              context, '/welcome');
                                        } else {
                                          // notifDialog(context, true).then((value) {
                                          //   Navigator.of(context)
                                          //       .pushNamedAndRemoveUntil('/home',
                                          //           (Route<dynamic> route) => false);
                                          // });
                                          // Navigator.pushNamed(
                                          //     context, '/failed_page');
                                          Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) => FailedPage(
                                                message: value['Title'],
                                                description: value['Message'],
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            isLoading = false;
                                            setState(() {});
                                          });
                                        }
                                      }).onError((error, stackTrace) {
                                        setState(() {});
                                        isLoading = false;
                                        model.setButtonLoading(false);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => FailedPage(
                                              message:
                                                  'No internet connection!',
                                            ),
                                          ),
                                        );
                                      });
                                    }
                                  },
                                )),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      );
    });
  }
}

class DeclarationTextContainer extends StatelessWidget {
  const DeclarationTextContainer({Key? key, this.text, this.number})
      : super(key: key);

  final String? text;
  final String? number;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 106,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text('$number',
                style: TextStyle(
                    fontSize: Responsive.isSmallTablet(context) ? 44 : 48,
                    fontWeight: FontWeight.w600,
                    color: eerieBlack)),
          ),
          Expanded(
            child: Wrap(
              children: [
                Text(
                  '$text',
                  style: TextStyle(
                    fontSize: Responsive.isSmallTablet(context) ? 24 : 28,
                    fontWeight: FontWeight.w300,
                    color: onyxBlack,
                    height: 1.2,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
