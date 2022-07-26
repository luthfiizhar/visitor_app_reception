import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:visitor_app/colors.dart';
import 'package:visitor_app/components/custom_appbar.dart';
import 'package:visitor_app/components/input_field.dart';
import 'package:visitor_app/components/regular_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visitor_app/constant.dart';
import 'package:visitor_app/functions/hive_functions.dart';
import 'package:visitor_app/functions/request_api.dart';
import 'package:visitor_app/keys.dart';
import 'package:visitor_app/main_model.dart';
import 'package:http/http.dart' as http;
import 'package:visitor_app/pages/visitor_info_page.dart';

class NewGuestPage extends StatefulWidget {
  NewGuestPage({Key? key, this.isEdit}) : super(key: key);

  bool? isEdit;
  @override
  State<NewGuestPage> createState() => _NewGuestPageState();
}

class _NewGuestPageState extends State<NewGuestPage> {
  late String firstName;
  late String lastName;
  late String jenisKelamin = '1';
  late String email;
  late String phoneCode;
  late String phoneNumber;
  late String origin;
  late String reasonVisit = '0';
  late String employee = '';
  List visitReasonList = [];
  List genderList = [];

  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _phoneNumberCode = TextEditingController();
  TextEditingController _origin = TextEditingController();
  TextEditingController _employee = TextEditingController();
  TextEditingController _test = TextEditingController();

  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode emailNode;
  late FocusNode phoneNumberNode;
  late FocusNode phoneCodeNode;
  late FocusNode genderNode;
  late FocusNode originNode;
  late FocusNode reasonNode;
  late FocusNode employeeNode;
  late FocusNode testNode;

  bool dataCompleted = false;

  bool focusedFirstName = false;
  bool focusedLastName = false;

  bool emptyPhoto = false;

  final _formKey = new GlobalKey<FormState>();

  //Camera Variable
  File? pickedImage;
  var imageFile;
  String? base64image;
  final picker = ImagePicker();
  File? _image;

  Future getImage() async {
    print('getimage');
    imageCache.clear();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    imageFile = await pickedFile!.readAsBytes();
    imageFile = await decodeImageFromList(imageFile);

    setState(() {
      _image = File(pickedFile.path);
      // pr.show();
      // isLoading = true;
      // compressImage(_image).then((value) {
      // pr.hide();
      // _image = value;
      List<int> imageBytes = _image!.readAsBytesSync();
      base64image = base64Encode(imageBytes);
      // });
    });
  }

  Future checkDataVisitor() async {
    var box = await Hive.openBox('visitorBox');

    firstName = box.get('firstName') != "" ? box.get('firstName') : "";
    lastName = box.get('lastName') != "" ? box.get('lastName') : "";
    jenisKelamin = box.get('gender') != "" ? box.get('gender') : "1";
    email = box.get('email') != "" ? box.get('email') : "";
    origin = box.get('origin') != "" ? box.get('origin') : "1";
    phoneCode = box.get('phoneCode') != "" ? box.get('phoneCode') : "";
    phoneNumber = box.get('phoneNumber') != "" ? box.get('phoneNumber') : "";
    employee = box.get('employee') != "" ? box.get('employee') : "";
    reasonVisit = box.get('reason') != "" ? box.get('reason') : "";
    dataCompleted = box.get('completed');

    // if (dataCompleted == false) {
    //   return;
    // } else {
    // print('firstName->' + firstName);
    setState(() {
      _firstName.text = firstName != "" ? firstName : "";
      _lastName.text = lastName != "" ? lastName : "";
      _email.text = email != "" ? email : "";
      _origin.text = origin != "" ? origin : "";
      _phoneNumber.text = phoneNumber != "" ? phoneNumber : "";
      // }
    });
  }

  Future getVisitReason() async {
    var url = Uri.https(
        apiUrl, '/VisitorManagementBackend/public/api/visitor/visit-reason');
    Map<String, String> requestHeader = {
      'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
      'Content-Type': 'application/json'
    };
    try {
      var response = await http.get(url, headers: requestHeader);
      var data = json.decode(response.body);
      print(data['Data']);
      visitReasonList = data['Data'];
    } on SocketException catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future getGender() async {
    var url = Uri.https(
        apiUrl, '/VisitorManagementBackend/public/api/visitor/gender-list');
    Map<String, String> requestHeader = {
      'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
      'Content-Type': 'application/json'
    };
    try {
      var response = await http.get(url, headers: requestHeader);
      var data = json.decode(response.body);
      print(data['Data']);
      genderList = data['Data'];
    } on SocketException catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future saveVisitorForm(
    String id,
    int reason,
    int gender,
    String origin,
    String code,
    String number,
    String photo,
  ) async {
    var url = Uri.https(apiUrl,
        '/VisitorManagementBackend/public/api/visitor/save-visitor-form');
    Map<String, String> requestHeader = {
      'AppToken': 'mDMgDh4Eq9B0KRJLSOFI',
      'Content-Type': 'application/json'
    };
    var bodySend = """ 
      {
            "VisitorID" : "$id",
            "VisitReason" : $reason,
            "Gender" : $gender,
            "CompanyName" : "$origin",
            "Code" : "$code",
            "PhoneNumber" : "$number",
            "Photo" : "data:image/jpeg;base64,$photo"

      }
    """;

    // print(bodySend);
    try {
      var response =
          await http.post(url, headers: requestHeader, body: bodySend);
      var data = json.decode(response.body);
      print(data);
      return data;
    } on SocketException catch (e) {
      print(e);
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVisitReason();
    getGender();
    if (widget.isEdit == true) {
      print('check Data');
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        print(Provider.of<MainModel>(context, listen: false).firstName);
        setState(() {
          _firstName.text =
              Provider.of<MainModel>(context, listen: false).firstName;
          _lastName.text =
              Provider.of<MainModel>(context, listen: false).lastName;
          _email.text = Provider.of<MainModel>(context, listen: false).email;
          _origin.text = Provider.of<MainModel>(context, listen: false).origin;
          _employee.text =
              Provider.of<MainModel>(context, listen: false).employee;
          // var list = Provider.of<MainModel>(context, listen: false)
          //     .listSelectedVisitor;
          // print(list);
          // reasonVisit =
          //     Provider.of<MainModel>(context, listen: false).reason;
          _formKey.currentState!.validate();
        });
      });
      // checkDataVisitor().then((_) {

      //   setState(() {});
      // });
    } else {
      print('no check Data');
      // clearVisitorData();
    }
    // jenisKelamin = '';
    _phoneNumberCode.text = '62';
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    emailNode = FocusNode();
    phoneCodeNode = FocusNode();
    phoneNumberNode = FocusNode();
    originNode = FocusNode();
    employeeNode = FocusNode();
    testNode = FocusNode();
    testNode.addListener(() {
      setState(() {});
    });
    firstNameNode.addListener(() {
      setState(() {});
      // if (firstNameNode.hasFocus != focusedFirstName) {
      //   setState(() {
      //     focusedFirstName = firstNameNode.hasFocus;
      //   });
      // }
    });
    lastNameNode.addListener(() {
      setState(() {});
    });
    emailNode.addListener(() {
      setState(() {});
    });
    originNode.addListener(() {
      setState(() {});
    });
    phoneCodeNode.addListener(() {
      setState(() {});
    });
    phoneNumberNode.addListener(() {
      setState(() {});
    });
    employeeNode.addListener(() {
      setState(() {});
    });
  }

  // void _handleFocusChange() {
  //   if (firstNameNode.hasFocus != _focused) {
  //     setState(() {
  //       _focused = _node.hasFocus;
  //     });
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameNode.removeListener(() {
      setState(() {});
    });
    lastNameNode.removeListener(() {
      setState(() {});
    });
    originNode.removeListener(() {
      setState(() {});
    });
    emailNode.removeListener(() {
      setState(() {});
    });
    phoneNumberNode.removeListener(() {
      setState(() {});
    });
    phoneCodeNode.removeListener(() {
      setState(() {});
    });
    employeeNode.removeListener(() {
      setState(() {});
    });

    firstNameNode.dispose();
    lastNameNode.dispose();
    originNode.dispose();
    emailNode.dispose();
    phoneNumberNode.dispose();
    phoneCodeNode.dispose();
    employeeNode.dispose();

    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _origin.dispose();
    _phoneNumber.dispose();
    _phoneNumberCode.dispose();
    _employee.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool onError = false;
    return Consumer<MainModel>(builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: CustAppBar(),
          ),
          body: SingleChildScrollView(
            child: Center(
                child: Container(
              padding: EdgeInsets.only(top: 20, left: 100, right: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Visitor Data',
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w600,
                            color: eerieBlack),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Text(
                            'Please fill in your data here',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: onyxBlack),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Container(
                      // duration: Duration(seconds: 5),
                      // margin: const EdgeInsets.all(16),

                      child: Form(
                        key: _formKey,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            // InputVisitorField(
                            //   controller: _test,
                            //   label: 'Test',
                            //   focusNode: testNode,
                            // ),
                            // firstNameField(),
                            // TextFormField(
                            //   controller: _firstName,
                            // ),
                            InputVisitorField(
                              controller: _firstName,
                              label: 'First Name',
                              focusNode: firstNameNode,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    onError = true;
                                  });
                                  return 'This field is required';
                                } else {
                                  setState(() {
                                    onError = false;
                                  });
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  firstName = _firstName.text;
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              // child: lastNameField(),
                              child: InputVisitorField(
                                controller: _lastName,
                                label: 'Last Name',
                                keyboardType: TextInputType.text,
                                focusNode: lastNameNode,
                                validator: (value) => value!.isEmpty
                                    ? 'This field is required'
                                    : null,
                                onSaved: (value) {
                                  setState(() {
                                    lastName = _lastName.text;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: genderField(),
                              // child: InputVisitorField(controller: _lastName,label: 'Las',),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              // child: emailField(),
                              child: InputVisitorField(
                                  controller: _email,
                                  label: 'Email',
                                  focusNode: emailNode,
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    setState(() {
                                      email = _email.text;
                                    });
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: phoneNoField(),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: noteContainer()),

                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              // child: originField(),
                              child: InputVisitorField(
                                controller: _origin,
                                label: 'Origin Company',
                                focusNode: originNode,
                                keyboardType: TextInputType.text,
                                validator: (value) => value == ""
                                    ? "This Field is Required"
                                    : null,
                                onSaved: (value) {
                                  setState(() {
                                    origin = _origin.text;
                                  });
                                },
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: reasonField()),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: InputVisitorField(
                                controller: _employee,
                                label: 'Meeting with',
                                focusNode: employeeNode,
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  setState(() {
                                    employee = value!;
                                  });
                                },
                                validator: (value) => value == ""
                                    ? "This field is required"
                                    : null,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: photoField()),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 100.0, bottom: 50),
                                child: SizedBox(
                                  width: 600,
                                  height: 80,
                                  child: RegularButton(
                                    width: 600,
                                    height: 80,
                                    routeName: '',
                                    title: 'Next',
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        // print(firstName);
                                        // print(lastName);
                                        // print(email);
                                        model.setFirstName(firstName);
                                        model.setLastName(lastName);
                                        model.setEmail(email);
                                        model.setPhoto(base64image!);
                                        model
                                            .setGender(int.parse(jenisKelamin));
                                        model.setEmployee(employee);
                                        model.setOrigin(origin);
                                        model.setReason(int.parse(reasonVisit));
                                        model.setPhoneCode(phoneCode);
                                        model.setPhoneNumber(phoneNumber);

                                        // model.set
                                        print(model.visitorId);
                                        print(base64image);
                                        print(origin);
                                        print(jenisKelamin);
                                        print(reasonVisit);
                                        print(phoneCode);
                                        print(phoneNumber);
                                        print("status page->" +
                                            model.isLastVisitor.toString());
                                        print("status edit->" +
                                            model.isEdit.toString());
                                        // Navigator.pushNamed(
                                        //     context, '/visitorInfo');
                                        if (model.isEdit == true) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VisitorInfoPage(
                                                visitorId: model.visitorId,
                                                firstName: model.firstName,
                                                lastName: model.lastName,
                                                email: model.email,
                                                gender: model.gender,
                                                visitReason: model.reason,
                                                employee: model.employee,
                                                visitDate: model.visitDate,
                                                origin: model.origin,
                                                photo: model.photo,
                                                phoneCode: model.phoneCode,
                                                phoneNumber: model.phoneNumber,
                                              ),
                                            ),
                                          );
                                          print('Edit');
                                        } else {
                                          print('NewGuest');
                                          String formattedDate =
                                              DateFormat('d MMMM yyyy')
                                                  .format(DateTime.now());
                                          model.setVisitDate(formattedDate);
                                          print(model.visitDate);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VisitorInfoPage(
                                                visitorId: "",
                                                firstName: model.firstName,
                                                lastName: model.lastName,
                                                email: model.email,
                                                gender: model.gender,
                                                visitReason: model.reason,
                                                employee: model.employee,
                                                visitDate: model.visitDate,
                                                origin: model.origin,
                                                photo: model.photo,
                                                phoneCode: model.phoneCode,
                                                phoneNumber: model.phoneNumber,
                                              ),
                                            ),
                                          );
                                        }

                                        // print(model.listSelectedVisitor);

                                        // saveVisitorForm(
                                        //         model.visitorId,
                                        //         int.parse(reasonVisit),
                                        //         int.parse(jenisKelamin),
                                        //         origin,
                                        //         phoneCode,
                                        //         phoneNumber,
                                        //         base64image!)
                                        //     .then((value) {

                                        // });
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   const SnackBar(
                                        //       content: Text('Processing Data')),
                                        // );

                                      } else {
                                        setState(() {});
                                      }
                                    },
                                  ),
                                )),
                            // Container(
                            //   decoration: !focusedFirstName
                            //       ? null
                            //       : BoxDecoration(
                            //           color: Color(0xFFF5F5F5),
                            //           borderRadius: BorderRadius.circular(15),
                            //           boxShadow: [
                            //               BoxShadow(
                            //                   blurRadius: 0,
                            //                   offset: Offset(0.0, 5.0),
                            //                   color: Color(0xFFA80038))
                            //             ]),
                            //   child: InputVisitorField(
                            //     controller: _firstName,
                            //     label: 'First Name',
                            //     focusNode: firstNameNode,
                            //     focus: focusedFirstName,
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 30),
                            //   child: InputVisitorField(
                            //     controller: _lastName,
                            //     label: 'Last Name',
                            //     // focusNode: _node,
                            //     // focus: _focused,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      );
    });
  }

  Widget genderField() {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FormLabel(
                  text: 'Gender',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  padding: EdgeInsets.zero,
                  height: 70,
                  width: 250,
                  // color: Colors.blue,
                  child: DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(15),
                    dropdownColor: graySand,
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 0, right: 15),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: eerieBlack,
                      ),
                    ),
                    iconSize: 36,
                    itemHeight: 50,
                    items: genderList.map((e) {
                      return DropdownMenuItem(
                        child: Text(e['Name']),
                        value: e['Value'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        jenisKelamin = value.toString();
                      });
                    },
                    value: int.parse(jenisKelamin),
                    decoration: InputDecoration(
                        // filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                        focusColor: eerieBlack,
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: eerieBlack, width: 10)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color(0xFF929AAB), width: 2.5)),
                        fillColor: graySand,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color(0xFF929AAB), width: 2.5))),
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF393E46)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget phoneNoField() {
    return Container(
        child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: FormLabel(
                text: 'Phone Number',
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.zero,
                  width: 120,
                  child: phoneCodeInput()),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  padding: EdgeInsets.zero,
                  width: 250,
                  // height: 70,
                  child: phoneNumberInput(),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget phoneNumberInput() {
    return TextFormField(
      focusNode: phoneNumberNode,
      controller: _phoneNumber,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      validator: (value) => value!.isEmpty ? 'This field is required' : null,
      onSaved: (value) {
        setState(() {
          phoneNumber = _phoneNumber.text;
        });
      },
      cursorColor: eerieBlack,
      decoration: InputDecoration(
        isDense: true,
        isCollapsed: true,
        contentPadding: EdgeInsets.only(
            top: 25,
            left: 30,
            right: 30,
            bottom: 25), //EdgeInsets.fromLTRB(30, 20, 0, 20),

        focusColor: eerieBlack,
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
            borderSide: BorderSide(color: Color(0xFF929AAB), width: 2.5)),
        fillColor: graySand,
        filled: true,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: orangeRed, width: 2.5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFF929AAB), width: 2.5)),
        errorStyle: TextStyle(color: orangeRed, fontSize: 18),
      ),
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFF393E46)),
    );
  }

  Widget phoneCodeInput() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            cursorColor: redRose,
            controller: _phoneNumberCode,
            focusNode: phoneCodeNode,
            validator: (value) {
              if (_phoneNumber.text.isEmpty) {
                return '';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              phoneCode = _phoneNumberCode.text;
            },
            keyboardType: TextInputType.number,
            // textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(
                  Icons.add,
                  size: 24,
                  color: eerieBlack,
                ),
              ),
              prefixIconColor: eerieBlack,
              // prefixIconConstraints: BoxConstraints.loose(Size.infinite),
              isDense: true,
              // alignLabelWithHint: true,
              contentPadding: EdgeInsets.only(top: 25, left: 15, bottom: 25),
              isCollapsed: true,
              focusColor: eerieBlack,
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
                  borderSide: BorderSide(color: Color(0xFF929AAB), width: 2.5)),
              fillColor: graySand,
              filled: true,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: orangeRed, width: 2.5)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xFF929AAB), width: 2.5)),
              errorStyle: TextStyle(color: orangeRed, fontSize: 18),
            ),
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w400, color: eerieBlack),
          ),
        ),
      ],
    );
  }

  Widget noteContainer() {
    return Container(
      // height: 50,
      child: Column(
        children: [
          Wrap(children: [
            Container(
              height: 60,
              child: RichText(
                  text: TextSpan(
                      text: 'Note: ',
                      style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: eerieBlack),
                      children: [
                    TextSpan(
                      text:
                          'We will send our guest wifi login to your email & phone number.',
                      style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: onyxBlack),
                    )
                  ])),
            ),
          ])
        ],
      ),
    );
  }

  Widget reasonField() {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FormLabel(
                  text: 'Visit Reason',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15),
                // height: 70,
                width: 250,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: graySand,
                  ),
                  child: DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(15),
                    dropdownColor: graySand,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: eerieBlack,
                      ),
                    ),
                    iconSize: 36,
                    items: visitReasonList.map((e) {
                      return DropdownMenuItem(
                        child: Text(e['Name']),
                        value: e['Value'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        reasonVisit = value.toString();
                      });
                    },
                    value: int.parse(reasonVisit),
                    decoration: InputDecoration(
                        // filled: true,
                        contentPadding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                        focusColor: eerieBlack,
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: eerieBlack, width: 10)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color(0xFF929AAB), width: 2.5)),
                        fillColor: graySand,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color(0xFF929AAB), width: 2.5))),
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF393E46)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget employeeField() {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FormLabel(
                  text: 'Select Host / Employee',
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            // height: 70,
            // width: 250,
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: graySand,
              ),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(15),
                dropdownColor: graySand,
                icon: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: eerieBlack,
                  ),
                ),
                iconSize: 36,
                items: [
                  DropdownMenuItem(
                    child: Text('Select employee'),
                    value: '',
                    enabled: false,
                  ),
                  DropdownMenuItem(
                    child: Text('A'),
                    value: 'Mr A',
                  ),
                  DropdownMenuItem(
                    child: Text('B'),
                    value: 'Mr B',
                  ),
                  DropdownMenuItem(
                    child: Text('C'),
                    value: 'Mr C',
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    employee = value.toString();
                  });
                },
                value: employee,
                decoration: InputDecoration(
                    // filled: true,
                    contentPadding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                    focusColor: eerieBlack,
                    focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: eerieBlack, width: 10)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xFF929AAB), width: 2.5)),
                    fillColor: graySand,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xFF929AAB), width: 2.5))),
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF393E46)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget photoField() {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FormLabel(
                  text: 'Visitor Photo',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: GestureDetector(
              onTap: () {
                if (_image == null) {
                } else {
                  getImage().then((value) {
                    setState(() {
                      emptyPhoto = false;
                      print('base64');
                      print(base64image);
                      // log(base64image.toString());
                    });
                  });
                }
              },
              child: Container(
                // padding: EdgeInsets.only(top: 15),
                height: 461,
                decoration: BoxDecoration(
                  border: emptyPhoto
                      ? Border.all(color: eerieBlack, width: 2.5)
                      : Border.all(color: grayStone, width: 2.5),
                  borderRadius: BorderRadius.circular(15),
                  color: graySand,
                  // image: _image == null
                  //     ? null
                  //     : DecorationImage(
                  //         image: FileImage(_image!), fit: BoxFit.fitHeight),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image == null
                          ? RegularButton(
                              width: 225,
                              height: 60,
                              title: 'Take Photo',
                              routeName: '',
                              onTap: () {
                                setState(() {
                                  print('tap');
                                  getImage().then((value) {
                                    emptyPhoto = false;
                                    print('base64');
                                    print(base64image);
                                  });
                                });
                              },
                              sizeFont: 26,
                              elevation: 0,
                            )
                          :
                          // Container(
                          //     height: 150,
                          //     width: 150,
                          //     decoration: BoxDecoration(

                          //         border:
                          //             Border.all(color: grayStone, width: 2.5),
                          //         borderRadius: BorderRadius.circular(15),
                          //         color: graySand,
                          //         image: DecorationImage(
                          //             image: FileImage(_image!),
                          //             fit: BoxFit.contain)),
                          //   )
                          CircleAvatar(
                              radius: 200, backgroundImage: FileImage(_image!))
                    ],
                  ),
                ),
              ),
            ),
          ),
          emptyPhoto
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Please take your photo before continue!',
                        style: TextStyle(color: silver, fontSize: 18),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class FormLabel extends StatelessWidget {
  const FormLabel({
    this.text,
    Key? key,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w600, color: iconBlack),
    );
  }
}
