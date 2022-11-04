import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/regular_button.dart';

Future<bool> photoDialog(BuildContext context) async {
  bool shouldPop = true;
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            // title:
            backgroundColor: scaffoldBg, //scaffoldBg,
            content: Container(
              height: 500,
              width: 400,
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     TextButton.icon(
                  //       onPressed: () {
                  //         Navigator.of(context).pop(false);
                  //       },
                  //       icon: Icon(
                  //         Icons.close,
                  //         color: scaffoldBg,
                  //       ),
                  //       label: Text(''),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: eerieBlack,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(
                        top: 80,
                      ),
                      height: 270,
                      width: 250,
                      child: SvgPicture.asset('assets/no_mask.svg')),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Wrap(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [],
                        // ),
                        Text(
                          'No Mask/Hat.',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: eerieBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                      height: 50,
                      width: 250,
                      child: RegularButton(
                        sizeFont: 20,
                        title: 'OK',
                        onTap: () {
                          Navigator.of(context).pop(true);
                          // Navigator.pushReplacementNamed(
                          //     context, routeInvite);
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // height: 500,
              // child: Column(
              //   children: [
              //     Text(
              //       'Message here ....',
              //     ),
              //     // SizedBox(
              //     //   height: 50,
              //     //   width: 250,
              //     //   child: RegularButton(
              //     //     title: 'Confirm',
              //     //     onTap: () {
              //     //       Navigator.pop(context);
              //     //     },
              //     //   ),
              //     // )
              //   ],
              // ),
            ),
            // children: [
            //   Column(
            //     children: [
            //       Text(
            //         'Message here ....',
            //       ),
            //       SizedBox(
            //         height: 50,
            //         width: 250,
            //         child: RegularButton(
            //           title: 'Confirm',
            //           onTap: () {},
            //         ),
            //       )
            //     ],
            //   )
            // ],
          ));
}
