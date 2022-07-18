import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitor_app/colors.dart';

class RegularButton extends StatelessWidget {
  // const RegularButton({Key? key}) : super(key: key);
  RegularButton(
      {required this.title,
      this.routeName,
      this.onTap,
      this.sizeFont,
      this.height,
      this.width,
      this.elevation});

  final String title;
  final String? routeName;
  final VoidCallback? onTap;
  final double? sizeFont;
  final double? width;
  final double? height;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    double el;
    if (elevation == null) {
      el = 10;
    } else {
      el = elevation!;
    }
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed
      };
      if (states.any(interactiveStates.contains)) {
        return eerieBlack;
      }
      return Color(0xFFF7F7F7);
    }

    return ElevatedButton(
      onPressed: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Ink(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[onyxBlack, eerieBlack],
            ),
          ),
          child: Center(
            child: Text(
              '$title',
            ),
          ),
        ),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        foregroundColor: MaterialStateProperty.resolveWith(getColor),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return TextStyle(
                fontSize: sizeFont == null ? 30 : sizeFont,
                fontWeight: FontWeight.w600,
                color: eerieBlack);
          }
          return TextStyle(
              fontSize: sizeFont == null ? 30 : sizeFont,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF7F7F7));
        }),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: eerieBlack, width: 5));
          return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15));
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return Colors.white; //<-- SEE HERE
            return null; // Defer to the widget's default.
          },
        ),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        elevation: MaterialStateProperty.all(el),
        shadowColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return Colors.black;
        }),
      ),
    );
  }
}
