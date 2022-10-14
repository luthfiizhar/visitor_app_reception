import 'package:flutter/material.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/login_input_field.dart';
import 'package:visitor_app/components/nip_dialog.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:visitor_app/responsive.dart';

class OverrideDialogLogin extends StatefulWidget {
  const OverrideDialogLogin({super.key});

  @override
  State<OverrideDialogLogin> createState() => _OverrideDialogLoginState();
}

class _OverrideDialogLoginState extends State<OverrideDialogLogin> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();

  String userName = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: 600,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: scaffoldBg,
            borderRadius: BorderRadius.circular(15),
          ),
          // color: scaffoldBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: Responsive.isSmallTablet(context) ? 48 : 64,
                  fontWeight: FontWeight.w700,
                  color: eerieBlack,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Username',
                style: TextStyle(
                  fontSize: Responsive.isSmallTablet(context) ? 22 : 24,
                  fontWeight: FontWeight.w700,
                  color: eerieBlack,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              LoginInputField(
                controller: _userName,
                obsecureText: false,
                onSaved: (value) {
                  userName = value!;
                },
                validator: (value) =>
                    value == "" ? "This Field is Required" : null,
                alignCenter: false,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: Responsive.isSmallTablet(context) ? 22 : 24,
                  fontWeight: FontWeight.w700,
                  color: eerieBlack,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              LoginInputField(
                controller: _password,
                obsecureText: false,
                onSaved: (value) {
                  password = value!;
                },
                validator: (value) =>
                    value == "" ? "This Field is Required" : null,
                alignCenter: false,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 180,
                height: 60,
                child: RegularButton(
                  title: 'Login',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return NipDialog();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
