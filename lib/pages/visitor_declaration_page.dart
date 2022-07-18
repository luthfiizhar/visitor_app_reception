import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/regular_button.dart';

class VisitorDeclarationPage extends StatelessWidget {
  const VisitorDeclarationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: CustAppBar(),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20, left: 100, right: 100),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  DeclarationTextContainer(
                    number: '1',
                    text:
                        'I do not have symptoms of difficulty breathing, fever, cough, runny nose, tiredness & diarrhea.',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: DeclarationTextContainer(
                      number: '2',
                      text:
                          'I have not had direct or close contact with confirmed COVID-19 patient in the last 14 days.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: DeclarationTextContainer(
                      number: '3',
                      text: 'I have not traveled abroad in the past 14 days.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: DeclarationTextContainer(
                      number: '4',
                      text: 'I am not in recommendation of self-quarantine.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: DeclarationTextContainer(
                      number: '5',
                      text:
                          'I agree to the term & consent to the collection of My information for the purpose of COVID-19 contact tracing.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: SizedBox(
                        width: 600,
                        height: 80,
                        child: RegularButton(
                          title: 'Next',
                          // routeName: '',
                          onTap: () {
                            Navigator.pushNamed(context, '/visitorInfo');
                          },
                        )),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
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
      height: 106,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text('$number',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: eerieBlack)),
          ),
          Expanded(
              child: Wrap(children: [
            Text(
              '$text',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            )
          ])),
        ],
      ),
    );
  }
}
