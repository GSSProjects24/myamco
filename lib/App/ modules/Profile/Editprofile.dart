import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myamco/App/config/app_colors.dart';
import 'package:myamco/App/data/ModelClass/getCityDetailModel.dart';
import 'package:myamco/App/data/ModelClass/getDepartmentdetailsModel.dart';
import 'package:myamco/App/data/ModelClass/getDesinationDetailsModel.dart';
import 'package:myamco/App/data/ModelClass/getStatedetailModel.dart';
import 'package:myamco/App/data/ModelClass/getRaseModel.dart';
import 'package:myamco/App/data/ModelClass/profileModel.dart';
import 'package:myamco/App/reusable/common_button.dart';
import 'package:myamco/App/reusable/common_textfield.dart';
import 'Editprofile_Repository.dart';
import 'Editprofile_controller.dart';
import 'profile_Repository.dart';
import 'profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditprofileController(repository: EditprofileRepository()));
    final profileCtrl = Get.put(ProfileController(repository: ProfileRepository()));

    // Dropdown builder
    Widget buildDropdown<T>({
      required String label,
      required Rx<T?> selectedValue,
      required List<T> items,
      required String Function(T) display,
      required void Function(T) onChanged,
    }) {
      return Obx(() => DropdownButtonFormField<T>(
        value: selectedValue.value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        items: items
            .map((item) => DropdownMenuItem(
          value: item,
          child: Text(display(item)),
        ))
            .toList(),
        onChanged: (value) => value != null ? onChanged(value) : null,
      ));
    }

    // Radio group builder
    Widget buildRadioGroup(String label, RxString selected, List<String> options) {
      return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Wrap(
            spacing: 10,
            children: options
                .map((opt) => ChoiceChip(
              label: Text(opt),
              selected: selected.value == opt,
              onSelected: (_) => selected.value = opt,
            ))
                .toList(),
          ),
        ],
      ));
    }

    // Date picker
    Widget buildDatePicker(String label, Rx<DateTime?> selectedDate, {bool readOnly = false}) {
      return Obx(() => InkWell(
        onTap: readOnly
            ? null // 🔒 Prevents tapping if read-only
            : () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: selectedDate.value ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (picked != null) selectedDate.value = picked;
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          child: Text(
            selectedDate.value != null
                ? "${selectedDate.value!.day}-${selectedDate.value!.month}-${selectedDate.value!.year}"
                : "Select $label",
            style: TextStyle(
              color: readOnly ? Colors.grey : null, // Grey out text if read-only
            ),
          ),
        ),
      ));
    }

    // Section wrapper
    Widget buildSection(String title, List<Widget> children) {
      return Card(

        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ...children,
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: AppColors.white),
        ),
      ),

      body: Obx(() {
        if (profileCtrl.isLoading.value) return const Center(child: CircularProgressIndicator());

        final member = profileCtrl.profileData.value?.data?.memberDetails?.first;
        if (member == null) return const Center(child: Text("No profile data available"));

        // Preselect fields
        controller.selectedGender.value = member.sex ?? '';
        controller.selectedMaritalStatus.value = member.maritalStatus ?? '';
        controller.selectedRaceDetail.value ??= controller.raceDetails.firstWhereOrNull((r) => r.raceName == member.raceName);
        controller.selectedDesignationDetail.value ??= controller.designationDetails.firstWhereOrNull((d) => d.designationName == member.designationName);
        controller.selectedDepartmentDetail.value ??= controller.departmentDetails.firstWhereOrNull((d) => d.departmentName == member.departmentName);
        controller.selectedStateDetail.value ??= controller.statedetailsModel.firstWhereOrNull((s) => s.stateName == member.stateName);
        controller.selectedCityDetail.value ??= controller.cityDetailsModel.firstWhereOrNull((c) => c.cityName == member.cityName);

        Rx<DateTime?> doj = (member.doj != null) ? Rx(DateTime.parse(member.doj!.toString())) : Rx(null);
        Rx<DateTime?> amcoDoj = (member.amcoDoj != null) ? Rx(DateTime.parse(member.amcoDoj!.toString())) : Rx(null);
        Rx<DateTime?> promotedDate = (member.promotedDate != null) ? Rx(DateTime.parse(member.promotedDate!.toString())) : Rx(null);
        Rx<DateTime?> approvedDate = (member.approvedDate != null) ? Rx(DateTime.parse(member.approvedDate!.toString())) : Rx(null);
        Rx<DateTime?> dod = (member.dob != null) ? Rx(DateTime.parse(member.dob!.toString())) : Rx(null);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildSection("Personal Info", [
                CommonTextInput(label: "Full Name",
                    readOnly: true, initialValue: member.memberName ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(memberName: v)),
                const SizedBox(height: 16),
                CommonTextInput(label: "PF Number",
                    readOnly: true, initialValue: member.pfNo ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(memberName: v)),
                const SizedBox(height: 16),
                buildDatePicker("Date of Birth", dod),
                const SizedBox(height: 16),
                buildRadioGroup("Gender", controller.selectedGender, ["Male", "Female"]),
                const SizedBox(height: 16),
                buildRadioGroup("Marital Status", controller.selectedMaritalStatus, ["Single","Married", "Unmarried"]),
                const SizedBox(height: 16),
                buildDropdown<RaceDetail>(label: "Race", selectedValue: controller.selectedRaceDetail, items: controller.raceDetails, display: (r) => r.raceName ?? '', onChanged: (r) => controller.selectedRaceDetail.value = r),
              ]),
              buildSection("Contact Info", [
                CommonTextInput(label: "Hand Phone", initialValue: member.telephoneNoHp ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(telephoneNoHp: v)),
                const SizedBox(height: 16),
                CommonTextInput(label: "Home Phone", initialValue: member.telephoneNo ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(telephoneNo: v)),
                const SizedBox(height: 16),
                CommonTextInput(label: "Office Phone", initialValue: member.telephoneNoOffice ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(telephoneNoOffice: v)),
                const SizedBox(height: 16),
                CommonTextInput(label: "Email", initialValue: member.emailId ?? "", readOnly: true),
                const SizedBox(height: 16),
                CommonTextInput(label: "Office Email", initialValue: member.officeEmail ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(officeEmail: v)),
                const SizedBox(height: 16),
                CommonTextInput(label: "Home Address", initialValue: "${member.address ?? ''} ${member.addressTwo ?? ''} ${member.addressThree ?? ''}", maxLines: 2, onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(address: v)),
                const SizedBox(height: 16),
                CommonTextInput(label: "Office Address", initialValue: "${member.officeAddress ?? ''} ${member.officeAddresstwo ?? ''} ${member.officeAddressthree ?? ''}", maxLines: 2, onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(officeAddress: v)),
              ]),
              buildSection("Work Info", [
                buildDropdown<DesignationDetail>(label: "Designation", selectedValue: controller.selectedDesignationDetail, items: controller.designationDetails, display: (d) => d.designationName ?? '', onChanged: (d) => controller.selectedDesignationDetail.value = d),
                const SizedBox(height: 16),
                buildDropdown<DepartmentDetail>(label: "Department", selectedValue: controller.selectedDepartmentDetail, items: controller.departmentDetails, display: (d) => d.departmentName ?? '', onChanged: (d) => controller.selectedDepartmentDetail.value = d),
                const SizedBox(height: 16),
                buildDropdown<StateDetail>(label: "State", selectedValue: controller.selectedStateDetail, items: controller.statedetailsModel, display: (s) => s.stateName ?? '', onChanged: (s) { controller.selectedStateDetail.value = s; controller.fetchCities(); }),
                const SizedBox(height: 16),
                buildDropdown<CityDetail>(label: "City", selectedValue: controller.selectedCityDetail, items: controller.cityDetailsModel, display: (c) => c.cityName ?? '', onChanged: (c) => controller.selectedCityDetail.value = c),
                const SizedBox(height: 16),
                CommonTextInput(label: "Cost Center", initialValue: member.costcenter ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(costcenter: v)),
                const SizedBox(height: 16),
                // CommonTextInput(label: "Monthly Fee", initialValue: member.monthlyFee ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(monthlyFee: v)),
                // const SizedBox(height: 16),
                // CommonTextInput(label: "Welfare Fund", initialValue: member.welfareFund ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(welfareFund: v)),
              ]),
              buildSection("Important Dates", [
                buildDatePicker("Date Joined Maybank", doj,readOnly: true),
                const SizedBox(height: 16),
                buildDatePicker("Date Joined AMCO", amcoDoj,readOnly: true),
                const SizedBox(height: 16),
                buildDatePicker("Date Promoted", promotedDate,readOnly: true),
                const SizedBox(height: 16),
                buildDatePicker("Date Approved", approvedDate,readOnly: true),
              ]),
              buildSection("References", [
                CommonTextInput(label: "Proposed By",readOnly: true, initialValue: member.proposedName ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(proposedName: v)),
                const SizedBox(height: 16),
                CommonTextInput(label: "Seconded By",readOnly: true, initialValue: member.secondedName ?? "", onSaved: (v) => controller.profile?.data?.memberDetails?[0] = member.copyWith(secondedName: v)),
                const SizedBox(height: 16),
                CommonTextInput(
                  label: "Decision On this application made at EXCO Meeting help..",
                  readOnly: true,
                  initialValue: (member.alreadyMember == "0")
                      ? "No"
                      : (member.alreadyMember == "1" ? "Yes" : ""),
                  onSaved: (v) {
                    controller.profile?.data?.memberDetails?[0] =
                        member.copyWith(secondedName: v);
                  },
                ),

              ]),
              const SizedBox(height: 16),
              CommonButton(
                text: "Update Profile",
                onPressed: () async {
                  // print("${ controller.profile!.data!.memberDetails!.first}");

                  final member = profileCtrl.profileData.value?.data?.memberDetails?.first;
                  if (member!= null){

                    final data = {
                    "member_id": member.id.toString(),
                    "sex": controller.selectedGender.value,
                    "marital_status": controller.selectedMaritalStatus.value,
                    "race": controller.selectedRaceDetail.value?.id.toString() ?? "",
                   "designation": controller.selectedDesignationDetail.value?.id.toString() ?? "",
                    "department": controller.selectedDepartmentDetail.value?.id.toString() ?? "",
                    "dob": member.dob?.toIso8601String() ?? "",
                    "address": member.address ?? "",
                    "address_two": member.addressTwo ?? "",
                    "address_three": member.addressThree ?? "",
                    "postal_code": member.postalCode ?? "",
                    "email_id": member.emailId ?? "",
                    "office_email": member.officeEmail ?? "",
                    "telephone_no": member.telephoneNo ?? "",
                    "telephone_no_hp": member.telephoneNoHp ?? "",
                    "telephone_no_office": member.telephoneNoOffice ?? "",
                    "office_address": member.officeAddress ?? "",
                    "office_addresstwo": member.officeAddresstwo ?? "",
                    "office_addressthree": member.officeAddressthree ?? "",
                    "office_cityid": controller.selectedCityDetail.value?.id.toString() ?? "",
                    "office_stateid": controller.selectedStateDetail.value?.stateId.toString() ?? "",
                    "officepostal_code":  member.officepostalCode ?? "",
                    "office_countryid": "130",
                    "country_id": "130",
                      "employee_no":member.emailId?? "",
                      "app_status":"",
                    "state_id": controller.selectedStateDetail.value?.stateId.toString() ?? "",
                    "city_id": controller.selectedCityDetail.value?.id.toString() ?? "",

                  };
                    print(jsonEncode(data));
                    await controller.submitProfileUpdate(data);
                    Navigator.pop(context);
                  }
                else{
                  print("no data");
                  }




                },
              ),


            ],
          ),
        );
      }),
    );
  }
}
