import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/regular_button.dart';

Future<bool> notifDialog(
    BuildContext context, bool isSucces, String message) async {
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
                    child: isSucces
                        ? SvgPicture.asset('assets/Email confirmed.svg')
                        : SvgPicture.asset('assets/email failed.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Wrap(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [],
                        // ),
                        Text(
                          '$message',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            color: eerieBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      height: 50,
                      width: 250,
                      child: RegularButton(
                        sizeFont: 20,
                        title: 'Confirm',
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

class NotifDialog extends ModalRoute<void> {
  NotifDialog({this.isSuccess});
  bool? isSuccess;
  String? message;
  @override
  // TODO: implement barrierColor
  Color? get barrierColor => Colors.black.withOpacity(0.5);

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => false;

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => null;

  @override
  // TODO: implement maintainState
  bool get maintainState => true;

  @override
  // TODO: implement opaque
  bool get opaque => false;

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: scaffoldBg,
              ),
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            icon: Icon(
                              Icons.close,
                              color: eerieBlack,
                            ),
                            label: Text(''),
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
                      child: isSuccess!
                          ? SvgPicture.asset('assets/Email confirmed.svg')
                          : SvgPicture.asset('assets/Email failed.svg'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Text(
                        isSuccess! ? 'Success' : 'Failed',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        child: Text(
                          isSuccess!
                              ? 'Visitor has been confirmed'
                              : 'You dont have appointment today!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60, bottom: 40),
                      child: SizedBox(
                        height: 50,
                        width: 250,
                        child: RegularButton(
                          sizeFont: 24,
                          title: 'OK',
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
