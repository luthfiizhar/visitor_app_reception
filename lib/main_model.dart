import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  int _index = 1;
  String _inviteCode = "";
  String _visitorId = "";
  String _visitDate = "";
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _origin = "";
  String _phoneCode = "";
  String _phoneNumber = "";
  String _completePhoneNumber = "";
  int _gender = 1;
  int _reason = 0;
  String _employee = "";
  String _photo = "";
  String _listSelectedVisitor = "";
  bool _isLastVisitor = true;
  bool _isEdit = false;
  bool _buttonLoading = false;
  String _statusVisitor = "";
  XFile? _photoFile;

  int get indexPage => _index;
  String get inviteCode => _inviteCode;
  String get visitorId => _visitorId;
  String get visitDate => _visitDate;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get origin => _origin;
  String get phoneCode => _phoneCode;
  String get phoneNumber => _phoneNumber;
  String get completePhoneNumber => _completePhoneNumber;
  int get gender => _gender;
  int get reason => _reason;
  String get employee => _employee;
  String get photo => _photo;
  String get listSelectedVisitor => _listSelectedVisitor;
  bool get isLastVisitor => _isLastVisitor;
  bool get isEdit => _isEdit;
  bool get buttonLoading => _buttonLoading;
  String get statusVisitor => _statusVisitor;
  XFile get photoFile => _photoFile!;

  void setPhotoFile(XFile value) {
    _photoFile = value;
    notifyListeners();
  }

  void updateIndex(int idx) {
    _index = idx;
    notifyListeners();
  }

  void setVisitorId(String value) {
    _visitorId = value;
    notifyListeners();
  }

  void setInviteCode(String value) {
    _inviteCode = value;
    notifyListeners();
  }

  void setVisitDate(String value) {
    _visitDate = value;
    notifyListeners();
  }

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setOrigin(String value) {
    _origin = value;
    notifyListeners();
  }

  void setPhoneCode(String value) {
    _phoneCode = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setCompletePhoneNumber(String value) {
    _completePhoneNumber = value;
    notifyListeners();
  }

  void setIsLastVisitor(bool value) {
    _isLastVisitor = value;
    notifyListeners();
  }

  void setGender(int value) {
    _gender = value;
    notifyListeners();
  }

  void setReason(int value) {
    _reason = value;
    notifyListeners();
  }

  void setEmployee(String value) {
    _employee = value;
    notifyListeners();
  }

  void setPhoto(String value) {
    _photo = value;
    notifyListeners();
  }

  void setListSelectedVisitor(String value) {
    _listSelectedVisitor = value;
    notifyListeners();
  }

  void setisEdit(bool value) {
    _isEdit = value;
    notifyListeners();
  }

  void setButtonLoading(bool value) {
    _buttonLoading = value;
  }

  void setStatusVisitor(String value) {
    _statusVisitor = value;
    notifyListeners();
  }

  void resetAll() {
    _index = 1;
    _inviteCode = "";
    _visitorId = "";
    _visitDate = "";
    _firstName = "";
    _lastName = "";
    _email = "";
    _origin = "";
    _phoneCode = "";
    _phoneNumber = "";
    _gender = 1;
    _reason = 0;
    _employee = "";
    _photo = "";
    _listSelectedVisitor = "";
    _isLastVisitor = true;
    _isEdit = false;
    _buttonLoading = false;
    _statusVisitor = "";
    _photoFile = null;
    notifyListeners();
  }
}
