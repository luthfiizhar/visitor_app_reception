import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/login_input_field.dart';
import 'package:visitor_app/components/notif_dialog.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/functions/request_api.dart';
import 'package:visitor_app/main_model.dart';

class NipDialog extends StatefulWidget {
  const NipDialog({super.key});

  @override
  State<NipDialog> createState() => _NipDialogState();
}

class _NipDialogState extends State<NipDialog> {
  TextEditingController _nip = TextEditingController();
  String nip = "";
  FocusNode nipNode = FocusNode();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      // padding: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.only(top: 10),
      width: 80,
      height: 100,
      // padding: EdgeInsets.only(right: 20),
      textStyle: const TextStyle(
        fontSize: 56,
        color: eerieBlack,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: graySand,
        border: Border.all(color: grayStone, width: 2.5),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      boxShadow: [
        const BoxShadow(
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Consumer<MainModel>(builder: (context, model, child) {
        return ConstrainedBox(
          constraints: const BoxConstraints(
            // maxHeight: 550,
            minHeight: 500,
            maxHeight: 525,
            maxWidth: 700,
          ),
          child: Container(
            // height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: scaffoldBg,
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 75,
                    vertical: 70,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Visitor not verified, ',
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: onyxBlack),
                          children: [
                            TextSpan(
                              text:
                                  'please input Security PIN for verification',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontSize: 26,
                                  fontWeight: FontWeight.w300,
                                  color: onyxBlack),
                            ),
                          ],
                        ),
                      ),
                      // const Text(
                      //   'Please input Security PIN for verification',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontFamily: 'Helvetica',
                      //       fontSize: 26,
                      //       fontWeight: FontWeight.w300,
                      //       color: onyxBlack),
                      // ),
                      const SizedBox(
                        height: 50,
                      ),
                      Pinput(
                          controller: _nip,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          onCompleted: (pin) {
                            setState(() {
                              nip = pin;
                            });
                          },
                          separator: SizedBox(
                            width: 19,
                          ),
                          closeKeyboardWhenCompleted: true,
                          length: 6,
                          obscureText: true,
                          obscuringCharacter: '*',
                          // obscuringWidget: Icon(Icons.),
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          errorTextStyle:
                              const TextStyle(color: silver, fontSize: 18),
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
                      // LoginInputField(
                      //   controller: _nip,
                      //   focusNode: nipNode,
                      //   obsecureText: false,
                      //   keyboardType: TextInputType.number,
                      //   onSaved: (value) {
                      //     nip = value!;
                      //   },
                      //   validator: (value) =>
                      //       value == "" ? 'This field is required' : null,
                      //   alignCenter: true,
                      // ),
                      const SizedBox(
                        height: 100,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: eerieBlack,
                              )
                            : SizedBox(
                                height: 80,
                                width: 300,
                                child: RegularButton(
                                  title: 'Confirm',
                                  onTap: () {
                                    print(nip);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    securityCheck(
                                            model.listSelectedVisitor, nip)
                                        .then((value) {
                                      print(value);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (value['Status'] == "200") {
                                        model.setPinSecurity(nip);
                                        Navigator.of(context).pop(true);
                                      } else {
                                        notifDialog(context, false,
                                                value["Message"])
                                            .then((value) {
                                          Navigator.of(context).pop(false);
                                        });
                                      }
                                    }).onError((error, stackTrace) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      notifDialog(context, false,
                                          "No internet connection");
                                    });
                                  },
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 30,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Icon(
                      Icons.close,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
