import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:passbook_core_jayant/MainScreens/Model/LoginModel.dart';
import 'package:passbook_core_jayant/MainScreens/Model/SignInModel.dart';
import 'package:passbook_core_jayant/MainScreens/Register.dart';
import 'package:passbook_core_jayant/MainScreens/new_user_screen.dart/new_user.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/sim_sender.dart';
import 'package:passbook_core_jayant/Util/sim_ui.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  ///Login Credentials
  ///Username = NIRAJ
  ///Password = 1982

  int indexPage = 0;
  final PageController _pageController = PageController(initialPage: 1);
  AnimationController? _animationController, _floatingAnimationController;
  Animation<double>? _animation, _floatingAnimation;
  static const int pageCtrlTime = 550;
  static const _animationCurves = Curves.fastLinearToSlowEaseIn;
  static const _pageCurves = Curves.easeIn;
  final GlobalKey _regToolTipKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String? MPin;
  String? strOtp, str_Otp;

  void reverseAnimate() {
    Future.delayed(Duration(milliseconds: pageCtrlTime), () {
      _animationController?.reverse();
      _floatingAnimationController?.reverse();
    });
  }

  void checkVersionCompatible() async {
    Map<String, dynamic> versionMap = await (RestAPI().get(
      APis.mobileGetVersion,
    ));
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    customPrint(
      "cmpcode : ${versionMap["Data"][0]["Cmp_Code"].toString()}"
      "\nappName $appName,"
      "\nPackageName $packageName"
      "\nVERSION FE $version"
      // "\nVERSION BE ${(versionMap["Table"][0]["Ver_Name"] as double).toString()}"
      "\nVersion BE ${(versionMap["Data"][0]["Ver_Name"]).toString()}"
      "\nBuildNumber FE $buildNumber"
      "\nBuildNumber BE ${versionMap["Data"][0]["Ver_Code"].toString()}",
      // "\nBuildNumber BE ${(double.parse(versionMap["Table"][0]["Ver_Code"])).round().toString()}"
    );

    String verNameFromApi = versionMap["Data"][0]["Ver_Name"].toString();
    String verCodeFromApi = versionMap["Data"][0]["Ver_Code"].toString();
    String versionCode = versionMap["Data"][0]["Cmp_Code"].toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(StaticValues.cmpCodeKey, versionCode);
    String verCodeFromApiDouble =
        double.tryParse(verCodeFromApi)?.round().toString() ?? "";
    alertPrint("Ver_Name Frm Api==$verNameFromApi");
    alertPrint("Ver_Code Frm Api==$verCodeFromApiDouble");
    alertPrint("ver_Code From App==$buildNumber");
   // alertPrint("cmpcode test=$cmpCode");
    if (verCodeFromApiDouble != buildNumber) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              if (Platform.isIOS) {
                SystemNavigator.pop();
              } else if (Platform.isAndroid)
                exit(0);
              return false;
            },
            child: AlertDialog(
              // content:
              //     Text("A new version of this application is available now. "
              //         "Please update to get new features."),

              // title: Text("Update Jayant India?"),
              title: Text("Update $appName?"),
              content: Text(
                "A new version of this application is available now. "
                "Please update to get new features.\nCurrent version is $version+$buildNumber",
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        if (Platform.isIOS) {
                          SystemNavigator.pop();
                        } else if (Platform.isAndroid)
                          exit(0);
                      },
                      child: Text(
                        "Exit",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var url =
                            'https://play.google.com/store/apps/details?id=$packageName';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text("Update"),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 2),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/googlePlayStoreLogo.png",
                      height: MediaQuery.of(context).size.height * 0.035,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        useSafeArea: true,
      );
    }
  }

  termsAndConditions() async {
    SharedPreferences prefs = StaticValues.sharedPreferences!;
    if (prefs.getBool("Accept_Terms") == null ||
        !prefs.getBool("Accept_Terms")!) {
      showDialog(
        context: context,
        builder:
            (context) => WillPopScope(
              onWillPop: () async {
                if (Platform.isIOS) {
                  SystemNavigator.pop();
                } else if (Platform.isAndroid)
                  exit(0);
                return false;
              },
              child: AlertDialog(
                title: Text("Warning"),
                actions: [
                  ElevatedButton(
                    /* onPressed: () {
                      prefs.setBool("Accept_Terms", false);
                      exit(0);
                    },*/
                    onPressed: () async {
                      prefs.setBool("Accept_Terms", false);
                      if (Platform.isIOS) {
                        SystemNavigator.pop();
                      } else if (Platform.isAndroid)
                        exit(0);
                    },
                    child: Text("Close"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //  prefs.setString('Accept_Terms', 'true');
                      prefs.setBool("Accept_Terms", true);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("Accept"),
                  ),
                ],
                content: Text("I Accept Terms and Conditions of this Bank"),
              ),
            ),
      );
    }
  }

  @override
  void initState() {
    checkVersionCompatible();
    SharedPreferences pref = StaticValues.sharedPreferences!;
    MPin = pref.getString(StaticValues.Mpin);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: pageCtrlTime),
      reverseDuration: Duration(milliseconds: pageCtrlTime),
    );
    _floatingAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: pageCtrlTime),
      reverseDuration: Duration(milliseconds: pageCtrlTime),
    );
    _animation = Tween<double>(
      begin: 1.41,
      end: 1.67,
    ).animate(_animationController!)..addListener(() {
      setState(() {
        print(_animationController?.isDismissed);
      });
    });
    _floatingAnimation = Tween<double>(
      begin: .23,
      end: .1,
    ).animate(_floatingAnimationController!)..addListener(() {
      setState(() {});
    });
    Future.delayed(Duration(seconds: 2), () {
      final dynamic tooltip = _regToolTipKey.currentState;
      tooltip.ensureTooltipVisible();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show an alert dialog when the user presses the back button
        return await (showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text('Do you want to exit app?'),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).focusColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Theme.of(context).errorColor,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => SystemNavigator.pop(),
                        child: Text('Yes'),
                      ),
                    ],
                  ),
            )
            as FutureOr<bool>);
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: WillPopScope(
            onWillPop: () async {
              if (_pageController.page == 0 || _pageController.page == 2) {
                _pageController.animateToPage(
                  1,
                  duration: Duration(milliseconds: pageCtrlTime),
                  curve: _pageCurves,
                );
                reverseAnimate();
                return false;
              } else {
                return true;
              }
            },
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).cardColor,
                        Theme.of(context).focusColor,
                        Theme.of(context).primaryColor,
                      ],
                      tileMode: TileMode.repeated,
                      begin: Alignment(0.0, 0.5),
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
                /*    Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/safesoftware_logo.png",
                      width: 200,
                    )),*/
                Align(
                  alignment: Alignment.center,

                  ///this SingleChildScrollView set to visible TextField when SoftKeyboard appears
                  child: SingleChildScrollView(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: pageCtrlTime),
                      curve: Curves.easeIn,
                      width: MediaQuery.of(context).size.width * .8,
                      // height:
                      //     MediaQuery.of(context).size.width * _animation!.value,
                      height:
                          (MediaQuery.of(context).size.width *
                                  _animation!.value +
                              MediaQuery.of(context).size.height * .19),
                      // height: MediaQuery.of(context).size.height * .8,
                      //onRegister .83
                      child: Card(
                        elevation: 0.0,
                        borderOnForeground: true,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: <Widget>[
                            ForgotUI(
                              scaffoldKey: _scaffoldKey,
                              onTap: () {
                                setState(() {
                                  _pageController.nextPage(
                                    duration: Duration(
                                      milliseconds: pageCtrlTime,
                                    ),
                                    curve: _pageCurves,
                                  );
                                });
                              },
                            ),
                            LoginUI(
                              scaffold: _scaffoldKey,
                              onTap: () {
                                setState(() {
                                  _pageController.previousPage(
                                    duration: Duration(
                                      milliseconds: pageCtrlTime,
                                    ),
                                    curve: _pageCurves,
                                  );
                                });
                              },
                              forgotUser: () {
                                setState(() {
                                  _pageController.nextPage(
                                    duration: Duration(
                                      milliseconds: pageCtrlTime,
                                    ),
                                    curve: _pageCurves,
                                  );
                                });
                              },
                            ),
                            RegisterUI(
                              onTap: () {
                                setState(() {
                                  _pageController.animateToPage(
                                    1,
                                    duration: Duration(
                                      milliseconds: pageCtrlTime,
                                    ),
                                    curve: _pageCurves,
                                  );
                                  reverseAnimate();
                                });
                              },
                              scaffoldKey: _scaffoldKey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: pageCtrlTime),
                  right: MediaQuery.of(context).size.width * .035,
                  curve: _animationCurves,
                  top:
                      MediaQuery.of(context).size.width *
                      _floatingAnimation!.value,
                  //onRegister .03
                  child: Tooltip(
                    key: _regToolTipKey,
                    message: "To register click here",
                    preferBelow: false,
                    decoration: BoxDecoration(
                      color: Theme.of(context).focusColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: pageCtrlTime),
                          curve: _pageCurves,
                        );
                        //                      _animationController.forward();
                        //                      _floatingAnimationController.forward();
                      },
                      disabledElevation: 1.0,
                      isExtended: true,
                      backgroundColor: Theme.of(context).cardColor,
                      elevation: 8.0,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginUI extends StatefulWidget {
  final GestureTapCallback? onTap;
  final GestureTapCallback? forgotUser;
  final GlobalKey<ScaffoldState> scaffold;

  const LoginUI({
    super.key,
    this.onTap,
    required this.scaffold,
    this.forgotUser,
  });

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  TextEditingController mpinCtrl = TextEditingController();
  TextEditingController mPinCtrl1 = TextEditingController();
  TextEditingController mPinCtrl2 = TextEditingController();
  TextEditingController mPinCtrl3 = TextEditingController();
  TextEditingController mPinCtrl4 = TextEditingController();
  TextEditingController allMpinCtrl = TextEditingController();
  bool mobVal = false, passVal = false, mpinVal = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  LoginModel login = LoginModel();
  bool _isLoading = false;
  bool isLoginWithUsername = false;
  bool isMPinEmpty = true;
  String? MPin, strCustName;
  Map? response;
  String? str_Otp;
  String? cmpCode;
  var _pass;
  bool isLoading = false;
  int count = 0;

  void saveData(SignInModel signInModel) async {
    SharedPreferences preferences = StaticValues.sharedPreferences!;
    successPrint("Signin Modal ==${signInModel.data.first.toJson()}");
    await preferences.setString(
      StaticValues.custID,
      signInModel.data[0].custId.toString(),
    );
    await preferences.setString(
      StaticValues.userID,
      signInModel.data[0].userId.toString(),
    );
    await preferences.setString(
      StaticValues.branchCode,
      signInModel.data[0].brCode.toString(),
    );
    await preferences.setString(
      StaticValues.brName,
      signInModel.data[0].brName.toString(),
    );

    await preferences.setString(
      StaticValues.ifsc,
      signInModel.data[0].ifscCode.toString(),
    );
    await preferences.setString(
      StaticValues.userName,
      signInModel.data[0].userName.toString(),
    );
    await preferences.setString(
      StaticValues.accName,
      signInModel.data[0].profileName.toString(),
    );
    await preferences.setString(
      StaticValues.custType,
      signInModel.data[0].customerType.toString(),
    );
    await preferences.setString(
      StaticValues.custTypeCode,
      signInModel.data[0].custTypeCode.toString(),
    );

    await preferences.setString(
      StaticValues.accountNo,
      signInModel.data[0].accNo.toString(),
    );
    //  await preferences.setString(StaticValues.userPass, passCtrl.text);
    await preferences.setString(
      StaticValues.address,
      signInModel.data[0].fullAddress!
          .split(",")
          .toList()
          .where((element) => element.isNotEmpty)
          .join(",")
          .toString(),
    );
    Navigator.of(context).pushReplacementNamed("/HomePage");
  }

  mergeMPinCtrlValues() {
    allMpinCtrl.clear();
    allMpinCtrl.text =
        mPinCtrl1.text + mPinCtrl2.text + mPinCtrl3.text + mPinCtrl4.text;
    debugPrint("mergeMPinCtrlValues() - MPIN : ${allMpinCtrl.text}");
  }

  @override
  void initState() {
    super.initState();
    loadSims();
    setState(() {
      SharedPreferences pref = StaticValues.sharedPreferences!;
      MPin = pref.getString(StaticValues.Mpin);
      strCustName = pref.getString(StaticValues.accName);
      cmpCode = pref.getString(StaticValues.cmpCodeKey);
      debugPrint("cmpCode : $cmpCode");
      debugPrint("MPIN : $MPin");
      isMPinEmpty = false;
      /*usernameCtrl.text = "nira";
      passCtrl.text = "1234";*/
      //      usernameCtrl.text = "vidya";
      //      passCtrl.text = "123456";
      //      usernameCtrl.text = "9895564690";
      //      passCtrl.text = "123456";
    });
    _tabController = TabController(length: 2, vsync: this);
  }

  final mobCtrl = TextEditingController();
  void loadSims() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String mobNo = preferences.getString(StaticValues.mobileNo) ?? "";
    warningPrint("mob no in pref = ${mobNo}");
    if (mobNo.isEmpty && mobNo.length != 10) {
      customPrint("mob no is empty");
      // Request permission
      final status = await Permission.phone.request();
      if (!status.isGranted) {
        debugPrint("Phone permission not granted");
        return;
      }

      try {
        // Fetch SIM list
        final simList = await SimSender.getSimList();
        successPrint("SIM list length: ${simList.length}");

        if (simList.isEmpty) {
          errorPrint("No SIM cards found");
          return;
        }

        setState(() {
          // Optionally update UI with sim list (if needed elsewhere)
        });

        // Show bottom sheet and handle selection
        showSimGridBottomSheet(context, simList, (selectedNumber) {
          successPrint("Selected phone number: $selectedNumber");
          if (selectedNumber.startsWith('+91')) {
            customPrint("mob no contain +91");
            selectedNumber = selectedNumber.substring(3);
          } else if (selectedNumber.length == 12 &&
              selectedNumber.startsWith('91')) {
            customPrint("mob no contain 91");
            selectedNumber = selectedNumber.substring(2);
          }

          final trimmed = selectedNumber.trim();
          customPrint("trimmed length=${trimmed.length}");

          if (trimmed.length != 10) {
            GlobalWidgets().showSnackBar(context, "Mobile Number Not Found");
          }
          if (trimmed.length == 10) {
            setState(() {
              mobCtrl.text = trimmed;
            });
            preferences.setString(StaticValues.mobileNo, mobCtrl.text);
            successPrint("Mobile no ==${mobCtrl.text}");
          }
        });
      } catch (e) {
        debugPrint("Error loading SIMs: $e");
      }
    } else if (mobNo.isNotEmpty && mobNo.length == 10) {
      mobCtrl.text = mobNo;
      successPrint("Mobile no  ==${mobCtrl.text}");
    }
    alertPrint("mob No in cntrl added=${mobCtrl.text}");
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GlobalWidgets().logoWithText(context, StaticValues.titleDecoration!),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextView(
                text: "Sign In",
                size: 20.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).focusColor,
              ),
              (!isLoginWithUsername && MPin != null)
                  ? SizedBox(height: 10.0)
                  : SizedBox(height: 30.0),
              (isLoginWithUsername || MPin == null)
                  ? SizedBox.shrink()
                  : TabBar(
                    controller: _tabController,
                    tabs: [Tab(text: "MPIN"), Tab(text: "Username")],
                  ),
              if (!isLoginWithUsername && MPin != null) SizedBox(height: 10.0),
              if (MPin != null)
                SizedBox(
                  height: height * 0.23,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ///MPIN
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(height: 20.0),
                          TextView(
                            text: strCustName ?? "",
                            size: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 20),

                          SizedBox(
                            width: width * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SingleDigitTextField(
                                  controller: mPinCtrl1,
                                  autoFocus: false,
                                  focusNode: focusNode1,
                                  nextFocusNode: focusNode2,
                                  obscureText: true,
                                ),
                                SingleDigitTextField(
                                  controller: mPinCtrl2,
                                  autoFocus: false,
                                  focusNode: focusNode2,
                                  nextFocusNode: focusNode3,
                                  prevFocusNode: focusNode1,
                                  obscureText: true,
                                ),
                                SingleDigitTextField(
                                  controller: mPinCtrl3,
                                  autoFocus: false,
                                  focusNode: focusNode3,
                                  nextFocusNode: focusNode4,
                                  prevFocusNode: focusNode2,
                                  obscureText: true,
                                ),
                                SingleDigitTextField(
                                  controller: mPinCtrl4,
                                  autoFocus: false,
                                  focusNode: focusNode4,
                                  prevFocusNode: focusNode3,
                                  obscureText: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Visibility(
                            visible: isMPinEmpty,
                            child: Text(
                              "Enter 4 digit MPIN",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),

                      ///UN & PW
                      Column(
                        children: [
                          SizedBox(height: 10.0),
                          EditTextBordered(
                            controller: usernameCtrl,
                            hint: "Username",
                            errorText: mobVal ? "Username is invalid" : null,
                            setBorder: true,

                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.next,
                            setDecoration: true,
                            onChange: (value) {
                              setState(() {
                                mobVal = value.trim().isEmpty;
                              });
                            },
                            onSubmitted: (_) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          SizedBox(height: 20.0),
                          EditTextBordered(
                            controller: passCtrl,
                            hint: "Password",
                            errorText:
                                passVal ? "Password length should be 4" : null,
                            obscureText: true,
                            showObscureIcon: true,
                            onChange: (value) {
                              setState(() {
                                passVal = value.trim().length < 4;
                              });
                            },
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ],
                  ),
                ),

              if (MPin == null)
                Column(
                  children: [
                    EditTextBordered(
                      controller: usernameCtrl,
                      hint: "Username",
                      errorText: mobVal ? "Username is invalid" : null,
                      setBorder: true,

                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      setDecoration: true,
                      onChange: (value) {
                        setState(() {
                          mobVal = value.trim().isEmpty;
                        });
                      },
                      onSubmitted: (_) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    SizedBox(height: 20.0),
                    EditTextBordered(
                      controller: passCtrl,
                      hint: "Password",
                      errorText: passVal ? "Password length should be 4" : null,
                      obscureText: true,
                      showObscureIcon: true,
                      onChange: (value) {
                        setState(() {
                          passVal = value.trim().length < 4;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),

              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: widget.onTap,
                      child: TextView(
                        text: "Forgot password?",
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: widget.forgotUser,
                      child: TextView(
                        text: "Forgot user?",
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => NewUser()),
                        );
                      },
                      child: TextView(
                        text: "New User?",
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        CustomRaisedButton(
          loadingValue: _isLoading,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          onPressed: () async {
            warningPrint("mob no ==${mobCtrl.text}");

            ///Note when taking release change if condition to isNotEmpty
            if (mobCtrl.text.isEmpty) {
              debugPrint(
                "Login Button : UN from usernameCtrl - ${usernameCtrl.text}",
              );
              customPrint("login loading");
              mergeMPinCtrlValues();
              setState(() {
                passVal = passCtrl.text.trim().length < 4;
                mobVal = usernameCtrl.text.trim().isEmpty;
                mpinVal = mpinCtrl.text.trim().length < 4;
                if (allMpinCtrl.text.trim().length < 4) {
                  isMPinEmpty = true;
                }
              });

              ///Login with UN & PW
              if (isLoginWithUsername ||
                  MPin == null ||
                  _tabController.index == 1) {
                if (!passVal && !mobVal) {
                  customPrint("Login with UN & PW ");
                  _isLoading = true;
                  try {
                    response = await RestAPI().post(
                      APis.loginUrl,
                      params: {
                        "Cmp_Code": cmpCode ?? "",
                        "User_Name": usernameCtrl.text,
                        "Password": passCtrl.text,
                        "Mobile_No": "9400904859",
                        // "Mobile_No": mobCtrl.text,
                      },
                    );

                    setState(() {
                      _isLoading = false;
                      if (response!.toString().isEmpty ||
                          response == null ||
                          response!.isEmpty) {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Something went wrong",
                        );
                        return;
                      }
                      if (response!["ProceedStatus"] == "N") {
                        setState(() {
                          _isLoading = false;
                        });
                        print("LIJITH");
                        debugPrint(
                          "ProceedMessage ::: ${response!["ProceedMessage"]}",
                        );
                        GlobalWidgets().showSnackBar(
                          context,
                          response!["ProceedMessage"],
                        );
                      } else {
                        if (response!["Data"][0]["OTP_Required"] == "Y") {
                          // if (response!["Data"][0]["Proceed_Status"] == "Y") {
                          // usernameCtrl.clear();
                          // passCtrl.clear();

                          debugPrint(
                            "OTP_Required = ${response!["Data"][0]["OTP_Required"]}\nProceed_Status = ${response!["Data"][0]["Proceed_Status"]}",
                          );

                          ///TODO  for otp while login
                          _loginConfirmation("1");
                        } else {
                          saveData(
                            SignInModel(
                              proceedStatus: response!["ProceedStatus"],
                              proceedMessage: response!["ProceedMessage"],
                              data: [
                                SignInData(
                                  proceed_Status:
                                      response!["Data"][0]["Proceed_Status"],
                                  proceed_Message:
                                      response!["Data"][0]["Proceed_Message"],
                                  otpRequired:
                                      response!["Data"][0]["OTP_Required"],
                                  cmpCode: response!["Data"][0]["Cmp_Code"],
                                  userId: response!["Data"][0]["User_ID"],
                                  userName: response!["Data"][0]["User_Name"],
                                  custId: response!["Data"][0]["CustID"],
                                  accId: response!["Data"][0]["Acc_ID"],
                                  accNo: response!["Data"][0]["Acc_No"],
                                  custMobile:
                                      response!["Data"][0]["Cust_Mobile"],
                                  profileName:
                                      response!["Data"][0]["ProfileName"],
                                  fullAddress:
                                      response!["Data"][0]["Full_Address"],
                                  brCode: response!["Data"][0]["Br_Code"],
                                  brName: response!["Data"][0]["Br_Name"],
                                  ifscCode: response!["Data"][0]["IFSC_Code"],
                                  customerType:
                                      response!["Data"][0]["Customer_Type"],
                                  transDate: response!["Data"][0]["Trans_Date"],
                                  custTypeCode:
                                      response!["Data"][0]["Customer_TypeCode"],
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    });
                  } on RestException catch (e) {
                    setState(() {
                      _isLoading = false;
                    });

                    GlobalWidgets().showSnackBar(
                      context,
                      e.message["ProceedMessage"].toString(),
                    );
                  }
                }

                ///Login with MPIN
              } else if (!isLoginWithUsername &&
                  MPin != null &&
                  _tabController.index == 0 &&
                  allMpinCtrl.text.isNotEmpty &&
                  allMpinCtrl.text.trim().length == 4) {
                debugPrint("Login MPIN > ALL true");
                setState(() {
                  isMPinEmpty = false;
                });
                _isLoading = true;
                try {
                  SharedPreferences pref = StaticValues.sharedPreferences!;

                  String? storedMpin = pref.getString(StaticValues.fullMpin);

                  customPrint("stored mpin=$storedMpin");

                  if (storedMpin != null && storedMpin.isNotEmpty) {
                    if (storedMpin != allMpinCtrl.text) {
                      GlobalWidgets().showSnackBar(
                        context,
                        "Mpin Mismatched. Please use Login with Username & Password Method",
                      );
                      _isLoading = false;
                    } else {
                      response = await RestAPI().post(
                        APis.loginMPin,
                        params: {
                          "Cmp_Code": cmpCode ?? "",
                          "User_Name": pref.getString(StaticValues.userName),
                          "MPIN": allMpinCtrl.text,
                          "Mobile_No": "9400904859",
                          // "Mobile_No": mobCtrl.text,
                        },
                      );

                      setState(() {
                        _isLoading = false;

                        if (response!.toString().isEmpty ||
                            response == null ||
                            response!.isEmpty) {
                          GlobalWidgets().showSnackBar(
                            context,
                            "Something went wrong",
                          );
                          return;
                        }
                        if (response!["ProceedStatus"] == "N") {
                          setState(() {
                            _isLoading = false;
                          });
                          print("LIJITH");
                          debugPrint(
                            "ProceedMessage ::: ${response!["ProceedMessage"]}",
                          );
                          GlobalWidgets().showSnackBar(
                            context,
                            response!["ProceedMessage"],
                          );
                        } else {
                          if (response!["Data"][0]["Proceed_Status"] == "Y" &&
                              response!["Data"][0]["OTP_Required"] == "N") {
                            // if (response!["Data"][0]["Proceed_Status"] == "Y") {
                            // usernameCtrl.clear();
                            // passCtrl.clear();

                            debugPrint(
                              "OTP_Required = ${response!["Data"][0]["OTP_Required"]}\nProceed_Status = ${response!["Data"][0]["Proceed_Status"]}",
                            );

                            ///TODO  for otp while login
                            // _loginConfirmation("0");

                            saveData(
                              SignInModel(
                                proceedStatus: response!["ProceedStatus"],
                                proceedMessage: response!["ProceedMessage"],
                                data: [
                                  SignInData(
                                    proceed_Status:
                                        response!["Data"][0]["Proceed_Status"],
                                    proceed_Message:
                                        response!["Data"][0]["Proceed_Message"],
                                    otpRequired:
                                        response!["Data"][0]["OTP_Required"],
                                    cmpCode: response!["Data"][0]["Cmp_Code"],
                                    userId: response!["Data"][0]["User_ID"],
                                    userName: response!["Data"][0]["User_Name"],
                                    custId: response!["Data"][0]["CustID"],
                                    accId: response!["Data"][0]["Acc_ID"],
                                    accNo: response!["Data"][0]["Acc_No"],
                                    custMobile:
                                        response!["Data"][0]["Cust_Mobile"],
                                    profileName:
                                        response!["Data"][0]["ProfileName"],
                                    fullAddress:
                                        response!["Data"][0]["Full_Address"],
                                    brCode: response!["Data"][0]["Br_Code"],
                                    brName: response!["Data"][0]["Br_Name"],
                                    ifscCode: response!["Data"][0]["IFSC_Code"],
                                    customerType:
                                        response!["Data"][0]["Customer_Type"],
                                    transDate:
                                        response!["Data"][0]["Trans_Date"],
                                    custTypeCode:
                                        response!["Data"][0]["Customer_TypeCode"],
                                  ),
                                ],
                              ),
                            );

                            GlobalWidgets().showSnackBar(
                              context,
                              response!["Data"][0]["Proceed_Message"],
                            );
                          }
                          // else {
                          //   saveData(
                          //     SignInModel(
                          //       proceedStatus: response!["ProceedStatus"],
                          //       proceedMessage: response!["ProceedMessage"],
                          //       data: [
                          //         SignInData(
                          //           proceedStatus:
                          //               response!["Data"][0]["Proceed_Status"],
                          //           proceedMessage:
                          //               response!["Data"][0]["Proceed_Message"],
                          //           otpRequired:
                          //               response!["Data"][0]["OTP_Required"],
                          //           cmpCode: response!["Data"][0]["Cmp_Code"],
                          //           userId: response!["Data"][0]["User_ID"],
                          //           userName: response!["Data"][0]["User_Name"],
                          //           custId: response!["Data"][0]["CustID"],
                          //           accId: response!["Data"][0]["Acc_ID"],
                          //           accNo: response!["Data"][0]["Acc_No"],
                          //           custMobile:
                          //               response!["Data"][0]["Cust_Mobile"],
                          //           profileName:
                          //               response!["Data"][0]["ProfileName"],
                          //           fullAddress:
                          //               response!["Data"][0]["Full_Address"],
                          //           brCode: response!["Data"][0]["Br_Code"],
                          //           brName: response!["Data"][0]["Br_Name"],
                          //           ifscCode: response!["Data"][0]["IFSC_Code"],
                          //           customerType:
                          //               response!["Data"][0]["Customer_Type"],
                          //           transDate: response!["Data"][0]["Trans_Date"],
                          //         ),
                          //       ],
                          //     ),
                          //   );
                          // }
                        }
                      });
                    }
                  }
                } on RestException catch (e) {
                  setState(() {
                    _isLoading = false;
                  });

                  GlobalWidgets().showSnackBar(
                    context,
                    e.message["ProceedMessage"].toString(),
                  );
                }
              }
            } else {
              loadSims();
              customPrint("sim loadin");
            }
          },
          buttonText: "Login",
        ),
        /*CustomRaisedButton(
          color: Theme.of(context).cardColor,
          disabledColor: Theme.of(context).cardColor,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          onPressed: _isLoading
              ? null
              : () async {
	          print(usernameCtrl.text);
	          setState(() {
		          passVal = passCtrl.text.trim().length < 4;
		          mobVal = usernameCtrl.text.trim().length == 0;
	          });

	          if (!passVal && !mobVal) {
		          print("ALL true");
		          _isLoading = true;
		          Map response = await RestAPI().get(
				          "${APis.loginUrl}Mob_no=${usernameCtrl.text}&pwd=${passCtrl.text}&IMEI=863675039500942");
		          setState(() {

			          _isLoading = false;
			          if ((response["Table"][0] as Map).containsKey("invalid")) {
				          GlobalWidgets().showSnackBar(widget.scaffold, "Invalid Credentials");
			          } else {
				          LoginModel login = LoginModel.fromJson(response);
				          saveData(login);
			          }
		          });
	          }
          },
          child: _isLoading
              ? SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    semanticsLabel: "Loading",
                  ))
              : TextView(text:
                  "Login",
                  color: Colors.white,
                  size: 18.0,
                  fontWeight: FontWeight.bold,
                ),
        )*/
      ],
    );
  }

  void _loginConfirmation(String loginType) {
    isLoading = false;
    String? pass;
    GlobalWidgets().validateOTP(
      context,
      getValue: (passVal) {
        setState(() {
          pass = passVal;
        });
      },
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(text: "Enter OTP", size: 16.0),
          SizedBox(height: 10.0),
        ],
      ),
      actionButton: StatefulBuilder(
        builder:
            (context, setState) => CustomRaisedButton(
              loadingValue: isLoading,
              buttonText: isLoading ? "Loading..." : "LOGIN",
              onPressed:
                  isLoading
                      ? () {}
                      : () async {
                        SharedPreferences preferences =
                            StaticValues.sharedPreferences!;

                        debugPrint("OTP: $pass");

                        // if (pass == str_Otp) {
                        if (pass!.isNotEmpty) {
                          ///MPIN Login
                          if (loginType == "0") {
                            preferences.setString(
                              StaticValues.userPass,
                              passCtrl.text,
                            );

                            String? storedMpin = preferences.getString(
                              StaticValues.fullMpin,
                            );

                            warningPrint(
                              "MPin == null | mpin get from SharedPref1 : $storedMpin",
                            );

                            if (storedMpin != null && storedMpin.isNotEmpty) {
                              if (allMpinCtrl.text != storedMpin) {
                                warningPrint(
                                  "mpin in SharedPref1 : $storedMpin",
                                );
                                alertPrint(
                                  "mpin in all mpin Ctrl1 : ${allMpinCtrl.text}",
                                );
                                GlobalWidgets().showSnackBar(
                                  context,
                                  "Mpin Mismatch",
                                );
                              }
                            }

                            if (usernameCtrl.text.isNotEmpty) {
                              await preferences.setString(
                                StaticValues.userName,
                                usernameCtrl.text,
                              );
                            }

                            customPrint(
                              "Username get after new set to SharedPref1 : ${preferences.getString(StaticValues.userName)}",
                            );
                            // saveData(login);
                            saveData(
                              SignInModel(
                                proceedStatus: response!["ProceedStatus"],
                                proceedMessage: response!["ProceedMessage"],
                                data: [
                                  SignInData(
                                    proceed_Status:
                                        response!["Data"][0]["Proceed_Status"],
                                    proceed_Message:
                                        response!["Data"][0]["Proceed_Message"],
                                    otpRequired:
                                        response!["Data"][0]["OTP_Required"],
                                    cmpCode: response!["Data"][0]["Cmp_Code"],
                                    userId: response!["Data"][0]["User_ID"],
                                    userName: response!["Data"][0]["User_Name"],
                                    custId: response!["Data"][0]["CustID"],
                                    accId: response!["Data"][0]["Acc_ID"],
                                    accNo: response!["Data"][0]["Acc_No"],
                                    custMobile:
                                        response!["Data"][0]["Cust_Mobile"],
                                    profileName:
                                        response!["Data"][0]["ProfileName"],
                                    fullAddress:
                                        response!["Data"][0]["Full_Address"],
                                    brCode: response!["Data"][0]["Br_Code"],
                                    brName: response!["Data"][0]["Br_Name"],
                                    ifscCode: response!["Data"][0]["IFSC_Code"],
                                    customerType:
                                        response!["Data"][0]["Customer_Type"],
                                    transDate:
                                        response!["Data"][0]["Trans_Date"],
                                    custTypeCode:
                                        response!["Data"][0]["Customer_TypeCode"],
                                  ),
                                ],
                              ),
                            );
                            print("LIJU");
                          }
                          ///UN & PW Login
                          else {
                            try {
                              debugPrint("OTP: $pass");
                              setState(() {
                                isLoading = true;
                              });
                              response = await RestAPI().post(
                                APis.loginOtpVerify,
                                params: {
                                  "Cmp_Code": cmpCode,
                                  "User_Name": usernameCtrl.text,
                                  "Password": passCtrl.text,
                                  "OTP": pass,
                                },
                              );

                              SignInModel signIn = SignInModel.fromJson(
                                response as Map<String, dynamic>,
                              );

                              debugPrint("Response from OTP Verify: $response");

                              if (response!["ProceedStatus"] == "N") {
                                successPrint(
                                  "ProceedMessage ::: ${response!["ProceedMessage"]}",
                                );
                                GlobalWidgets().showSnackBar(
                                  context,
                                  response!["ProceedMessage"],
                                );
                                setState(() {
                                  isLoading = false;
                                });
                              } else if (response!["Data"][0]["Proceed_Status"] ==
                                  "Y") {
                                /// New user login then remove old user MPIN
                                String? userNameValue = preferences.getString(
                                  StaticValues.userName,
                                );

                                warningPrint(
                                  "MPin == null | Username get from SharedPref1 : $userNameValue",
                                );

                                if (userNameValue != null &&
                                    userNameValue.isNotEmpty) {
                                  if (usernameCtrl.text != userNameValue) {
                                    warningPrint(
                                      "Username in SharedPref1 : $userNameValue",
                                    );
                                    alertPrint(
                                      "Username in usernameCtrl1 : ${usernameCtrl.text}",
                                    );
                                    await preferences.remove(StaticValues.Mpin);

                                    successPrint(
                                      "Mpin in SharedPref1 : ${preferences.getString(StaticValues.Mpin)}",
                                    );
                                  }
                                }

                                if (usernameCtrl.text.isNotEmpty) {
                                  await preferences.setString(
                                    StaticValues.userName,
                                    usernameCtrl.text,
                                  );
                                }

                                customPrint(
                                  "Username get after new set to SharedPref1 : ${preferences.getString(StaticValues.userName)}",
                                );

                                GlobalWidgets().showSnackBar(
                                  context,
                                  response!["Data"][0]["Proceed_Message"],
                                );
                                saveData(signIn);
                                setState(() {
                                  isLoading = false;
                                });
                                // usernameCtrl.clear();
                                // passCtrl.clear();
                                print("LIJU");
                              }
                            } on RestException catch (e) {
                              setState(() {
                                isLoading = false;
                              });

                              Fluttertoast.showToast(
                                msg: e.message["ProceedMessage"],
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "OTP Mismatch",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
            ),
      ),
    );
  }
}

class ForgotUI extends StatefulWidget {
  final Function? onTap;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ForgotUI({super.key, this.onTap, required this.scaffoldKey});

  @override
  _ForgotUIState createState() => _ForgotUIState();
}

class _ForgotUIState extends State<ForgotUI> {
  TextEditingController userIdCtrl = TextEditingController(),
      otpCtrl = TextEditingController(),
      rePassCtrl = TextEditingController(),
      passCtrl = TextEditingController();
  bool userIdVal = false,
      otpValid = false,
      passValid = false,
      rePassValid = false,
      isGetOTP = false;
  String? strOtp;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: widget.onTap as void Function()?,
          child: Card(
            elevation: 3.0,
            margin: EdgeInsets.all(10.0),
            color: Theme.of(context).focusColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(Icons.chevron_left, color: Colors.white, size: 20.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextView(
                text: "Forgot Password",
                size: 20.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).focusColor,
              ),
              SizedBox(height: 30.0),
              EditTextBordered(
                controller: userIdCtrl,
                hint: "Enter user ID",
                errorText: userIdVal ? "Invalid user ID" : null,
                onChange: (value) {
                  setState(() {
                    userIdVal = value.trim().isEmpty;
                    isGetOTP = false;
                  });
                },
              ),
              SizedBox(height: 30.0),

              // Show these only if OTP is received
              if (isGetOTP) ...[
                EditTextBordered(
                  controller: otpCtrl,
                  keyboardType: TextInputType.number,
                  hint: "Enter OTP",
                  errorText: otpValid ? "OTP length should be 4" : null,
                  onChange: (value) {
                    setState(() {
                      otpValid = value.trim().length < 4;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                EditTextBordered(
                  controller: passCtrl,
                  hint: "New password",
                  obscureText: true,
                  showObscureIcon: true,
                  errorText:
                      passValid ? "Please include special characters" : null,
                  onChange: (value) {
                    setState(() {
                      passValid = RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value);
                    });
                  },
                ),
                SizedBox(height: 10.0),
                EditTextBordered(
                  controller: rePassCtrl,
                  hint: "Confirm new password",
                  obscureText: true,
                  showObscureIcon: true,
                  errorText: rePassValid ? "Password not matching" : null,
                  onChange: (value) {
                    setState(() {
                      rePassValid = rePassCtrl.text != passCtrl.text;
                    });
                  },
                ),
              ],
              // EditTextBordered(
              //   controller: passCtrl,
              //   hint: "New password",
              //   obscureText: true,
              //   showObscureIcon: true,
              //   //  errorText: passValid ? "Password length should be 4" : null,
              //   errorText:
              //       passValid ? "Please include special charcters" : null,
              //   onChange: (value) {
              //     setState(() {
              //       //  passValid = value.trim().length < 4;
              //       passValid = RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value);
              //     });
              //   },
              // ),
              // SizedBox(height: 10.0),
              // EditTextBordered(
              //   controller: rePassCtrl,
              //   hint: "Confirm new password",
              //   obscureText: true,
              //   showObscureIcon: true,
              //   errorText: rePassValid ? "Password not matching" : null,
              //   onChange: (value) {
              //     setState(() {
              //       rePassValid = rePassCtrl.text != passCtrl.text;
              //     });
              //   },
              // ),
            ],
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: CustomRaisedButton(
            buttonText: isGetOTP ? "Update Password" : "Get OTP",
            loadingValue: _isLoading,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            onPressed: () async {
              if (!isGetOTP) {
                // Step 1: Request OTP
                if (userIdCtrl.text.isNotEmpty) {
                  _isLoading = true;
                  try {
                    Map<String, dynamic> requestBody = {
                      "Cmp_Code": 1, // Assuming company code is always 1
                      "UserName": userIdCtrl.text,
                    };

                    Map response = await RestAPI().post(
                      APis.forgotPasswordOtp,
                      params: requestBody,
                    );

                    _isLoading = false;

                    if (response["ProceedStatus"] == "Y" &&
                        response["Data"][0]["Proceed_Status"] == "Y") {
                      GlobalWidgets().showSnackBar(
                        context,
                        "OTP sent to your mobile number",
                      );
                      setState(() {
                        isGetOTP = true;
                      });
                    } else {
                      String errorMessage =
                          response["Data"][0]["Procees_Message"] ??
                          "Invalid User ID";
                      GlobalWidgets().showSnackBar(context, errorMessage);
                    }
                  } catch (e) {
                    _isLoading = false;
                    GlobalWidgets().showSnackBar(context, "Failed to send OTP");
                  }
                } else {
                  GlobalWidgets().showSnackBar(context, "Please enter User ID");
                }
              } else {
                // Step 2: Verify OTP and change password
                bool passValue = passCtrl.text.contains(
                  RegExp(r"^[a-zA-Z0-9]+$"),
                );

                if (passValue) {
                  GlobalWidgets().showSnackBar(
                    context,
                    "Please include special characters in password",
                  );
                } else if (passCtrl.text != rePassCtrl.text) {
                  GlobalWidgets().showSnackBar(context, "Password miss match");
                } else if (passCtrl.text.contains(" ")) {
                  GlobalWidgets().showSnackBar(
                    context,
                    "Please remove space from password",
                  );
                } else if (userIdCtrl.text.isEmpty ||
                    otpCtrl.text.isEmpty ||
                    passCtrl.text.isEmpty) {
                  GlobalWidgets().showSnackBar(
                    context,
                    "Please fill all fields",
                  );
                } else {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    Map<String, dynamic> requestBody = {
                      "Cmp_Code": 1,
                      "User_Name": userIdCtrl.text,
                      "Password": passCtrl.text,
                      "OTP": otpCtrl.text,
                    };

                    print(
                      "Cmp_Code: 1,User_Name: ${userIdCtrl.text},Password: ${passCtrl.text},OTP: ${otpCtrl.text}",
                    );

                    Map response = await RestAPI().post(
                      APis.changeForgotPass,
                      params: requestBody,
                    );

                    setState(() {
                      _isLoading = false;
                    });

                    if (response["ProceedStatus"] == "Y" &&
                        response["Data"][0]["Proceed_Status"] == "Y") {
                      GlobalWidgets().showSnackBar(
                        context,
                        "Password changed successfully",
                      );
                      widget.onTap!();
                    } else {
                      String errorMessage =
                          response["Data"][0]["Proceed_Message"] ??
                          "Something went wrong";
                      GlobalWidgets().showSnackBar(context, errorMessage);
                    }
                  } on RestException catch (e) {
                    setState(() {
                      _isLoading = false;
                    });
                    GlobalWidgets().showSnackBar(
                      context,
                      e.message["ProceedMessage"],
                    );
                  } catch (e) {
                    setState(() {
                      _isLoading = false;
                    });
                    GlobalWidgets().showSnackBar(
                      context,
                      "Failed to change password",
                    );
                  }
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
