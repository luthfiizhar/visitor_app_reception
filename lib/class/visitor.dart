class Visitor {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? phoneCode;
  String? origin;
  String? gender;
  String? reason;
  String? employee;
  String? visitorId;
  String? status;

  bool? enabled;
  bool? completed;

  Visitor(
      {this.visitorId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.phoneCode,
      this.gender,
      this.employee,
      this.origin,
      this.reason,
      this.enabled,
      this.status,
      this.completed});
  Map toJson() => {
        'VisitorID': visitorId,
        // 'FirstName': firstName,
        // 'LastName': lastName,
        // 'Email': email,
        // 'PhoneNumber': phoneNumber,
        // 'PhoneCode': phoneCode,
        // 'Gender': gender,
        // 'Employee': employee,
        // 'Origin': origin,
        // 'ReasonVisit': reason,
      };
  @override
  toString() =>
      'firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, phoneCode: $phoneCode, gender: $gender, employee:$employee, origin: $origin, reason: $reason, enabled: $enabled, completed: $completed';
}
