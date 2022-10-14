import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/responsive.dart';

class HomeButton extends StatelessWidget {
  HomeButton(
      {required this.file,
      required this.title,
      required this.title2,
      required this.onTap});

  final String file;
  final String title;
  final String title2;
  // final String routeName;
  final VoidCallback? onTap;

  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/image.svg';
    final Widget svg = SvgPicture.asset('$file', semanticsLabel: 'Acme Logo');
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed
      };
      if (states.any(interactiveStates.contains)) {
        return eerieBlack;
      }
      return Color(0xFFF5F5F5);
    }

    return SizedBox(
      width: Responsive.isSmallTablet(context) ? 140 : 170,
      height: Responsive.isSmallTablet(context) ? 200 : 210,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
              (Set<MaterialState> states) {
            return EdgeInsets.zero;
          }),
          foregroundColor: MaterialStateProperty.resolveWith(getColor),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w400, color: eerieBlack);
            }
            return TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFFF5F5F5));
          }),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.black, width: 5));
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15));
          }),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return Color(0xFFF5F5F5); //<-- SEE HERE
              return null; // Defer to the widget's default.
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return Colors.transparent; //eerieBlack;
          }),
          elevation: MaterialStateProperty.all(10),
          shadowColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return Colors.black;
          }),
        ),
        onPressed: onTap,
        child: Ink(
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //       blurRadius: 40, offset: Offset(0.0, 16.0), color: eerieBlack)
            // ],
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[onyxBlack, eerieBlack],
            ),
          ),
          child: Container(
            padding: EdgeInsets.zero,
            child: Center(
              child: Column(children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.only(top: 22, bottom: 10),
                  margin: EdgeInsets.all(16),
                  child: ImageIcon(AssetImage('$file')),
                ),
                Text(
                  '$title',
                ),
                Text(
                  '$title2',
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
