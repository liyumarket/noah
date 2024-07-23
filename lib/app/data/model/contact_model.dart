class ContactInfo {
  String? name;
  String? organization;
  String? designation;

  List<String>? emailList;
  List<String>? phoneNumbers;

  ContactInfo({
    this.name,
    this.organization,
    this.designation,
    this.emailList,
    this.phoneNumbers,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        name: json["NAME"],
        organization: json["ORGANIZATION"],
        designation: json["DESIGNATION"],
        emailList: json["EMAIL_LIST"] == null
            ? []
            : List<String>.from(json["EMAIL_LIST"]!.map((x) => x)),
        phoneNumbers: json["PHONE_NUMBERS"] == null
            ? []
            : List<String>.from(json["PHONE_NUMBERS"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "NAME": name,
        "ORGANIZATION": organization,
        "DESIGNATION": designation,
        "EMAIL_LIST": emailList == null
            ? []
            : List<dynamic>.from(emailList!.map((x) => x)),
        "PHONE_NUMBERS": phoneNumbers == null
            ? []
            : List<dynamic>.from(phoneNumbers!.map((x) => x)),
      };
}
