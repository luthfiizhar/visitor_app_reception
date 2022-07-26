import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitor_app/colors.dart';

class InputVisitorField extends StatefulWidget {
  // const InputVisitorField({Key? key}) : super(key: key);
  InputVisitorField(
      {required this.controller,
      required this.label,
      this.width,
      this.height,
      this.focusNode,
      this.keyboardType,
      this.validator,
      this.onSaved,
      Key? key});

  TextEditingController controller;
  final String label;
  final double? width;
  final double? height;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  // final String? validator;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  // final GlobalKey? formKey;

  @override
  State<InputVisitorField> createState() => _InputVisitorFieldState();
}

class _InputVisitorFieldState extends State<InputVisitorField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.controller.addListener(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                '${widget.label}',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: eerieBlack),
              ),
            ),
          ],
        ),
        // widget.focusNode!.hasFocus
        //     ? Padding(
        //         padding: const EdgeInsets.only(top: 15),
        //         child: Container(
        //           decoration: BoxDecoration(
        //               color: graySand,
        //               borderRadius: BorderRadius.circular(15),
        //               boxShadow: [
        //                 BoxShadow(
        //                     blurRadius: 0,
        //                     offset: Offset(0.0, 5.0),
        //                     color: Color(0xFFFFFFF))
        //               ]),
        //           padding: const EdgeInsets.all(0),
        //           child: textField(),
        //         ),
        //       )
        // :
        Padding(
          padding: const EdgeInsets.only(top: 15),
          // child: Container(
          //   decoration: BoxDecoration(
          //     color: Color(0xFFF5F5F5),
          //     borderRadius: BorderRadius.circular(15),
          //   ),
          //   padding: const EdgeInsets.all(0),
          child: Container(
            // alignment: Alignment.centerLeft,
            // height: 70,
            // width: 640,
            // color: Colors.blue,
            padding: EdgeInsets.zero,
            child: TextFormField(
              key: widget.key,
              keyboardType: widget.keyboardType,
              cursorColor: onyxBlack,
              // focusNode: widget.focusNode,
              controller: widget.controller,
              // onTap: () {
              //   if (widget.focusNode!.hasFocus) {
              //     widget.focusNode!.unfocus();
              //   } else {
              //     FocusScope.of(context).requestFocus(widget.focusNode);
              //   }
              // },
              onSaved: widget.onSaved,
              validator: widget.validator,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                // isCollapsed: true,
                focusColor: onyxBlack,
                focusedErrorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: eerieBlack,
                      width: 10,
                    )),
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: eerieBlack, width: 10)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Color(0xFF929AAB), width: 2.5)),
                fillColor: graySand,
                filled: true,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: orangeRed, width: 2.5)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Color(0xFF929AAB), width: 2.5)),
                errorStyle: TextStyle(color: orangeRed, fontSize: 18),
              ),
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF393E46)),
            ),
          ),
          // ),
        ),
      ],
    );
  }

//   Widget textField() {
//     return Container(
//       // alignment: Alignment.centerLeft,
//       height: 70,
//       width: 640,
//       color: Colors.blue,
//       // padding: EdgeInsets.all(20),
//       child: TextFormField(
//         key: widget.key,
//         keyboardType: widget.keyboardType,
//         cursorColor: onyxBlack,
//         focusNode: widget.focusNode,
//         controller: widget.controller,
//         onTap: () {
//           if (widget.focusNode!.hasFocus) {
//             widget.focusNode!.unfocus();
//           } else {
//             FocusScope.of(context).requestFocus(widget.focusNode);
//           }
//         },
//         onSaved: widget.onSaved,
//         validator: widget.validator,
//         decoration: InputDecoration(
//           isDense: true,
//           contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//           // isCollapsed: true,
//           focusColor: onyxBlack,
//           focusedErrorBorder: UnderlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(
//                 color: eerieBlack,
//                 width: 10,
//               )),
//           focusedBorder: UnderlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(color: eerieBlack, width: 10)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(color: Color(0xFF929AAB), width: 2.5)),
//           fillColor: graySand,
//           filled: true,
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(color: eerieBlack, width: 2.5)),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(color: Color(0xFF929AAB), width: 2.5)),
//           errorStyle: widget.focusNode!.hasFocus
//               ? TextStyle(fontSize: 0, height: 0)
//               : TextStyle(color: silver, fontSize: 18),
//         ),
//         style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w400,
//             color: Color(0xFF393E46)),
//       ),
//     );
//   }
}
