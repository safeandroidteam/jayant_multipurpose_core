import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/AccountOpen/AccoutOpenHome.dart';
import 'package:passbook_core_jayant/Cards/CardBlock.dart';
import 'package:passbook_core_jayant/Cards/CardReset.dart';
import 'package:passbook_core_jayant/Cards/CardStatement.dart';
import 'package:passbook_core_jayant/Cards/CardTopup.dart';
import 'package:passbook_core_jayant/FundTransfer/FundTransfer.dart';
import 'package:passbook_core_jayant/MainScreens/AccountMenus.dart';
import 'package:passbook_core_jayant/MainScreens/PassbookMenus.dart';
import 'package:passbook_core_jayant/PayBills/Recharge.dart';
import 'package:passbook_core_jayant/Search/SearchHome.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:passbook_core_jayant/passbook_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configuration.dart';

class SubPage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final HomePageConfiguration? homePageConfiguration;

  const SubPage({Key? key, this.scaffoldKey, this.homePageConfiguration})
    : super(key: key);

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> with TickerProviderStateMixin {
  SharedPreferences? preferences;
  var userId = "", acc = "", ifsc = "", name = "", address = "";
  double _iconSize = 25.0;

  Timer? _countdownTimer;

  void loadData() async {
    preferences = StaticValues.sharedPreferences;
    setState(() {
      userId = preferences?.getString(StaticValues.custID) ?? "";
      acc = preferences?.getString(StaticValues.accountNo) ?? "";
      ifsc = preferences?.getString(StaticValues.ifsc) ?? "";
      name = preferences?.getString(StaticValues.accName) ?? "";
      address = preferences?.getString(StaticValues.address) ?? "";
      print("userName");
      print(userId);
      print(acc);
      print(name);
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async{
        if(state == AppLifecycleState.paused){
          _countdownTimer = Timer(Duration(seconds: 60), Duration(seconds: 1));
        }
        else if(state == AppLifecycleState.resumed){
          if(_countdownTimer.remaining > Duration(seconds: 0)){
            print("AppLifecycle State timer didnt compleate");
          }
          else{
            print("AppLifecycleState timeout");
          }
          _countdownTimer.cancel();
        }
  }*/

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      setState(() {
        print("In Active");
        Navigator.pop(context);
      });
    } else {
      print(state.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            expandedHeight: MediaQuery.of(context).size.width * .90,
            pinned: false,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: [StretchMode.fadeTitle, StretchMode.blurBackground],
              background: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: -30,
                    right: -20,
                    child: Image.asset(
                      "assets/mini-logo.png",
                      width: 150,
                      height: 150,
                      color: Colors.white10,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextView(
                            "Hello,",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 24.0,
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                name ?? "",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                size: 16,
                              ),
                              TextView(
                                acc ?? "",
                                color: Colors.white,
                                size: 14.0,
                              ),
                              TextView(
                                "Ifsc Code : $ifsc" ?? "",
                                color: Colors.white,
                                size: 14.0,
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                          subtitle: TextView(
                            address ?? "",
                            color: Colors.white,
                            size: 12,
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            backgroundImage: AssetImage("assets/people.png"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Bank Name change here
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ListTile(
                      title: TextView(
                        StaticValues.titleDecoration!.label!.toUpperCase(),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextView("Banking", fontWeight: FontWeight.bold),
              ),
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 20,
                ),
                children: <Widget>[
                  GlobalWidgets().btnWithText(
                    icon: Image.asset(
                      'assets/account.png',
                      height: _iconSize,
                      width: _iconSize,
                      color: Theme.of(context).focusColor,
                    ),
                    name: "Account",
                    onPressed:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AccountMenus(),
                          ),
                        ),
                  ),
                  GlobalWidgets().btnWithText(
                    icon: Image.asset(
                      'assets/passbook.png',
                      height: _iconSize,
                      width: _iconSize,
                      color: Theme.of(context).focusColor,
                    ),
                    name: "Passbook",
                    onPressed:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PassbookMenus(),
                          ),
                        ),
                  ),
                  Visibility(
                    visible: widget.homePageConfiguration!.fundTransferOption,
                    child: GlobalWidgets().btnWithText(
                      icon: Image.asset(
                        'assets/fundTransfer.png',
                        height: _iconSize,
                        width: _iconSize,
                        color: Theme.of(context).focusColor,
                      ),
                      name: "Transfer",
                      //  onPressed: () => Navigator.of(context).pushNamed("/HomePage"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FundTransfer(),
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: widget.homePageConfiguration!.search,
                    child: GlobalWidgets().btnWithText(
                      icon: Image.asset(
                        'assets/search.png',
                        height: _iconSize,
                        width: _iconSize,
                        color: Theme.of(context).focusColor,
                      ),
                      name: "Search",
                      //   onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchHome())),
                      onPressed:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchHome(),
                            ),
                          ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: widget.homePageConfiguration!.rechargeOption,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextView("Cards", fontWeight: FontWeight.bold),
                    ),
                    GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 20,
                      ),
                      children: <Widget>[
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/credit_card.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "Card Topup",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CardTopup(),
                                ),
                              ),
                        ),
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/credit_card2.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "Card History",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CardStatement(),
                                ),
                              ),
                        ),
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/credit_card3.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "New Pin",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CardReset(),
                                ),
                              ),
                          /*onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => KSEBNKWA(
                                  title: "KSEB",
                                )))*/
                        ),
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/credit_block.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "Card Block",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CardBlock(),
                                ),
                              ),
                          /*onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => KSEBNKWA(
                                  title: "KSEB",
                                )))*/
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.homePageConfiguration!.rechargeOption,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextView(
                        "Recharge & Pay Bills",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 20,
                      ),
                      children: <Widget>[
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/smartphone.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "Recharge",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          Recharge(title: "Mobile Recharge"),
                                ),
                              ),
                        ),
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/mobile_card.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "Postpaid",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          Recharge(title: "Postpaid Recharge"),
                                ),
                              ),
                        ),
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/dishTv.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "DTH",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          Recharge(title: "DTH Recharge"),
                                ),
                              ),
                        ),
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/electricity.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "Electricity",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          Recharge(title: "Electricity"),
                                ),
                              ),
                          /*onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => KSEBNKWA(
                                  title: "KSEB",
                                )))*/
                        ),
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/water.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "Water",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => Recharge(title: "Water"),
                                ),
                              ),
                          /* onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => KSEBNKWA(
                                  title: "KWA",
                                )))*/
                        ),
                        Visibility(
                          visible: widget.homePageConfiguration!.shoppingOption,
                          child: GlobalWidgets().btnWithText(
                            icon: Image.asset(
                              'assets/shopping.png',
                              height: _iconSize,
                              width: _iconSize,
                              color: Theme.of(context).focusColor,
                            ),
                            name: "Shopping",
                            onPressed:
                                () => GlobalWidgets().shoppingPay(
                                  widget.scaffoldKey!.currentContext!,
                                  setState,
                                  widget.scaffoldKey,
                                  acc,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.homePageConfiguration!.rechargeOption,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextView(
                        "Account Opening",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 20,
                      ),
                      children: <Widget>[
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/fd2.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "FD",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AccountOpenHome("FD"),
                                ),
                              ),
                        ),
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/rd.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "RD",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AccountOpenHome("RD"),
                                ),
                              ),
                        ),
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/bank_check.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "DD",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AccountOpenHome("DD"),
                                ),
                              ),
                        ),
                        GlobalWidgets().btnWithText(
                          icon: Image.asset(
                            'assets/credit-card.png',
                            height: _iconSize,
                            width: _iconSize,
                            color: Theme.of(context).focusColor,
                          ),
                          name: "UNNATI",
                          onPressed:
                              () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => AccountOpenHome("UNNATI"),
                                ),
                              ),
                        ),
                        Visibility(
                          visible: widget.homePageConfiguration!.shoppingOption,
                          child: GlobalWidgets().btnWithText(
                            icon: Image.asset(
                              'assets/mis.png',
                              height: _iconSize,
                              width: _iconSize,
                              color: Theme.of(context).focusColor,
                            ),
                            name: "MIS",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AccountOpenHome("MIS"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              /*     Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: .5,
                  child: Image.asset(
                    "assets/safesoftware_logo.png",
                    width: 100,
                  ),
                ),
              ),*/
            ]),
          ),
        ],
      ),
    );
  }
}
