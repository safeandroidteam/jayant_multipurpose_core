import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/MainScreens/ChittyLoan.dart';
import 'package:passbook_core_jayant/Passbook/PassbookDPSH.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';

class PassbookMenus extends StatefulWidget {
  const PassbookMenus({super.key});

  @override
  _PassbookMenusState createState() => _PassbookMenusState();
}

class _PassbookMenusState extends State<PassbookMenus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Passbook", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Stack(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: .8,
                  children: <Widget>[
                    GlobalWidgets().gridWidget(
                      context: context,
                      imageName: 'assets/deposit.png',
                      name: "Deposit",
                      onPressed:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PassbookDPSH(type: "DP"),
                            ),
                          ),
                    ),
                    GlobalWidgets().gridWidget(
                      context: context,
                      imageName: 'assets/loan.png',
                      name: "Loan",
                      onPressed:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ChittyLoan(type: "LN", isAccount: false),
                            ),
                          ),
                    ),
                    GlobalWidgets().gridWidget(
                      context: context,
                      imageName: 'assets/chitty.png',
                      name: "Chitty",
                      onPressed:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => ChittyLoan(
                                    type: "MMBS",
                                    isAccount: false,
                                  ),
                            ),
                          ),
                    ),
                    GlobalWidgets().gridWidget(
                      context: context,
                      imageName: 'assets/share.png',
                      name: "Share",
                      onPressed:
                          () =>
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text("Please Contact Branch")),
                          // ),
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PassbookDPSH(type: "SH"),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset("assets/safesoftware_logo.png", width: 200),
            ),
          ],
        ),
      ),
    );
  }
}
