import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/Model/fill_pickUp_response_modal.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/controllers/text_controllers.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/capture_image_video.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/custom_textfield.dart';
import 'package:passbook_core_jayant/Util/image_picker_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/StaticValue.dart';
import '../Util/custom_drop_down.dart';
import 'Model/proprietor_modal.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  late UserBloc userBloc;
  final cntlrs = Textcntlrs();
  @override
  void initState() {
    super.initState();
    userBloc = UserBloc.get(context);

    SharedPreferences pref = StaticValues.sharedPreferences!;
    String cmpCode = pref.getString(StaticValues.cmpCodeKey) ?? "";

    warningPrint("CmpCode $cmpCode");
    userBloc.add(
      FillPickUpTypesEvent(cmpCode: int.parse(cmpCode), pickUpType: 6),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    // final userBloc = UserBloc.get(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("New User", style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(15),
          children: [
            Text(
              "Basic Details",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: w * 0.042,
              ),
            ),
            SizedBox(height: h * 0.03),
            LabelWithDropDownField(
              textDropDownLabel: "Branch",
              items: ["A", "B"],
              onChanged: (value) {
                cntlrs.selectedBranch = value;
              },
            ),

            BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {},
              buildWhen:
                  (previous, current) =>
                      previous.isPickupCustomerTypeLoading !=
                      current.isPickupCustomerTypeLoading,
              listenWhen:
                  (previous, current) =>
                      previous.isPickupCustomerTypeLoading !=
                      current.isPickupCustomerTypeLoading,

              builder: (context, state) {
                warningPrint("state in customer type =$state");
                if (state.isPickupCustomerTypeLoading) {
                  return SizedBox(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  final customerTypeList = state.pickUpCustomerTypeList;
                  alertPrint("customer Type List =$customerTypeList");
                  return LabelWithDropDownField<PickUpTypeResponseModal>(
                    textDropDownLabel: "Customer Type",
                    hintText:
                        cntlrs.selectedCustomerType.isEmpty
                            ? "Select Customer Type"
                            : cntlrs.selectedCustomerType,
                    items: customerTypeList,

                    itemAsString: (item) => item.pkcDescription,
                    onChanged: (value) {
                      cntlrs.selectedCustomerType = value.pkcDescription;
                      successPrint("Selected customer type : $value");
                      userBloc.add(selectCustomerTypeEvent(value.pkcCode));
                    },
                  );
                }
              },
            ),
            SizedBox(height: h * 0.02),
            BlocBuilder<UserBloc, UserState>(
              buildWhen:
                  (previous, current) =>
                      previous.selectedCustomerTypeCode !=
                      current.selectedCustomerTypeCode,

              builder: (context, state) {
                return CustomRaisedButton(
                  buttonText: "Continue",
                  onPressed: () {
                    customPrint(
                      "selected customer Type =${cntlrs.selectedCustomerType}",
                    );
                    if (cntlrs.selectedBranch.isEmpty &&
                        cntlrs.selectedCustomerType.isEmpty) {
                      GlobalWidgets().showSnackBar(
                        context,
                        "Select Branch & Customer Type",
                      );
                    } else if (cntlrs.selectedBranch.isEmpty) {
                      GlobalWidgets().showSnackBar(context, "Select Branch");
                    } else if (cntlrs.selectedCustomerType.isEmpty) {
                      GlobalWidgets().showSnackBar(
                        context,
                        "Select Customer Type",
                      );
                    } else {
                      if (cntlrs.selectedCustomerType == "INDIVIDUAL") {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserIndividualCreation(),
                          ),
                        );
                      }
                      if (cntlrs.selectedCustomerType == "INSTITUTION") {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserInstitutionCreation(),
                          ),
                        );
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

///Individual Page
class UserIndividualCreation extends StatefulWidget {
  const UserIndividualCreation({super.key});

  @override
  State<UserIndividualCreation> createState() => _UserIndividualCreationState();
}

class _UserIndividualCreationState extends State<UserIndividualCreation> {
  String? cmpCode;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userBloc = UserBloc.get(context);
      SharedPreferences pref = StaticValues.sharedPreferences!;
      String cmpCode = pref.getString(StaticValues.cmpCodeKey) ?? "";
      alertPrint("CmpCode $cmpCode");

      userBloc.add(
        FillPickUpTypesEvent(cmpCode: int.parse(cmpCode), pickUpType: 5),
      );
      userBloc.add(
        FillPickUpTypesEvent(cmpCode: int.parse(cmpCode), pickUpType: 8),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final userBloc = UserBloc.get(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelWithDropDownField(
              textDropDownLabel: "Title",
              items: [],
              // itemAsString: (e) => e.pkcDescription,
            ),
            LabelCustomTextField(
              hintText: "First Name",
              textFieldLabel: "Customer First Name",
            ),
            LabelCustomTextField(
              hintText: "Middle Name",
              textFieldLabel: "Customer Middle Name",
            ),
            LabelCustomTextField(
              hintText: "Last Name",
              textFieldLabel: "Customer Last Name",
            ),
            LabelCustomTextField(
              hintText: "Father Name",
              textFieldLabel: "Father Name",
            ),
            LabelCustomTextField(
              hintText: "Mother Name",
              textFieldLabel: "Mother Name",
            ),
            LabelCustomTextField(
              hintText: "Spouse Name",
              textFieldLabel: "Spouse Name",
            ),
            LabelCustomTextField(
              hintText: "Guardian",
              textFieldLabel: "Guardian",
            ),
            LabelCustomTextField(hintText: "DOB", textFieldLabel: "DOB"),
            LabelWithDropDownField(
              textDropDownLabel: "Gender",
              items: [],
              onChanged: (value) {},
            ),
            LabelCustomTextField(
              hintText: "Mobile Number",
              textFieldLabel: "Primary Mobile Number",
            ),
            LabelCustomTextField(
              hintText: "Mobile Number",
              textFieldLabel: "Secondary Mobile Number",
            ),
            LabelCustomTextField(
              hintText: "Primary Email",
              textFieldLabel: "Primary Email",
            ),
            LabelCustomTextField(
              hintText: "Aadhar Number",
              textFieldLabel: "Aadhar Number",
            ),
            LabelCustomTextField(
              hintText: "PAN Number",
              textFieldLabel: "PAN Number",
            ),
            LabelCustomTextField(
              hintText: "Qualification",
              textFieldLabel: "Qualification",
            ),
            LabelCustomTextField(
              hintText: "CKYC Number",
              textFieldLabel: "CKYC Number",
            ),
            SizedBox(height: h * 0.03),

            _sectionTitle("Permanent Address", w),
            LabelCustomTextField(
              hintText: "House No & Name",
              textFieldLabel: "House No & Name",
            ),
            LabelCustomTextField(
              hintText: "Address 1",
              textFieldLabel: "Address 1",
            ),
            LabelCustomTextField(
              hintText: "Address 2",
              textFieldLabel: "Address 2",
            ),
            LabelCustomTextField(
              hintText: "City/Town/Village",
              textFieldLabel: "City/Town/Village",
            ),
            LabelCustomTextField(
              hintText: "Post Office/ Pincode",
              textFieldLabel: "Post Office/ Pincode",
            ),
            LabelCustomTextField(
              hintText: "Country",
              textFieldLabel: "Country",
            ),
            LabelCustomTextField(hintText: "State", textFieldLabel: "State"),
            LabelCustomTextField(
              hintText: "District",
              textFieldLabel: "District",
            ),
            LabelWithDropDownField(
              textDropDownLabel: "Communication Address",
              items: ["Yes", "No"],
            ),

            SizedBox(height: h * 0.03),
            _sectionTitle("Present Address", w),
            LabelCustomTextField(
              hintText: "House No & Name",
              textFieldLabel: "House No & Name",
            ),
            LabelCustomTextField(
              hintText: "Address 1",
              textFieldLabel: "Address 1",
            ),
            LabelCustomTextField(
              hintText: "Address 2",
              textFieldLabel: "Address 2",
            ),
            LabelCustomTextField(
              hintText: "City/Town/Village",
              textFieldLabel: "City/Town/Village",
            ),
            LabelCustomTextField(
              hintText: "Post Office/ Pincode",
              textFieldLabel: "Post Office/ Pincode",
            ),
            LabelCustomTextField(
              hintText: "Country",
              textFieldLabel: "Country",
            ),
            LabelCustomTextField(hintText: "State", textFieldLabel: "State"),
            LabelCustomTextField(
              hintText: "District",
              textFieldLabel: "District",
            ),
            LabelWithDropDownField(
              textDropDownLabel: "Communication Address",
              items: ["Yes", "No"],
            ),

            SizedBox(height: h * 0.05),
            _sectionTitle("Document Details", w),

            SizedBox(height: h * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///Customer Image
                ImageWidget(
                  text: "Customer Image",
                  // imageFile: userBloc.individualCustomerImageFile,
                  onTap: () async {},
                ),

                ///Signature Image
                ImageWidget(
                  text: "Customer Signature",
                  // imageFile: userBloc.individualCustomerSignatureFile,
                  onTap: () async {},
                ),
              ],
            ),

            SizedBox(height: h * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///Id Proof
                ImageWidget(
                  text: "Id Proof",
                  // imageFile: userBloc.individualIdProofFile,
                  onTap: () async {},
                ),

                ///Customer Bank Details
                ImageWidget(
                  text: "Customer Bank details",
                  // imageFile: userBloc.individualBankDetailsFile,
                  onTap: () async {},
                ),
              ],
            ),

            SizedBox(height: h * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///Selfie
                ImageWidget(
                  text: "Selfie",
                  // imageFile: userBloc.individualSelfieFile,
                  onTap: () async {},
                ),

                ///Video Recording
                ImageWidget(
                  text: "Video Recording",
                  // imageFile: userBloc.individualVideoRecordingFile,
                  isVideo: true,
                  onTap: () async {},
                ),
              ],
            ),

            SizedBox(height: h * 0.03),
            Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, double w) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: w * 0.042,
      ),
    );
  }
}

///Institution Page
class UserInstitutionCreation extends StatefulWidget {
  const UserInstitutionCreation({super.key});

  @override
  State<UserInstitutionCreation> createState() =>
      _UserInstitutionCreationState();
}

class _UserInstitutionCreationState extends State<UserInstitutionCreation> {
  final cntlrs = Textcntlrs();
  final captureService = CaptureService();
  List<int> proprietorIndexes = [0];
  List<ProprietorModel> proprietors = [ProprietorModel()];

  Widget buildProprietorSection(int index) {
    final modal = proprietors[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Proprietor Details $index",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        LabelCustomTextField(
          hintText: "Name",
          textFieldLabel: "Name",
          onchanged: (val) => modal.name = val,
        ),
        LabelCustomTextField(
          hintText: "DOB",
          textFieldLabel: "DOB",
          onchanged: (val) => modal.dob = val,
        ),
        LabelCustomTextField(
          hintText: "Father Name",
          textFieldLabel: "Father Name",
          onchanged: (val) => modal.fatherName = val,
        ),
        LabelCustomTextField(
          hintText: "Mother Maiden Name",
          textFieldLabel: "Mother Maiden Name",
          onchanged: (val) => modal.motherName = val,
        ),
        LabelCustomTextField(
          hintText: "Mobile No",
          textFieldLabel: "Mobile No",
          onchanged: (val) => modal.mobile = val,
        ),
        LabelCustomTextField(
          hintText: "Email ID",
          textFieldLabel: "Email ID",
          onchanged: (val) => modal.email = val,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Institution Creation",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Firms Details",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: w * 0.042,
              ),
            ),
            SizedBox(height: h * 0.02),
            LabelCustomTextField(
              hintText: "Firm Name",
              textFieldLabel: "Firm Name",
            ),
            LabelCustomTextField(
              hintText: "Firm Reg No",
              textFieldLabel: "Firm Reg No",
            ),
            LabelCustomTextField(
              hintText: "Firm Registered Address",
              textFieldLabel: "Firm Registered Address",
              lines: 3,
            ),
            const Text("Document Attached"),
            SizedBox(height: h * 0.01),
            Container(
              height: h * 0.07,
              width: w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.3),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            LabelCustomTextField(
              hintText: "Product Details",
              textFieldLabel: "Product Details",
            ),
            LabelCustomTextField(
              hintText: "Turn Over",
              textFieldLabel: "Turn Over",
            ),
            SizedBox(height: h * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Proprietor Details",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: w * 0.042,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: () {
                    setState(() {
                      proprietorIndexes.add(proprietorIndexes.length);
                      proprietors.add(ProprietorModel());
                    });
                  },
                ),
              ],
            ),
            ...proprietorIndexes.map((index) => buildProprietorSection(index)),

            LabelWithDropDownField(
              textDropDownLabel: "Gender",
              items: ["MALE", "FEMALE"],
            ),
            LabelWithDropDownField(
              textDropDownLabel: "Nationality",
              items: ["A", "B"],
            ),
            LabelCustomTextField(
              hintText: "Qualification",
              textFieldLabel: "Qualification",
            ),
            LabelCustomTextField(
              hintText: "Profession",
              textFieldLabel: "Profession",
            ),
            LabelCustomTextField(
              hintText: "PAN CARD No",
              textFieldLabel: "PAN CARD No",
            ),
            LabelCustomTextField(
              hintText: "Aadhar CARD No",
              textFieldLabel: "Aadhar CARD No",
            ),
            LabelCustomTextField(
              lines: 3,
              hintText: "Permanent Address",
              textFieldLabel: "Permanent Address",
            ),
            LabelCustomTextField(
              lines: 3,
              hintText: "Current/ Communication Address",
              textFieldLabel: "Curent/ Communication Address",
            ),
            const SizedBox(height: 30),
            const Text("Nomination"),
            const SizedBox(height: 20),
            CheckboxListTile(
              value: true,
              onChanged: (_) {},
              title: const Text("Accept Terms & Conditions"),
            ),
          ],
        ),
      ),
    );
  }
}
