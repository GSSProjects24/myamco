import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:myamco/App/config/app_colors.dart';
import 'package:myamco/App/config/app_images.dart';
import 'package:myamco/App/routes/app_routes.dart';

import 'profile_Repository.dart';
import 'profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.put(ProfileController(repository: ProfileRepository()));
  String formatDate(DateTime? date) {
    return date != null ? DateFormat('dd-MM-yyyy').format(date) : 'N/A';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Profile Details',
          style: TextStyle(color: Colors.white),
        ),
          leading:
               IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed:  () => Navigator.pop(context),
          ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () => Get.toNamed(AppRoutes.EditProfilePage),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.profileData.value != null) {
          final member = controller.profileData.value!.data!.memberDetails!.first;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header Card
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          backgroundImage: AssetImage(AppImages.logo),
                        ),

                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            member.memberName ?? 'N/A',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Info Card
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                       // ProfileField(label: "Member ID", value: member.id.toString()),
                       // ProfileField(label: "Member Name", value: member.memberName ?? 'N/A'),
                        ProfileField(label: "PF Number", value: member.pfNo ?? 'N/A'),
                        ProfileField(label: "IC Number (New)", value: member.icNoNew ?? 'N/A'),
                        //ProfileField(label: "IC Number (Old)", value: member.icNoOld ?? 'N/A'),
                        ProfileField(
                          label: "Date of Birth",
                          value: member.dob != null
                              ? DateFormat('dd-MM-yyyy').format(member.dob!)
                              : 'N/A',
                        ),
                        ProfileField(label: "Race", value: member.raceName ?? 'N/A'),
                        ProfileField(label: "Member No", value: member.memberNo ?? 'N/A'),

                        ProfileField(label: "Gender", value: member.sex ?? 'N/A'),
                        ProfileField(label: "Marital Status", value: member.maritalStatus ?? 'N/A'),
                        ProfileField(label: "Date Joined Maybank", value: formatDate(member.doj)),
                        ProfileField(label: "Date Joined AMCO", value: formatDate(member.amcoDoj)),
                        ProfileField(label: "Date Promoted to Scope of AMCO", value: formatDate(member.promotedDate)),  ProfileField(label: "Designation ", value: member.designationName .toString()?? 'N/A'),
                        ProfileField(label: "Department", value: member.departmentName ?? 'N/A'),
                        ProfileField(label: "Hand Phone Number", value: member.telephoneNoHp ?? 'N/A'),
                        ProfileField(label: "Home Telephone Number", value: member.telephoneNo ?? 'N/A'),
                        ProfileField(label: "Office Telephone Number", value: member.telephoneNoOffice ?? 'N/A'),
                        ProfileField(label: "Home Address", value: "${member.address ?? ''} ${member.addressTwo ?? ''} ${member.addressThree ?? ''}"),
                        ProfileField(label: "State", value: member.stateName ?? 'N/A'),
                        ProfileField(label: "City", value: member.cityName ?? 'N/A'),
                        ProfileField(label: "Postal Code", value: member.postalCode ?? 'N/A'),
                        ProfileField(label: "Office Address", value: "${member.officeAddress ?? ''} ${member.officeAddresstwo ?? ''} ${member.officeAddressthree ?? ''}"),
                        ProfileField(label: "Office Postal Code", value: member.officepostalCode ?? 'N/A'),
                        //ProfileField(label: "Office Country", value: member.offcountryName ?? 'N/A'),
                        ProfileField(label: "Office State", value: member.offstateName ?? 'N/A'),
                        ProfileField(label: "Office City", value: member.offcityName ?? 'N/A'),
                        ProfileField(label: "Postal Code (Office) ", value: member.officepostalCode ?? 'N/A'),
                        ProfileField(label: "Personal Email Address", value: member.emailId ?? 'N/A'),
                        ProfileField(label: "Office Email Address", value: member.officeEmail ?? 'N/A'),
                        ProfileField(label: "Proposed By", value: member.proposedName ?? 'N/A'),
                        ProfileField(label: "Seconded By", value: member.secondedName ?? 'N/A'),
                        // ProfileField(label: "Seconded By", value: member.Decision ?? 'N/A'),
                        ProfileField(
                          label: "Date Approved",
                          value: member.approvedDate != null
                              ? DateFormat('dd-MM-yyyy').format(member.approvedDate!)
                              : 'N/A',
                        ),
                        ProfileField(label: "Cost Center", value: member.costcenter ?? 'N/A'),
                        ProfileField(label: "Monthly Fee", value: member.monthlyFee ?? 'N/A'),
                        ProfileField(label: "Welfare Fund", value: member.welfareFund ?? 'N/A'),
                        // ProfileField(label: "Bank Name", value: member.bankName ?? 'N/A'),
                        // ProfileField(label: "Country", value: member.countryName ?? 'N/A'),
                        //
                        //

                        // ProfileField(label: "Position", value: member.position ?? 'N/A'),
                        //
                        // ProfileField(label: "Employee No", value: member.employeeNo ?? 'N/A'),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text("No data found"));
        }
      }),
    );
  }
}

class ProfileField extends StatelessWidget {

  final String label;
  final String value;

  const ProfileField({
    super.key,

    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
