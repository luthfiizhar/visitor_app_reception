import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/constant.dart';
import 'package:visitor_app/main_model.dart';
import 'package:visitor_app/pages/guest_list_page.dart';
import 'package:visitor_app/pages/home_page.dart';
import 'package:visitor_app/pages/invitation_page.dart';
import 'package:visitor_app/pages/new_guest_page.dart';
import 'package:visitor_app/pages/qr_page.dart';
import 'package:visitor_app/pages/visitor_declaration_page.dart';
import 'package:visitor_app/pages/visitor_info_page.dart';
import 'package:visitor_app/pages/welcome_guest_page.dart';

void main() async {
  await Hive.initFlutter();
  runApp(
    ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'Helvetica',
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color(0xFFF5F5F5)),
      home: HomePage(),
      navigatorKey: navKey,
      routes: {
        '/home': (context) => HomePage(),
        '/invite': (context) => InvitationPage(),
        '/qr': (context) => QrCodePage(),
        '/new': (context) => NewGuestPage(),
        '/declaration': (context) => VisitorDeclarationPage(),
        '/guestList': (context) => GuestListPage(),
        '/visitorInfo': (context) => VisitorInfoPage(),
        '/welcome': (context) => WelcomeGuestPage(),
      },
    );
  }
}
