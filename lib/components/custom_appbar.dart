import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/main_model.dart';

class CustAppBar extends StatelessWidget {
  const CustAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, child) {
      return AppBar(
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
                  if (model.isLastVisitor) {
                    model.setIsLastVisitor(false);
                  }
                  model.updateIndex(model.indexPage - 1);
                  Navigator.pop(context);
                },
                // icon: ImageIcon(
                //   AssetImage('assets/icons/left_arrow.png'),
                //   size: 100,
                //   color: eerieBlack,
                // ),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 42,
                  color: eerieBlack,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
