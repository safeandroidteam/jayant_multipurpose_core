import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/Logout.dart';
import 'package:passbook_core_jayant/MainScreens/AccountMenus.dart';
import 'package:passbook_core_jayant/MainScreens/Login.dart';
import 'package:passbook_core_jayant/MainScreens/sub_page.dart';
import 'package:passbook_core_jayant/Setting.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:passbook_core_jayant/configuration.dart';
import 'package:passbook_core_jayant/speechRecognition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PassbookMenus.dart';

class HomePage extends StatefulWidget {
  final HomePageConfiguration? homePageConfiguration;

  const HomePage({
    Key? key,
    required this.homePageConfiguration,
    this.defaultScreen,
  }) : super(key: key);
  final Widget? defaultScreen;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int bottomNavigationIndex = 1;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String? acc;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show an alert dialog when the user presses the back button
        return await (showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Do you want to Logout?'),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).cardColor,
                    ),
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('No'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Theme.of(context).errorColor,
                      backgroundColor: Colors.red,
                    ),
                    onPressed:
                        () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()),
                        ),
                    child: Text('Yes'),
                  ),
                ],
              ),
        ));
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Theme.of(context).primaryColor,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              bottomNavigationIndex = index;
            });
          },
          currentIndex: bottomNavigationIndex,
          elevation: 6.0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
          items: _bottomNavigationItem(),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            heyBank();
            //				    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VoiceCommander()));
          },
          mini: true,
          child: Icon(Icons.mic),
        ),
        body: SafeArea(
          child: IndexedStack(
            index: bottomNavigationIndex,
            children: [
              Settings(),
              SubPage(
                scaffoldKey: _scaffoldKey,
                homePageConfiguration: widget.homePageConfiguration,
              ),
              // Container()
              Logout(),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil("/LoginPage", (_) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Would you like to logout?"),
      actions: [cancelButton, continueButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationItem() {
    return [
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/settings.png",
          height: 25.0,
          width: 25.0,
          color:
              bottomNavigationIndex == 0
                  ? Theme.of(context).primaryColor
                  : Colors.black,
        ),
        label: "Settings",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/home.png",
          height: 25.0,
          width: 25.0,
          color:
              bottomNavigationIndex == 1
                  ? Theme.of(context).primaryColor
                  : Colors.black,
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/logout.png",
          height: 25.0,
          width: 25.0,
          color:
              bottomNavigationIndex == 2
                  ? Theme.of(context).primaryColor
                  : Colors.black,
        ),
        label: "Logout",
      ),
    ];
  }

  void heyBank() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return VoiceCommander(
              commands: (String commands) async {
                print(commands);
                if (commands.contains("open account")) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AccountMenus()),
                  );
                } else if (commands.contains("get detail")) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PassbookMenus()),
                  );
                } else if (commands.toLowerCase().contains("qr scan")) {
                  print("scan");
                  Navigator.pop(context);
                  SharedPreferences? preferences =
                      StaticValues.sharedPreferences;
                  GlobalWidgets().shoppingPay(
                    context,
                    setState,
                    _scaffoldKey,
                    preferences?.getString(StaticValues.accNumber) ?? "",
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
