// To parse this JSON data, do
//
//     final getUpdateprofileModel = getUpdateprofileModelFromJson(jsonString);

import 'dart:convert';

GetUpdateprofileModel getUpdateprofileModelFromJson(String str) => GetUpdateprofileModel.fromJson(json.decode(str));

String getUpdateprofileModelToJson(GetUpdateprofileModel data) => json.encode(data.toJson());

class GetUpdateprofileModel {
  bool? success;
  Data? data;
  String? message;

  GetUpdateprofileModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetUpdateprofileModel.fromJson(Map<String, dynamic> json) => GetUpdateprofileModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  String? notify;
  String? status;
  String? memberId;
  List<MemberDetail>? memberDetails;

  Data({
    this.notify,
    this.status,
    this.memberId,
    this.memberDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notify: json["notify"],
    status: json["status"],
    memberId: json["member_id"],
    memberDetails: json["member_details"] == null ? [] : List<MemberDetail>.from(json["member_details"]!.map((x) => MemberDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notify": notify,
    "status": status,
    "member_id": memberId,
    "member_details": memberDetails == null ? [] : List<dynamic>.from(memberDetails!.map((x) => x.toJson())),
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
