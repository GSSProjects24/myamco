// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import 'package:myamco/App/data/ModelClass/error_response.dart';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool? success;
  Data? data;
  String? message;
  ErrorResponse? errorResponse;
  ProfileModel({
    this.success,
    this.data,
    this.message,
    this.errorResponse,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    errorResponse: json["error"] == null
        ? null
        : ErrorResponse.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "error": errorResponse?.toJson(),
  };
}

class Data {
  String? notify;
  String? status;
  String? memberId;
  List<MemberDetail>? memberDetails;
  List<Detail>? nomineeDetails;
  List<Detail>? guardianDetails;

  Data({
    this.notify,
    this.status,
    this.memberId,
    this.memberDetails,
    this.nomineeDetails,
    this.guardianDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notify: json["notify"],
    status: json["status"],
    memberId: json["member_id"],
    memberDetails: json["member_details"] == null ? [] : List<MemberDetail>.from(json["member_details"]!.map((x) => MemberDetail.fromJson(x))),
    nomineeDetails: json["nominee_details"] == null ? [] : List<Detail>.from(json["nominee_details"]!.map((x) => Detail.fromJson(x))),
    guardianDetails: json["guardian_details"] == null ? [] : List<Detail>.from(json["guardian_details"]!.map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notify": notify,
    "status": status,
    "member_id": memberId,
    "member_details": memberDetails == null ? [] : List<dynamic>.from(memberDetails!.map((x) => x.toJson())),
    "nominee_details": nomineeDetails == null ? [] : List<dynamic>.from(nomineeDetails!.map((x) => x.toJson())),
    "guardian_details": guardianDetails == null ? [] : List<dynamic>.from(guardianDetails!.map((x) => x.toJson())),
  };
}

class Detail {
  int? nomineeId;
  String? memberId;
  String? guardianName;
  String? guardianAddress;
  String? guardianAge;
  String? nomineeRelationship;
  String? guardianNric;
  String? status;
  String? countryId;
  String? stateId;
  String? postalCode;
  String? cityId;
  String? addressTwo;
  String? addressThree;
  String? dob;
  String? phone;
  String? gender;
  String? mobile;
  String? nricO;
  String? nomineename;
  String? nomineeAddress;
  String? nomineeAge;
  String? nomineeNric;

  Detail({
    this.nomineeId,
    this.memberId,
    this.guardianName,
    this.guardianAddress,
    this.guardianAge,
    this.nomineeRelationship,
    this.guardianNric,
    this.status,
    this.countryId,
    this.stateId,
    this.postalCode,
    this.cityId,
    this.addressTwo,
    this.addressThree,
    this.dob,
    this.phone,
    this.gender,
    this.mobile,
    this.nricO,
    this.nomineename,
    this.nomineeAddress,
    this.nomineeAge,
    this.nomineeNric,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    nomineeId: json["nominee_id"],
    memberId: json["member_id"],
    guardianName: json["guardian_name"],
    guardianAddress: json["guardian_address"],
    guardianAge: json["guardian_age"],
    nomineeRelationship: json["nominee_relationship"],
    guardianNric: json["guardian_nric"],
    status: json["status"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    postalCode: json["postal_code"],
    cityId: json["city_id"],
    addressTwo: json["address_two"],
    addressThree: json["address_three"],
    dob: json["dob"],
    phone: json["phone"],
    gender: json["gender"],
    mobile: json["mobile"],
    nricO: json["nric_o"],
    nomineename: json["nomineename"],
    nomineeAddress: json["nominee_address"],
    nomineeAge: json["nominee_age"],
    nomineeNric: json["nominee_nric"],
  );

  Map<String, dynamic> toJson() => {
    "nominee_id": nomineeId,
    "member_id": memberId,
    "guardian_name": guardianName,
    "guardian_address": guardianAddress,
    "guardian_age": guardianAge,
    "nominee_relationship": nomineeRelationship,
    "guardian_nric": guardianNric,
    "status": status,
    "country_id": countryId,
    "state_id": stateId,
    "postal_code": postalCode,
    "city_id": cityId,
    "address_two": addressTwo,
    "address_three": addressThree,
    "dob": dob,
    "phone": phone,
    "gender": gender,
    "mobile": mobile,
    "nric_o": nricO,
    "nomineename": nomineename,
    "nominee_address": nomineeAddress,
    "nominee_age": nomineeAge,
    "nominee_nric": nomineeNric,
  };
}

class MemberDetail {
  int? id;
  String? countryName;
  String? stateName;
  String? cityName;
  String? departmentName;
  String? designationName;
  String? raceName;
  String? costcenter;
  String? memberName;
  String? icNoNew;
  String? race;
  String? icNoOld;
  String? sex;
  String? maritalStatus;
  DateTime? dob;
  DateTime? doj;
  DateTime? amcoDoj;
  DateTime? promotedDate;
  String? address;
  String? addressTwo;
  String? addressThree;
  String? postalCode;
  String? companyName;
  String? costCenterid;
  String? companyNames;
  String? position;
  String? memberNo;
  String? employeeNo;
  String? telephoneNo;
  String? telephoneNoOffice;
  String? telephoneNoHp;
  String? emailId;
  String? entranceFee;
  String? monthlyFee;
  String? pfNo;
  String? officeAddress;
  String? officeAddresstwo;
  String? officeAddressthree;
  String? officeCityid;
  String? officeStateid;
  String? officeCountryid;
  String? offcountryName;
  String? offstateName;
  String? offcityName;
  String? officepostalCode;
  String? officeEmail;
  String? alreadyMember;
  String? proposedName;
  String? proposedNumber;
  String? secondedName;
  String? secondedNumber;
  DateTime? meetDate;
  DateTime? approvedDate;
  String? approvedStatus;
  String? welfareFund;
  String? designation;
  String? department;
  String? recommendedBy;
  String? supportedBy;
  String? memberStatus;
  String? resignDate;
  String? resignRemark;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? memberTitleId;
  String? oldMemberNumber;
  String? countryId;
  String? stateId;
  String? cityId;
  String? doe;
  String? salary;
  String? levy;
  String? levyAmount;
  String? tdf;
  String? tdfAmount;
  String? emailVerifiedAt;
  String? userId;
  String? userType;
  String? createdBy;
  String? updatedBy;
  String? oldKey;
  String? status;
  String? bankName;

  MemberDetail({
    this.id,
    this.countryName,
    this.stateName,
    this.cityName,
    this.departmentName,
    this.designationName,
    this.raceName,
    this.costcenter,
    this.memberName,
    this.icNoNew,
    this.race,
    this.icNoOld,
    this.sex,
    this.maritalStatus,
    this.dob,
    this.doj,
    this.amcoDoj,
    this.promotedDate,
    this.address,
    this.addressTwo,
    this.addressThree,
    this.postalCode,
    this.companyName,
    this.costCenterid,
    this.companyNames,
    this.position,
    this.memberNo,
    this.employeeNo,
    this.telephoneNo,
    this.telephoneNoOffice,
    this.telephoneNoHp,
    this.emailId,
    this.entranceFee,
    this.monthlyFee,
    this.pfNo,
    this.officeAddress,
    this.officeAddresstwo,
    this.officeAddressthree,
    this.officeCityid,
    this.officeStateid,
    this.officeCountryid,
    this.offcountryName,
    this.offstateName,
    this.offcityName,
    this.officepostalCode,
    this.officeEmail,
    this.alreadyMember,
    this.proposedName,
    this.proposedNumber,
    this.secondedName,
    this.secondedNumber,
    this.meetDate,
    this.approvedDate,
    this.approvedStatus,
    this.welfareFund,
    this.designation,
    this.department,
    this.recommendedBy,
    this.supportedBy,
    this.memberStatus,
    this.resignDate,
    this.resignRemark,
    this.updatedAt,
    this.createdAt,
    this.memberTitleId,
    this.oldMemberNumber,
    this.countryId,
    this.stateId,
    this.cityId,
    this.doe,
    this.salary,
    this.levy,
    this.levyAmount,
    this.tdf,
    this.tdfAmount,
    this.emailVerifiedAt,
    this.userId,
    this.userType,
    this.createdBy,
    this.updatedBy,
    this.oldKey,
    this.status,
    this.bankName,
  });

  factory MemberDetail.fromJson(Map<String, dynamic> json) => MemberDetail(
    id: json["id"],
    countryName: json["country_name"],
    stateName: json["state_name"],
    cityName: json["city_name"],
    departmentName: json["department_name"],
    designationName: json["designation_name"],
    raceName: json["race_name"],
    costcenter: json["costcenter"],
    memberName: json["member_name"],
    icNoNew: json["ic_no_new"],
    race: json["race"],
    icNoOld: json["ic_no_old"],
    sex: json["sex"],
    maritalStatus: json["marital_status"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    doj: json["doj"] == null ? null : DateTime.parse(json["doj"]),
    amcoDoj: json["amco_doj"] == null ? null : DateTime.parse(json["amco_doj"]),
    promotedDate: json["promoted_date"] == null ? null : DateTime.parse(json["promoted_date"]),
    address: json["address"],
    addressTwo: json["address_two"],
    addressThree: json["address_three"],
    postalCode: json["postal_code"],
    companyName: json["company_name"],
    costCenterid: json["cost_centerid"],
    companyNames: json["company_names"],
    position: json["position"],
    memberNo: json["member_no"],
    employeeNo: json["employee_no"],
    telephoneNo: json["telephone_no"],
    telephoneNoOffice: json["telephone_no_office"],
    telephoneNoHp: json["telephone_no_hp"],
    emailId: json["email_id"],
    entranceFee: json["entrance_fee"],
    monthlyFee: json["monthly_fee"],
    pfNo: json["pf_no"],
    officeAddress: json["office_address"],
    officeAddresstwo: json["office_addresstwo"],
    officeAddressthree: json["office_addressthree"],
    officeCityid: json["office_cityid"],
    officeStateid: json["office_stateid"],
    officeCountryid: json["office_countryid"],
    offcountryName: json["offcountry_name"],
    offstateName: json["offstate_name"],
    offcityName: json["offcity_name"],
    officepostalCode: json["officepostal_code"],
    officeEmail: json["office_email"],
    alreadyMember: json["already_member"],
    proposedName: json["proposed_name"],
    proposedNumber: json["proposed_number"],
    secondedName: json["seconded_name"],
    secondedNumber: json["seconded_number"],
    meetDate: json["meet_date"] == null ? null : DateTime.parse(json["meet_date"]),
    approvedDate: json["approved_date"] == null ? null : DateTime.parse(json["approved_date"]),
    approvedStatus: json["approved_status"],
    welfareFund: json["welfare_fund"],
    designation: json["designation"],
    department: json["department"],
    recommendedBy: json["recommended_by"],
    supportedBy: json["supported_by"],
    memberStatus: json["member_status"],
    resignDate: json["resign_date"],
    resignRemark: json["resign_remark"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    memberTitleId: json["member_title_id"],
    oldMemberNumber: json["old_member_number"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    doe: json["doe"],
    salary: json["salary"],
    levy: json["levy"],
    levyAmount: json["levy_amount"],
    tdf: json["tdf"],
    tdfAmount: json["tdf_amount"],
    emailVerifiedAt: json["email_verified_at"],
    userId: json["user_id"],
    userType: json["user_type"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    oldKey: json["old_key"],
    status: json["status"],
    bankName: json["bank_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_name": countryName,
    "state_name": stateName,
    "city_name": cityName,
    "department_name": departmentName,
    "designation_name": designationName,
    "race_name": raceName,
    "costcenter": costcenter,
    "member_name": memberName,
    "ic_no_new": icNoNew,
    "race": race,
    "ic_no_old": icNoOld,
    "sex": sex,
    "marital_status": maritalStatus,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "doj": "${doj!.year.toString().padLeft(4, '0')}-${doj!.month.toString().padLeft(2, '0')}-${doj!.day.toString().padLeft(2, '0')}",
    "amco_doj": "${amcoDoj!.year.toString().padLeft(4, '0')}-${amcoDoj!.month.toString().padLeft(2, '0')}-${amcoDoj!.day.toString().padLeft(2, '0')}",
    "promoted_date": "${promotedDate!.year.toString().padLeft(4, '0')}-${promotedDate!.month.toString().padLeft(2, '0')}-${promotedDate!.day.toString().padLeft(2, '0')}",
    "address": address,
    "address_two": addressTwo,
    "address_three": addressThree,
    "postal_code": postalCode,
    "company_name": companyName,
    "cost_centerid": costCenterid,
    "company_names": companyNames,
    "position": position,
    "member_no": memberNo,
    "employee_no": employeeNo,
    "telephone_no": telephoneNo,
    "telephone_no_office": telephoneNoOffice,
    "telephone_no_hp": telephoneNoHp,
    "email_id": emailId,
    "entrance_fee": entranceFee,
    "monthly_fee": monthlyFee,
    "pf_no": pfNo,
    "office_address": officeAddress,
    "office_addresstwo": officeAddresstwo,
    "office_addressthree": officeAddressthree,
    "office_cityid": officeCityid,
    "office_stateid": officeStateid,
    "office_countryid": officeCountryid,
    "offcountry_name": offcountryName,
    "offstate_name": offstateName,
    "offcity_name": offcityName,
    "officepostal_code": officepostalCode,
    "office_email": officeEmail,
    "already_member": alreadyMember,
    "proposed_name": proposedName,
    "proposed_number": proposedNumber,
    "seconded_name": secondedName,
    "seconded_number": secondedNumber,
    "meet_date": "${meetDate!.year.toString().padLeft(4, '0')}-${meetDate!.month.toString().padLeft(2, '0')}-${meetDate!.day.toString().padLeft(2, '0')}",
    "approved_date": "${approvedDate!.year.toString().padLeft(4, '0')}-${approvedDate!.month.toString().padLeft(2, '0')}-${approvedDate!.day.toString().padLeft(2, '0')}",
    "approved_status": approvedStatus,
    "welfare_fund": welfareFund,
    "designation": designation,
    "department": department,
    "recommended_by": recommendedBy,
    "supported_by": supportedBy,
    "member_status": memberStatus,
    "resign_date": resignDate,
    "resign_remark": resignRemark,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "member_title_id": memberTitleId,
    "old_member_number": oldMemberNumber,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "doe": doe,
    "salary": salary,
    "levy": levy,
    "levy_amount": levyAmount,
    "tdf": tdf,
    "tdf_amount": tdfAmount,
    "email_verified_at": emailVerifiedAt,
    "user_id": userId,
    "user_type": userType,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "old_key": oldKey,
    "status": status,
    "bank_name": bankName,
  };
}
extension MemberDetailCopy on MemberDetail {
  MemberDetail copyWith({
    int? id,
    String? countryName,
    String? stateName,
    String? cityName,
    String? departmentName,
    String? designationName,
    String? raceName,
    String? costcenter,
    String? memberName,
    String? icNoNew,
    String? race,
    String? icNoOld,
    String? sex,
    String? maritalStatus,
    DateTime? dob,
    DateTime? doj,
    DateTime? amcoDoj,
    DateTime? promotedDate,
    String? address,
    String? addressTwo,
    String? addressThree,
    String? postalCode,
    String? companyName,
    String? costCenterid,
    String? companyNames,
    String? position,
    String? memberNo,
    String? employeeNo,
    String? telephoneNo,
    String? telephoneNoOffice,
    String? telephoneNoHp,
    String? emailId,
    String? entranceFee,
    String? monthlyFee,
    String? pfNo,
    String? officeAddress,
    String? officeAddresstwo,
    String? officeAddressthree,
    String? officeCityid,
    String? officeStateid,
    String? officeCountryid,
    String? offcountryName,
    String? offstateName,
    String? offcityName,
    String? officepostalCode,
    String? officeEmail,
    String? alreadyMember,
    String? proposedName,
    String? proposedNumber,
    String? secondedName,
    String? secondedNumber,
    DateTime? meetDate,
    DateTime? approvedDate,
    String? approvedStatus,
    String? welfareFund,
    String? designation,
    String? department,
    String? recommendedBy,
    String? supportedBy,
    String? memberStatus,
    String? resignDate,
    String? resignRemark,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? memberTitleId,
    String? oldMemberNumber,
    String? countryId,
    String? stateId,
    String? cityId,
    String? doe,
    String? salary,
    String? levy,
    String? levyAmount,
    String? tdf,
    String? tdfAmount,
    String? emailVerifiedAt,
    String? userId,
    String? userType,
    String? createdBy,
    String? updatedBy,
    String? oldKey,
    String? status,
    String? bankName,
  }) {
    return MemberDetail(
      id: id ?? this.id,
      countryName: countryName ?? this.countryName,
      stateName: stateName ?? this.stateName,
      cityName: cityName ?? this.cityName,
      departmentName: departmentName ?? this.departmentName,
      designationName: designationName ?? this.designationName,
      raceName: raceName ?? this.raceName,
      costcenter: costcenter ?? this.costcenter,
      memberName: memberName ?? this.memberName,
      icNoNew: icNoNew ?? this.icNoNew,
      race: race ?? this.race,
      icNoOld: icNoOld ?? this.icNoOld,
      sex: sex ?? this.sex,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      dob: dob ?? this.dob,
      doj: doj ?? this.doj,
      amcoDoj: amcoDoj ?? this.amcoDoj,
      promotedDate: promotedDate ?? this.promotedDate,
      address: address ?? this.address,
      addressTwo: addressTwo ?? this.addressTwo,
      addressThree: addressThree ?? this.addressThree,
      postalCode: postalCode ?? this.postalCode,
      companyName: companyName ?? this.companyName,
      costCenterid: costCenterid ?? this.costCenterid,
      companyNames: companyNames ?? this.companyNames,
      position: position ?? this.position,
      memberNo: memberNo ?? this.memberNo,
      employeeNo: employeeNo ?? this.employeeNo,
      telephoneNo: telephoneNo ?? this.telephoneNo,
      telephoneNoOffice: telephoneNoOffice ?? this.telephoneNoOffice,
      telephoneNoHp: telephoneNoHp ?? this.telephoneNoHp,
      emailId: emailId ?? this.emailId,
      entranceFee: entranceFee ?? this.entranceFee,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      pfNo: pfNo ?? this.pfNo,
      officeAddress: officeAddress ?? this.officeAddress,
      officeAddresstwo: officeAddresstwo ?? this.officeAddresstwo,
      officeAddressthree: officeAddressthree ?? this.officeAddressthree,
      officeCityid: officeCityid ?? this.officeCityid,
      officeStateid: officeStateid ?? this.officeStateid,
      officeCountryid: officeCountryid ?? this.officeCountryid,
      offcountryName: offcountryName ?? this.offcountryName,
      offstateName: offstateName ?? this.offstateName,
      offcityName: offcityName ?? this.offcityName,
      officepostalCode: officepostalCode ?? this.officepostalCode,
      officeEmail: officeEmail ?? this.officeEmail,
      alreadyMember: alreadyMember ?? this.alreadyMember,
      proposedName: proposedName ?? this.proposedName,
      proposedNumber: proposedNumber ?? this.proposedNumber,
      secondedName: secondedName ?? this.secondedName,
      secondedNumber: secondedNumber ?? this.secondedNumber,
      meetDate: meetDate ?? this.meetDate,
      approvedDate: approvedDate ?? this.approvedDate,
      approvedStatus: approvedStatus ?? this.approvedStatus,
      welfareFund: welfareFund ?? this.welfareFund,
      designation: designation ?? this.designation,
      department: department ?? this.department,
      recommendedBy: recommendedBy ?? this.recommendedBy,
      supportedBy: supportedBy ?? this.supportedBy,
      memberStatus: memberStatus ?? this.memberStatus,
      resignDate: resignDate ?? this.resignDate,
      resignRemark: resignRemark ?? this.resignRemark,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      memberTitleId: memberTitleId ?? this.memberTitleId,
      oldMemberNumber: oldMemberNumber ?? this.oldMemberNumber,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      doe: doe ?? this.doe,
      salary: salary ?? this.salary,
      levy: levy ?? this.levy,
      levyAmount: levyAmount ?? this.levyAmount,
      tdf: tdf ?? this.tdf,
      tdfAmount: tdfAmount ?? this.tdfAmount,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      oldKey: oldKey ?? this.oldKey,
      status: status ?? this.status,
      bankName: bankName ?? this.bankName,
    );
  }
}
