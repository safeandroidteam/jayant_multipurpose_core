import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passbook_core_jayant/QRCodeGen/QRCodeHome.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Settings/MpinGenerate.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'REST/app_exceptions.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController oldPassCtrl = TextEditingController(),
      newPassCtrl = TextEditingController(),
      confirmPassCtrl = TextEditingController();
  bool oldPassValid = false, newPassValid = false, confirmPassValid = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  SharedPreferences? preferences;
  var cmpCodeKey = "",
      userId = "",
      custId = "",
      acc = "",
      name = "",
      address = "";

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Settings", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            profile(),
            SizedBox(height: 10.0),
            Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.grey[200],
              height: 1,
              thickness: 1,
            ),
            SizedBox(height: 10.0),
            TextView(
              text: "Settings",
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              size: 24.0,
            ),
            SizedBox(height: 10.0),
            ListTile(
              onTap: () => changePassword(),
              leading: Icon(
                Icons.lock_outline,
                color: Theme.of(context).focusColor,
              ),
              title: TextView(
                text: "Change Password",
                fontWeight: FontWeight.bold,
                size: 16.0,
              ),
              subtitle: TextView(text: "Change security password", size: 12.0),
            ),
            Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.grey[200],
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Theme.of(context).focusColor,
              ),
              title: TextView(
                text: "About Us",
                fontWeight: FontWeight.bold,
                size: 16.0,
              ),
              subtitle: TextView(text: "About this App", size: 12.0),
            ),
            Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.grey[200],
              height: 1,
              thickness: 1,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRCodeHome()),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.qr_code,
                  color: Theme.of(context).focusColor,
                ),
                title: TextView(
                  text: "QR Code",
                  fontWeight: FontWeight.bold,
                  size: 16.0,
                ),
                subtitle: TextView(text: "Get Your QR Code", size: 12.0),
              ),
            ),
            Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.grey[200],
              height: 1,
              thickness: 1,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MpinGenerate()),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.password,
                  color: Theme.of(context).focusColor,
                ),
                title: TextView(
                  text: "MPin",
                  fontWeight: FontWeight.bold,
                  size: 16.0,
                ),
                subtitle: TextView(text: "Update Mpin", size: 12.0),
              ),
            ),
            // Divider(
            //   endIndent: 15,
            //   indent: 15,
            //   color: Colors.grey[200],
            //   height: 1,
            //   thickness: 1,
            // ),
            ///Logout
            // ListTile(
            //   onTap: () =>
            //       Navigator.of(context).pushReplacement(MaterialPageRoute(
            //     builder: (context) => CoreApp(),
            //   )),
            //   leading: Image.asset(
            //     "assets/logout.png",
            //     color: Theme.of(context).focusColor,
            //     height: 30.0,
            //     width: 30.0,
            //   ),
            //   title: TextView(text:
            //     "Logout",
            //     fontWeight: FontWeight.bold,
            //     size: 16.0,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void loadData() async {
    preferences = StaticValues.sharedPreferences;
    setState(() {
      cmpCodeKey = preferences?.getString(StaticValues.cmpCodeKey) ?? "";
      userId = preferences?.getString(StaticValues.userID) ?? "";
      custId = preferences?.getString(StaticValues.custID) ?? "";
      acc = preferences?.getString(StaticValues.accNumber) ?? "";
      name = preferences?.getString(StaticValues.accName) ?? "";
      address = preferences?.getString(StaticValues.address) ?? "";
      print("userName");
      print(custId);
      print(acc);
      print(name);
    });
  }

  void changePassword() {
    String isInvalid = "";
    GlobalWidgets().dialogTemplate(
      context: context,
      title: "Change Password",
      barrierDismissible: false,
      actions: [
        StatefulBuilder(
          builder:
              (context, setState) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Visibility(
                    visible: isInvalid.length > 0,
                    child: TextView(text: isInvalid, color: Colors.red),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          oldPassCtrl.text = "";
                          newPassCtrl.text = "";
                          confirmPassCtrl.text = "";
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextView(text: "Cancel"),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed:
                            oldPassValid || newPassValid || confirmPassValid
                                ? null
                                : () async {
                                  if (
                                  // userIdCtrl.text.length > 0 &&
                                  oldPassCtrl.text.length >= 4 &&
                                      newPassCtrl.text.length >= 4 &&
                                      confirmPassCtrl.text.length >= 4 &&
                                      (newPassCtrl.text ==
                                          confirmPassCtrl.text)) {
                                    // Map? response = await RestAPI().get<Map>(
                                    //   "${APis.changePassword}${userIdCtrl.text}&old_pin=${oldPasCtrl.text}"
                                    //   "&new_pin=${newPassCtrl.text}",
                                    // );

                                    try {
                                      Map<String, dynamic>
                                      changeUserPasswordBody = {
                                        "Cmp_Code": cmpCodeKey,
                                        "User_ID": userId,
                                        "Curr_Password": "${oldPassCtrl.text}",
                                        "New_Password":
                                            "${confirmPassCtrl.text}",
                                      };

                                      Map response = await RestAPI().post(
                                        APis.changeUserPassword,
                                        params: changeUserPasswordBody,
                                      );

                                      setState(() {
                                        bool error =
                                            // response!["Table"][0]["Status"]
                                            response["ProceedMessage"]
                                                .toString()
                                                .toLowerCase() ==
                                            "FAILED";

                                        if (!error) {
                                          oldPassCtrl.text = "";
                                          newPassCtrl.text = "";
                                          confirmPassCtrl.text = "";
                                          GlobalWidgets().showSnackBar(
                                            context,
                                            // response["Table"][0]["Status"]
                                            response["ProceedMessage"]
                                                .toString(),
                                          );
                                          Navigator.pop(context);
                                        } else {
                                          setState(() {
                                            // isInvalid = "Invalid Credentials";
                                            isInvalid = "FAILED";
                                          });
                                        }
                                      });
                                    } on RestException catch (e) {
                                      // GlobalWidgets().showSnackBar(
                                      //   context,
                                      //   e.message["ProceedMessage"],
                                      // );
                                      Fluttertoast.showToast(
                                        msg: e.message["ProceedMessage"],
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black54,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                      return;
                                    }
                                  } else {
                                    setState(() {
                                      isInvalid = "Please fill up the fields";
                                    });
                                  }
                                },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextView(
                            text: "Change Password",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        ),
      ],
      content: StatefulBuilder(
        builder:
            (context, setState) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  EditTextBordered(
                    controller: oldPassCtrl,
                    hint: "Enter current password",
                    errorText:
                        oldPassValid ? "Password length should be 4" : null,
                    obscureText: true,
                    showObscureIcon: true,
                    textInputAction: TextInputAction.next,
                    onChange: (value) {
                      setState(() {
                        oldPassValid = value.trim().length < 4;
                        isInvalid = "";
                      });
                    },
                  ),
                  SizedBox(height: 10.0),
                  EditTextBordered(
                    controller: newPassCtrl,
                    hint: "Enter new password",
                    obscureText: true,
                    showObscureIcon: true,
                    textInputAction: TextInputAction.next,
                    errorText:
                        newPassValid
                            ? "Please include special characters."
                            : null,
                    onChange: (value) {
                      setState(() {
                        newPassValid =
                            (RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value) &&
                                value.trim().length < 4);
                        print(newPassValid);
                        isInvalid = "";
                      });
                    },
                  ),
                  SizedBox(height: 10.0),
                  EditTextBordered(
                    controller: confirmPassCtrl,
                    hint: "Confirm new password",
                    obscureText: true,
                    showObscureIcon: true,
                    textInputAction: TextInputAction.done,
                    errorText:
                        confirmPassValid ? "Password not matching" : null,

                    onChange: (value) {
                      setState(() {
                        confirmPassValid =
                            confirmPassCtrl.text != newPassCtrl.text;
                        print(confirmPassValid);
                        isInvalid = "";
                      });
                    },
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
      ),
    );
  }

  Widget profile() {
    return ListTile(
      dense: true,
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage("assets/people.png"),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(text: name ?? "", fontWeight: FontWeight.bold, size: 16),
          TextView(text: acc ?? "", size: 14.0),
          SizedBox(height: 5.0),
        ],
      ),
      subtitle: TextView(text: address ?? "", size: 12),
    );
  }

  var about =
      "Jayant India Nidhi Limited offers you information of your account, in just a touch away from anywhere,"
      " anytime. The application allows instant access to your transactions info.\n"
      "You can instantly know your account balance, makes fund transfers and mobile recharges on the move,"
      " real-time and lots more !\n    We provide Features to harness in the palm of your hands.";
}
