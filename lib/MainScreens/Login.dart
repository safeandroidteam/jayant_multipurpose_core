import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:passbook_core_jayant/MainScreens/Model/LoginModel.dart';
import 'package:passbook_core_jayant/MainScreens/Register.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  ///Login Credentials
  ///Username = NIRAJ
  ///Password = 1982

  int indexPage = 0;
  PageController _pageController = PageController(initialPage: 1);
  AnimationController? _animationController, _floatingAnimationController;
  Animation<double>? _animation, _floatingAnimation;
  static const int pageCtrlTime = 550;
  static const _animationCurves = Curves.fastLinearToSlowEaseIn;
  static const _pageCurves = Curves.easeIn;
  GlobalKey _regToolTipKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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

    print(
      "appName $appName,"
      "\nPackageName $packageName"
      "\nVERSION FE $version"
      // "\nVERSION BE ${(versionMap["Table"][0]["Ver_Name"] as double).toString()}"
      "\nVersion BE ${(versionMap["Table"][0]["Ver_Name"]).toString()}"
      "\nBuildNumber FE $buildNumber"
      "\nBuildNumber BE ${(versionMap["Table"][0]["Ver_Code"] as double).round().toString()}",
      // "\nBuildNumber BE ${(double.parse(versionMap["Table"][0]["Ver_Code"])).round().toString()}"
    );

    /* if (versionMap["Table"][0]["Ver_Name"].toString() != version &&
        versionMap["Table"][0]["Ver_Code"].toString() != buildNumber) {*/
    // if ((versionMap["Table"][0]["Ver_Code"] as double).round().toString() !=
    //     buildNumber) {
    if (versionMap["Table"][0]["Ver_Name"].toString() != version ||
        ((versionMap["Table"][0]["Ver_Code"]) as double).round().toString() !=
            buildNumber) {
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text("Update"),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
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
    //   debugPrint("MPIN : $MPin");
    /*  Future.delayed(Duration.zero, () {
      termsAndConditions();
    });*/

    //  String myTerms = prefs.getString('Accept_Terms');

    /*  if(myTerms != "true"){

    }*/

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
                              MediaQuery.of(context).size.height * .05),
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
                      child: Icon(Icons.add, color: Colors.white),
                      elevation: 8.0,
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

  const LoginUI({Key? key, this.onTap, required this.scaffold, this.forgotUser})
    : super(key: key);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
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
  var _pass;
  bool isLoading = false;
  int count = 0;

  void saveData(LoginModel loginModel) async {
    SharedPreferences preferences = StaticValues.sharedPreferences!;
    print("CUST ID :: ${loginModel.table![0].toString()}");
    await preferences.setString(
      StaticValues.custID,
      loginModel.table![0].custId.toString(),
    );
    await preferences.setString(
      StaticValues.branchCode,
      loginModel.table![0].brCode.toString(),
    );
    await preferences.setString(
      StaticValues.schemeCode,
      loginModel.table![0].schCode.toString(),
    );
    await preferences.setString(
      StaticValues.accNumber,
      loginModel.table![0].accNo.toString(),
    );
    await preferences.setString(
      StaticValues.ifsc,
      loginModel.table![0].ifsc.toString(),
    );
    await preferences.setString(
      StaticValues.accName,
      loginModel.table![0].custName.toString(),
    );
    await preferences.setString(
      StaticValues.mobileNo,
      loginModel.table![0].mobile.toString(),
    );
    await preferences.setString(
      StaticValues.accountNo,
      loginModel.table![0].accountNo.toString(),
    );
    //  await preferences.setString(StaticValues.userPass, passCtrl.text);
    await preferences.setString(
      StaticValues.address,
      loginModel.table![0].adds!
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
    debugPrint("MPIN : ${allMpinCtrl.text}");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      SharedPreferences pref = StaticValues.sharedPreferences!;
      MPin = pref.getString(StaticValues.Mpin);
      strCustName = pref.getString(StaticValues.accName);
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
                Container(
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

                          // EditTextBordered(
                          //   controller: mpinCtrl,
                          //   hint: "MPin",
                          //   errorText:
                          //       mpinVal ? "MPin length should be 4" : null,
                          //   keyboardType: TextInputType.number,
                          //   inputFormatters: [
                          //     LengthLimitingTextInputFormatter(4),
                          //     FilteringTextInputFormatter.digitsOnly,
                          //   ],
                          //   // obscureText: true,
                          //   // showObscureIcon: true,
                          //   onChange: (value) {
                          //     setState(() {
                          //       mpinVal = value.trim().length < 4;
                          //     });
                          //   },
                          // ),
                          SizedBox(
                            width: width * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SingleDigitTextField(
                                  controller: mPinCtrl1,
                                  autoFocus: false,
                                  obscureText: true,
                                ),
                                SingleDigitTextField(
                                  controller: mPinCtrl2,
                                  autoFocus: false,
                                  obscureText: true,
                                ),
                                SingleDigitTextField(
                                  controller: mPinCtrl3,
                                  autoFocus: false,
                                  obscureText: true,
                                ),
                                SingleDigitTextField(
                                  controller: mPinCtrl4,
                                  autoFocus: false,
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
                                mobVal = value.trim().length == 0;
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
                          mobVal = value.trim().length == 0;
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

              ///Toogle To Login with MPIN or Username
              // if (MPin != null)
              //   TextButton(
              //     onPressed: () {
              //       setState(() {
              //         mpinCtrl.clear();
              //         isLoginWithUsername = !isLoginWithUsername;
              //       });
              //     },
              //     child: Text(
              //       isLoginWithUsername
              //           ? "Login with MPIN"
              //           : "Login with Username",
              //     ),
              //   ),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
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
            debugPrint(usernameCtrl.text);
            mergeMPinCtrlValues();
            setState(() {
              passVal = passCtrl.text.trim().length < 4;
              mobVal = usernameCtrl.text.trim().length == 0;
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
                debugPrint("Login UN & PW > ALL true");
                _isLoading = true;
                try {
                  response = await RestAPI().get(
                    "${APis.loginUrl}Mob_no=${usernameCtrl.text}&pwd=${passCtrl.text}&IMEI=863675039500942",
                  );

                  setState(() async {
                    _isLoading = false;
                    if (response!.toString().length == 0 ||
                        response == null ||
                        response!.isEmpty) {
                      GlobalWidgets().showSnackBar(
                        context,
                        "Something went wrong",
                      );
                      return;
                    }
                    //   if ((response["Table"][0] as Map).containsKey("Invalid")) {
                    if (response!["Table"][0]["Cust_id"] == "Invalid") {
                      setState(() {
                        _isLoading = false;
                      });
                      print("LIJITH");
                      GlobalWidgets().showSnackBar(
                        context,
                        // response!["Table"][0]["Cust_id"],
                        response!["Table"][0]["Msg"],
                      );
                    } else if (response!["Table"][0]["Cust_id"] == "Blocked") {
                      setState(() {
                        _isLoading = false;
                      });
                      //  if (response["Table"][0]["Cust_id"] == "Invalid"){
                      print("Blocked");
                      GlobalWidgets().showSnackBar(
                        context,
                        response!["Table"][0]["Msg"],
                      );
                    } else {
                      // usernameCtrl.clear();
                      // passCtrl.clear();
                      var response1 = await RestAPI().post(
                        APis.GenerateOTP,
                        params: {
                          "MobileNo": response!["Table"][0]["Mobile"],
                          "Amt": "0",
                          "SMS_Module": "GENERAL",
                          "SMS_Type": "GENERAL_OTP",
                          "OTP_Return": "Y",
                        },
                      );
                      debugPrint("rechargeResponse::: $response1");
                      str_Otp = response1[0]["OTP"];

                      //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str_Message)));
                      //  RestAPI().get(APis.rechargeMobile(params));
                      /*    Map response =
                            await RestAPI().get(APis.rechargeMobile(params));*/
                      //   getMobileRecharge();
                      setState(() {
                        //     isLoading = false;

                        Timer(Duration(minutes: 5), () {
                          setState(() {
                            str_Otp = "";
                          });
                        });
                      });

                      ///TODO  for otp while login
                      _loginConfirmation();

                      /*LoginModel login = LoginModel.fromJson(response);
                        saveData(login);*/
                    }
                  });
                } on RestException catch (e) {
                  setState(() {
                    _isLoading = false;
                  });

                  GlobalWidgets().showSnackBar(context, e.message);
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

                // getMPinCtrlValues();

                response = await RestAPI().get(
                  // "${APis.loginMPin}CustId=${pref.getString(StaticValues.custID)}&MPin=${mpinCtrl.text}",
                  "${APis.loginMPin}CustId=${pref.getString(StaticValues.custID)}&MPin=${allMpinCtrl.text}",
                );
                /*   response = await RestAPI().post(APis.loginMpin,params: {

                      "CustID": "1010001",
                      "MPIN": mpinCtrl.text
                    });*/

                setState(() async {
                  _isLoading = false;
                  /*     if ((response["Table"][0] as Map).containsKey("Invalid")) {
                    //  if (response["Table"][0]["Cust_id"] == "Invalid"){
                        print("Invalis");
                        GlobalWidgets()
                            .showSnackBar(widget.scaffold, "Invalid Credentials");
                      }
                 if ((response["Table"][0] as Map).containsKey("Blocked")) {
                        //  if (response["Table"][0]["Cust_id"] == "Invalid"){
                        print("Blocked");
                        GlobalWidgets()
                            .showSnackBar(widget.scaffold, "Your Account is Blocked");
                      }*/
                  if ((response!["Table"][0]["Cust_id"]) == "Invalid") {
                    print("LIJITH");
                    setState(() {
                      _isLoading = false;
                    });
                    GlobalWidgets().showSnackBar(
                      context,
                      response!["Table"][0]["Cust_id"],
                    );
                  }
                  if (response!["Table"][0]["Cust_id"] == "Blocked") {
                    //  if (response["Table"][0]["Cust_id"] == "Invalid"){
                    setState(() {
                      _isLoading = false;
                    });
                    print("Blocked");
                    GlobalWidgets().showSnackBar(
                      context,
                      response!["Table"][0]["Msg"],
                    );
                  } else {
                    var response1 = await RestAPI().post(
                      APis.GenerateOTP,
                      params: {
                        "MobileNo": response!["Table"][0]["Mobile"],
                        "Amt": "0",
                        "SMS_Module": "GENERAL",
                        "SMS_Type": "GENERAL_OTP",
                        "OTP_Return": "Y",
                      },
                    );
                    print("rechargeResponse::: $response1");
                    str_Otp = response1[0]["OTP"];

                    //   getMobileRecharge();
                    setState(() {
                      //     isLoading = false;

                      Timer(Duration(minutes: 5), () {
                        setState(() {
                          str_Otp = "";
                        });
                      });
                    });

                    ///TODO  for otp while login
                    _loginConfirmation();

                    /* LoginModel login = LoginModel.fromJson(response);
                        saveData(login);*/
                  }
                });
              } on RestException catch (e) {
                setState(() {
                  _isLoading = false;
                });

                GlobalWidgets().showSnackBar(context, e.message);
              }
            }
            // }
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

  void _loginConfirmation() {
    isLoading = false;
    var _pass;
    GlobalWidgets().validateOTP(
      context,
      getValue: (passVal) {
        setState(() {
          _pass = passVal;
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
              buttonText:
                  isLoading ? CircularProgressIndicator() as String : "LOGIN",
              onPressed:
                  isLoading
                      ? () {}
                      : () async {
                        if (_pass == str_Otp) {
                          if (MPin == null) {
                            SharedPreferences preferences =
                                StaticValues.sharedPreferences!;
                            preferences.setString(
                              StaticValues.userPass,
                              passCtrl.text,
                            );
                            LoginModel login = LoginModel.fromJson(
                              response as Map<String, dynamic>,
                            );
                            saveData(login);
                            print("LIJU");
                          } else {
                            LoginModel login = LoginModel.fromJson(
                              response as Map<String, dynamic>,
                            );
                            saveData(login);
                            // usernameCtrl.clear();
                            // passCtrl.clear();
                            print("LIJU");
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "OTP Miss match",
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

  const ForgotUI({Key? key, this.onTap, required this.scaffoldKey})
    : super(key: key);

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
              SizedBox(height: 10.0),
              EditTextBordered(
                controller: otpCtrl,
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
                //  errorText: passValid ? "Password length should be 4" : null,
                errorText:
                    passValid ? "Please include special charcters" : null,
                onChange: (value) {
                  setState(() {
                    //  passValid = value.trim().length < 4;
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
                if (userIdCtrl.text.length > 0) {
                  _isLoading = true;
                  Map response = await (RestAPI().get(
                    "${APis.getPassChangeOTP}UserId=${userIdCtrl.text}",
                  ));
                  _isLoading = false;
                  if (response["Table"][0]["statuscode"] == 1) {
                    strOtp = response["Table"][0]["OTP"];
                    GlobalWidgets().showSnackBar(context, "OTP sent");
                    setState(() {
                      isGetOTP = true;
                    });
                  } else {
                    GlobalWidgets().showSnackBar(context, "Invalid User ID");
                  }
                } else {
                  GlobalWidgets().showSnackBar(context, "Invalid User ID");
                }
              } else {
                bool passValue = passCtrl.text.contains(
                  new RegExp(r"^[a-zA-Z0-9]+$"),
                );
                if (passValue) {
                  GlobalWidgets().showSnackBar(
                    context,
                    "Please include special characters in password",
                  );
                } else if (strOtp != otpCtrl.text) {
                  GlobalWidgets().showSnackBar(context, "OTP miss match");
                } else if (passCtrl.text != rePassCtrl.text) {
                  GlobalWidgets().showSnackBar(context, "Password miss match");
                } else if (passCtrl.text.contains(" ")) {
                  GlobalWidgets().showSnackBar(
                    context,
                    "Please remove space from password",
                  );
                } else {
                  if (userIdCtrl.text.length <= 0 &&
                      otpCtrl.text.length < 4 &&
                      passCtrl.text.length < 4) {
                    GlobalWidgets().showSnackBar(
                      context,
                      "Please fill the missing fields",
                    );
                  } else {
                    _isLoading = true;
                    try {
                      Map response = await (RestAPI().post(
                        "${APis.changeForgotPass}userid=${userIdCtrl.text}&Newpassword=${passCtrl.text}",
                      ));
                      setState(() {
                        _isLoading = false;
                      });
                      if (response["Table"][0]["Column1"] ==
                          "Password Updated Successfully") {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Password changed successfully",
                        );
                        widget.onTap!();
                      } else {
                        GlobalWidgets().showSnackBar(
                          context,
                          "Something went wrong",
                        );
                      }
                      print(response);
                    } on RestException catch (e) {
                      setState(() {
                        _isLoading = false;
                      });

                      GlobalWidgets().showSnackBar(context, e.message);
                    }
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
