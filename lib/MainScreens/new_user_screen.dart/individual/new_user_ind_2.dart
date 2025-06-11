import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/controllers/text_controllers.dart';
import 'package:passbook_core_jayant/MainScreens/new_user_screen.dart/individual/new_user_ind_3.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/custom_drop_down.dart';
import 'package:passbook_core_jayant/Util/custom_textfield.dart';

class UserIndividualCreation2 extends StatelessWidget {
  UserIndividualCreation2({super.key});
  final cntlrs = Textcntlrs();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "New User Individual",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(w * 0.03),
          children: [
            _sectionTitle("permanent Address", w),
            LabelCustomTextField(
              hintText: "Permanent House No & Name",
              textFieldLabel: "House No & Name",
              controller: cntlrs.permanentAddressHouseNoNameCntlr,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Permanent Address 1",
              textFieldLabel: "Address 1",
              lines: 2,
              controller: cntlrs.permanentAddress1Cntrl,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Permanent Address 2",
              textFieldLabel: "Address 2",
              lines: 2,
              controller: cntlrs.permanentAddress2Cntrl,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Permanent City/Town/Village",
              textFieldLabel: "City/Town/Village",
              controller: cntlrs.permanent_City_town_village_cntlr,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Permanent Post Office Pincode",
              textFieldLabel: "Post Office  Pincode",
              inputType: TextInputType.number,
              controller: cntlrs.permanent_post_office_pincode_cntlr,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // only digits allowed
                LengthLimitingTextInputFormatter(6), // max length 6
              ],
            ),
            LabelCustomTextField(
              hintText: "Permanent Country",
              textFieldLabel: "Country",
              controller: cntlrs.permanent_country_cntlr,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Permanent State",
              textFieldLabel: "State",
              controller: cntlrs.permanent_states_cntlr,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Permanent District",
              textFieldLabel: "District",
              controller: cntlrs.permanent_district_cntlr,
              textInputAction: TextInputAction.done,
            ),

            SizedBox(height: h * 0.03),

            //"present"
            _sectionTitle("Present Address", w),
            LabelCustomTextField(
              hintText: "Present House No & Name",
              textFieldLabel: "House No & Name",
              controller: cntlrs.presentAddressHouseNoNameCntlr,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Present Address 1",
              textFieldLabel: "Address 1",
              lines: 2,
              controller: cntlrs.presentAddress1Cntrl,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Present Address 2",
              textFieldLabel: "Address 2",
              lines: 2,
              controller: cntlrs.presentAddress2Cntrl,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Present City/Town/Village",
              textFieldLabel: "City/Town/Village",
              controller: cntlrs.present_City_town_village_cntlr,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Present Post Office Pincode",
              textFieldLabel: "Post Office  Pincode",
              controller: cntlrs.present_post_office_pincode_cntlr,
              inputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // only digits allowed
                LengthLimitingTextInputFormatter(6), // max length 6
              ],
            ),
            LabelCustomTextField(
              hintText: "Present Country",
              textFieldLabel: "Country",
              controller: cntlrs.present_country_cntlr,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Present State",
              textFieldLabel: "State",
              controller: cntlrs.present_states_cntlr,
              textInputAction: TextInputAction.next,
            ),
            LabelCustomTextField(
              hintText: "Present District",
              textFieldLabel: "District",
              controller: cntlrs.present_district_cntlr,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.02),
              child: LabelWithDropDownField(
                textDropDownLabel: "Communication Address",
                items: ["Permanant Adress", "Present Address"],

                onChanged: (value) {
                  if (value == "Yes") {
                    cntlrs.isthisCommuniCationAddress = true;
                  } else {
                    cntlrs.isthisCommuniCationAddress = false;
                  }
                },
              ),
            ),
            SizedBox(height: h * 0.03),
            SizedBox(
              width: w,
              child: CustomRaisedButton(
                buttonText: "Continue",
                onPressed: () {
                  // Check if all permanent fields are empty
                  final isPermanentEmpty =
                      cntlrs.permanentAddressHouseNoNameCntlr.text
                          .trim()
                          .isEmpty &&
                      cntlrs.permanentAddress1Cntrl.text.trim().isEmpty &&
                      cntlrs.permanentAddress2Cntrl.text.trim().isEmpty &&
                      cntlrs.permanent_City_town_village_cntlr.text
                          .trim()
                          .isEmpty &&
                      cntlrs.permanent_post_office_pincode_cntlr.text
                          .trim()
                          .isEmpty &&
                      cntlrs.permanent_country_cntlr.text.trim().isEmpty &&
                      cntlrs.permanent_district_cntlr.text.trim().isEmpty;

                  final isPresentEmpty =
                      cntlrs.presentAddressHouseNoNameCntlr.text
                          .trim()
                          .isEmpty &&
                      cntlrs.presentAddress1Cntrl.text.trim().isEmpty &&
                      cntlrs.presentAddress2Cntrl.text.trim().isEmpty &&
                      cntlrs.present_City_town_village_cntlr.text
                          .trim()
                          .isEmpty &&
                      cntlrs.present_post_office_pincode_cntlr.text
                          .trim()
                          .isEmpty &&
                      cntlrs.present_country_cntlr.text.trim().isEmpty &&
                      cntlrs.present_district_cntlr.text.trim().isEmpty;

                  if (isPermanentEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please fill all Permanent Address fields.",
                    );
                    return;
                  }

                  if (cntlrs.permanentAddressHouseNoNameCntlr.text
                      .trim()
                      .isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter House No & Name (Permanent Address).",
                    );
                    return;
                  }
                  if (cntlrs.permanentAddress1Cntrl.text.trim().isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter Address 1 (Permanent Address).",
                    );
                    return;
                  }
                  if (cntlrs.permanentAddress2Cntrl.text.trim().isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter Address 2 (Permanent Address).",
                    );
                    return;
                  }
                  if (cntlrs.permanent_City_town_village_cntlr.text
                      .trim()
                      .isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter City/Town/Village (Permanent Address).",
                    );
                    return;
                  }
                  if (cntlrs.permanent_post_office_pincode_cntlr.text
                      .trim()
                      .isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter Post Office Pincode (Permanent Address).",
                    );
                    return;
                  }
                  if (cntlrs.permanent_country_cntlr.text.trim().isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter Country (Permanent Address).",
                    );
                    return;
                  }
                  if (cntlrs.permanent_district_cntlr.text.trim().isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter District (Permanent Address).",
                    );
                    return;
                  }

                  // Validate Present Address
                  if (isPresentEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please fill all Present Address fields.",
                    );
                    return;
                  }

                  if (cntlrs.presentAddressHouseNoNameCntlr.text
                      .trim()
                      .isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter House No & Name (Present Address).",
                    );
                    return;
                  }
                  if (cntlrs.presentAddress1Cntrl.text.trim().isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter Address 1 (Present Address).",
                    );
                    return;
                  }
                  if (cntlrs.presentAddress2Cntrl.text.trim().isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter Address 2 (Present Address).",
                    );
                    return;
                  }
                  if (cntlrs.present_City_town_village_cntlr.text
                      .trim()
                      .isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter City/Town/Village (Present Address).",
                    );
                    return;
                  }
                  if (cntlrs.present_post_office_pincode_cntlr.text
                      .trim()
                      .isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter Post Office Pincode (Present Address).",
                    );
                    return;
                  }
                  if (cntlrs.present_country_cntlr.text.trim().isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter Country (Present Address).",
                    );
                    return;
                  }
                  if (cntlrs.present_district_cntlr.text.trim().isEmpty) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Enter District (Present Address).",
                    );
                    return;
                  }

                  // All validations passed
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserIndividualCreation3(),
                    ),
                  );
                },
              ),
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
