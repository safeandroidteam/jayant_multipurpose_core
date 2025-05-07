import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';

import 'AccountSearch.dart';

class SearchHome extends StatefulWidget {
  @override
  _SearchHomeState createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Home", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                              builder: (context) => AccountSearch("Account"),
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
                              builder: (context) => AccountSearch("Loan"),
                            ),
                          ),
                    ),
                    Visibility(
                      visible: false,
                      child: GlobalWidgets().gridWidget(
                        context: context,
                        imageName: 'assets/chitty.png',
                        name: "Chitty",
                        /* onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AccountSearch())),*/
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: GlobalWidgets().gridWidget(
                        context: context,
                        imageName: 'assets/share.png',
                        name: "Share",
                        /* onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AccountSearch())),*/
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*   Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/safesoftware_logo.png",
                  width: 200,
                ))*/
          ],
        ),
      ),
    );
  }
}
