import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/capture_image_video.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/custom_textfield.dart';
import 'package:passbook_core_jayant/Util/image_picker_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/StaticValue.dart';
import '../Util/custom_drop_down.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SharedPreferences pref = StaticValues.sharedPreferences!;
      String cmpCode = pref.getString(StaticValues.cmpCodeKey) ?? "";
      final userBloc = UserBloc.get(context);
      warningPrint("CmpCode $cmpCode");
      userBloc.add(
        FillPickUpTypesEvent(cmpCode: int.parse(cmpCode), pickUpType: 6),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final userBloc = UserBloc.get(context);
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
            ),

            BlocBuilder<UserBloc, UserState>(
              buildWhen: (previous, current) {
                return current is PickUpCustomerTypeLoading ||
                    current is PickUpCustomerTypeResponse ||
                    current is PickUpCustomerTypeError;
              },
              builder: (context, state) {
                warningPrint("state in customer type =${state}");
                if (state is PickUpCustomerTypeLoading) {
                  return SizedBox(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is PickUpCustomerTypeResponse) {
                  final customerTypeList = state.pickUpCustomerTypeList;
                  alertPrint("customer Type List =${customerTypeList}");
                  return LabelWithDropDownField(
                    textDropDownLabel: "Customer Type",
                    items: customerTypeList,
                    // itemAsString: (item) => item.pkcDescription,
                    onChanged: (value) {
                      if (value != null) {
                        userBloc.add(SelectPickUpTypeEvent(value));
                        successPrint("Selected: ${value}");
                      }
                    },
                  );
                } else {
                  return Text('Something Went Wrong');
                }
              },
            ),

            BlocBuilder<UserBloc, UserState>(
              buildWhen:
                  (previous, current) =>
                      current is UserSelectedCustomerTypeLoading ||
                      current is UserSelectedCustomerType,
              builder: (context, state) {
                return Column(
                  children: [
                    if (state is UserSelectedCustomerType) ...[
                      if (state.selectedCustomerTypeCode == 46)
                        UserIndividualCreation(),
                      if (state.selectedCustomerTypeCode == 11473)
                        UserInstitutionCreation(),
                    ],
                  ],
                );
              },
            ),

            CustomRaisedButton(buttonText: "Submit", onPressed: () {}),
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
            BlocBuilder<UserBloc, UserState>(
              buildWhen:
                  (previous, current) =>
                      current is PickUpTitleTypeLoading ||
                      current is PickUpTitleTypeResponse ||
                      current is PickUpTitleTypeError,
              // listener: (context, state) {
              //   if (state is PickUpTitleTypeError) {
              //     GlobalWidgets().showSnackBar(context, "${state.error}");
              //   }
              // },
              builder: (context, state) {
                if (state is PickUpTitleTypeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PickUpTitleTypeResponse) {
                  return LabelWithDropDownField(
                    textDropDownLabel: "Title",
                    items: state.pickUpTitleTypeList,
                    itemAsString: (e) => e.pkcDescription,
                    onChanged: (val) {
                      if (val != null) {
                        userBloc.individualTitle = val.pkcDescription;
                        successPrint(
                          "Title Value Selected ${userBloc.individualTitle}",
                        );
                        successPrint("Title Value Selected ${val}");
                      }
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
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
            BlocBuilder<UserBloc, UserState>(
              buildWhen:
                  (previous, current) =>
                      current is PickUpGenderTypeLoading ||
                      current is PickUpGenderTypeResponse ||
                      current is PickUpGenderTypeError,

              builder: (context, state) {
                if (state is PickUpGenderTypeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PickUpGenderTypeResponse) {
                  final genderList = state.pickUpGenderTypeList;
                  return LabelWithDropDownField(
                    textDropDownLabel: "Gender",
                    items: genderList,
                    onChanged: (value) {
                      if (value != null) {
                        userBloc.individualGender = value.pkcDescription;
                        successPrint(
                          "Gender Value Selected ${userBloc.individualGender}",
                        );
                      }
                    },
                  );
                } else
                  return SizedBox.shrink();
              },
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
                  imageFile: userBloc.individualCustomerImageFile,
                  onTap: () async {
                    final file = await CaptureService().captureImage();
                    if (file != null) {
                      final base64 = await ImageUtils.compressXFileToBase64(
                        file,
                      );
                      setState(() {
                        userBloc.individualCustomerImageFile = file;
                        userBloc.individualCustomerImageFileBase64 = base64;
                        userBloc.individualCustomerImageFile = File(file.path);
                        userBloc.individualCustomerImageFileBase64 = base64;
                      });
                      successPrint(
                        "Individual Capture Image ${userBloc.individualCustomerImageFileBase64}",
                      );
                    }
                  },
                ),

                ///Signature Image
                ImageWidget(
                  text: "Customer Signature",
                  imageFile: userBloc.individualCustomerSignatureFile,
                  onTap: () async {
                    final file = await CaptureService().captureImage();
                    if (file != null) {
                      final base64 = await ImageUtils.compressXFileToBase64(
                        file,
                      );
                      setState(() {
                        userBloc.individualCustomerSignatureFile = file;
                        userBloc.individualCustomerSignatureFileBase64 = base64;
                        // Convert File to XFile here
                        userBloc.individualCustomerSignatureFile = File(
                          file.path,
                        );
                        userBloc.individualCustomerSignatureFileBase64 = base64;
                      });
                      successPrint(
                        "Individual Customer signature ${userBloc.individualCustomerSignatureFileBase64}",
                      );
                    }
                  },
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
                  imageFile: userBloc.individualIdProofFile,
                  onTap: () async {
                    final file = await CaptureService().captureImage();
                    if (file != null) {
                      final base64 = await ImageUtils.compressXFileToBase64(
                        file,
                      );
                      setState(() {
                        userBloc.individualIdProofFile = file;
                        userBloc.individualIdProofFileBase64 = base64;

                        userBloc.individualIdProofFile = File(file.path);
                        userBloc.individualIdProofFileBase64 = base64;
                      });
                      successPrint(
                        "Individual Selfie Image ${userBloc.individualIdProofFileBase64}",
                      );
                    }
                  },
                ),

                ///Customer Bank Details
                ImageWidget(
                  text: "Customer Bank details",
                  imageFile: userBloc.individualBankDetailsFile,
                  onTap: () async {
                    final file = await CaptureService().captureImage();
                    if (file != null) {
                      final base64 = await ImageUtils.compressXFileToBase64(
                        file,
                      );
                      setState(() {
                        userBloc.individualBankDetailsFile = file;
                        userBloc.individualBankDetailsFileBase64 = base64;
                        userBloc.individualBankDetailsFile = File(file.path);
                      });
                      userBloc.individualBankDetailsFileBase64 = base64;
                      successPrint(
                        "Individual Bank Image ${userBloc.individualBankDetailsFileBase64}",
                      );
                    }
                  },
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
                  imageFile: userBloc.individualSelfieFile,
                  onTap: () async {
                    final file = await CaptureService().captureImage();
                    if (file != null) {
                      final base64 = await ImageUtils.compressXFileToBase64(
                        file,
                      );
                      setState(() {
                        userBloc.individualSelfieFile = file;
                        userBloc.individualSelfieFileBase64 = base64;
                        userBloc.individualSelfieFile = File(file.path);
                      });
                      userBloc.individualSelfieFileBase64 = base64;
                      successPrint(
                        "Individual Selfie Image ${userBloc.individualSelfieFileBase64}",
                      );
                    }
                  },
                ),

                ///Video Recording
                ImageWidget(
                  text: "Video Recording",
                  imageFile: userBloc.individualVideoRecordingFile,
                  isVideo: true,
                  onTap: () async {
                    final video = await CaptureService().captureVideo();
                    if (video != null) {
                      final bytes = await video.readAsBytes();
                      final base64 = base64Encode(bytes);
                      setState(() {
                        userBloc.individualVideoRecordingFile = File(
                          video.path,
                        );
                        userBloc.individualVideoRecordingFileBase64 = base64;
                      });
                      successPrint("Blinking Video ${base64}");
                      successPrint(
                        "Blinking Video ${userBloc.individualVideoRecordingFileBase64}",
                      );
                    } else {
                      warningPrint("Video recording cancelled or failed.");
                    }
                  },
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
  UserInstitutionCreation({super.key});

  @override
  State<UserInstitutionCreation> createState() =>
      _UserInstitutionCreationState();
}

class _UserInstitutionCreationState extends State<UserInstitutionCreation> {
  final captureService = CaptureService();
  List<int> proprietorIndexes = [1];
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final userBloc = UserBloc.get(context);

    Widget buildProprietorSection(int index) {
      alertPrint("Index added $index");
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
          SizedBox(height: 8),
          LabelCustomTextField(hintText: "Name", textFieldLabel: "Name"),
          LabelCustomTextField(hintText: "DOB", textFieldLabel: "DOB"),
          LabelCustomTextField(
            hintText: "Father Name",
            textFieldLabel: "Father Name",
          ),
          LabelCustomTextField(
            hintText: "Mother Maiden Name",
            textFieldLabel: "Mother Maiden Name",
          ),
          LabelCustomTextField(
            hintText: "Mobile No",
            textFieldLabel: "Mobile No",
          ),
          LabelCustomTextField(
            hintText: "Email ID",
            textFieldLabel: "Email ID",
          ),
          SizedBox(height: 16),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: h * 0.03),
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
        Text("Document Attached"),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: Colors.blueAccent),
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
              icon: Icon(Icons.add_circle),
              onPressed: () {
                setState(() {
                  proprietorIndexes.add(proprietorIndexes.length + 1);
                });
              },
            ),
          ],
        ),

        /// All Proprietor Sections
        ...proprietorIndexes
            .map((index) => buildProprietorSection(index))
            .toList(),

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
        //fetch the geo location
        SizedBox(height: h * 0.03),
        Text(
          "Nomination",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: w * 0.042,
          ),
        ),
        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageWidget(
              text: "Selfie",
              imageFile: userBloc.institutionSelfieFile,
              onTap: () async {
                final file = await captureService.captureImage();
                if (file != null) {
                  final base64 = await ImageUtils.compressXFileToBase64(file);
                  setState(() {
                    userBloc.institutionSelfieFile = file;
                    userBloc.institutionSelfieBase64 = base64;

                    userBloc.institutionSelfieFile = File(file.path);
                    userBloc.institutionSelfieBase64 = base64;
                  });

                  successPrint(
                    "Individual Capture Image ${userBloc.individualCustomerImageFileBase64}",
                  );
                }
              },
            ),
            ImageWidget(
              text: "Blinking Eyes",
              isVideo: true,
              imageFile: userBloc.institutionBlinkEyeVideoFile,
              onTap: () async {
                final video = await captureService.captureVideo();
                if (video != null) {
                  final bytes = await video.readAsBytes();
                  final base64 = base64Encode(bytes);
                  setState(() {
                    userBloc.institutionBlinkEyeVideoFile = File(video.path);
                    userBloc.institutionBlinkEyeVideoBase64 = base64;
                  });
                  successPrint("Blinking Video ${base64}");
                  successPrint(
                    "Blinking Video ${userBloc.institutionBlinkEyeVideoBase64}",
                  );
                } else {
                  warningPrint("Video recording cancelled or failed.");
                }
              },
            ),
          ],
        ),

        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageWidget(
              text: "Signature",
              imageFile: userBloc.institutionSignatureFile,
              onTap: () async {
                final file = await captureService.captureImage();
                if (file != null) {
                  final base64 = await ImageUtils.compressXFileToBase64(file);
                  setState(() {
                    userBloc.institutionSignatureFile = file;
                    userBloc.institutionSignatureBase64 = base64;
                    userBloc.institutionSignatureFile = File(file.path);
                  });
                  userBloc.institutionSignatureBase64 = base64;
                  successPrint(
                    "Individual Selfie Image ${userBloc.institutionSignatureBase64}",
                  );
                }
              },
            ),
          ],
        ),
        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageWidget(
              text: "Selfie",
              imageFile: userBloc.institutionSelfieFile,
              onTap: () async {
                final file = await captureService.captureImage();
                if (file != null) {
                  final base64 = await ImageUtils.compressXFileToBase64(file);
                  setState(() {
                    userBloc.institutionSelfieFile = file;
                    userBloc.institutionSelfieBase64 = base64;
                    userBloc.institutionSelfieFile = File(file.path);
                  });
                  userBloc.institutionSelfieBase64 = base64;
                  successPrint(
                    "Individual Selfie Image ${userBloc.institutionSelfieBase64}",
                  );
                }
              },
            ),
            ImageWidget(
              text: "Video Recording",
              isVideo: true,
              imageFile: userBloc.institutionTalkingVideoFile,
              onTap: () async {
                final video = await captureService.captureVideo();
                if (video != null) {
                  final bytes = await video.readAsBytes();
                  final base64 = base64Encode(bytes);
                  setState(() {
                    userBloc.institutionTalkingVideoFile = File(video.path);
                    userBloc.institutionTalkingVideoBase64 = base64;
                  });
                  successPrint("Blinking Video ${base64}");
                  successPrint(
                    "Blinking Video ${userBloc.institutionTalkingVideoBase64}",
                  );
                } else {
                  warningPrint("Video recording cancelled or failed.");
                }
              },
            ),
          ],
        ),

        SizedBox(height: h * 0.05),
        LabelCustomTextField(
          hintText: "Aadhar Card OTP",
          textFieldLabel: "Aadhar Card OTP Verification",
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
    );
  }
}
