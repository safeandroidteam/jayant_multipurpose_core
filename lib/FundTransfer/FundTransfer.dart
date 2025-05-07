import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/FundTransfer/Beneficiary.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/PeopleModel.dart';
import 'package:passbook_core_jayant/FundTransfer/OtherBankTransfer.dart';
import 'package:passbook_core_jayant/FundTransfer/OwnBankTransfer.dart';
import 'package:passbook_core_jayant/QRCodeGen/AccountNoModel.dart';
import 'package:passbook_core_jayant/QRCodeGen/QrCodeModel.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FundTransfer extends StatefulWidget {
  const FundTransfer({Key? key}) : super(key: key);

  @override
  _FundTransferState createState() => _FundTransferState();

  //  @override
  //  _FundTransfer2State createState() => _FundTransfer2State();
}

class _FundTransferState extends State<FundTransfer>
    with SingleTickerProviderStateMixin {
  String acc = "", name = "";
  GlobalKey<ScaffoldState>? scaffoldKey;
  final _peopleKey = GlobalKey();
  Uint8List? _bytesImage;
  List accNo = [];
  List<AccNoModel> accountList = [];
  late String imgBase64;

  ScrollController _customScrollController = ScrollController();
  SharedPreferences? preferences;
  People people = People();

  void loadData() async {
    preferences = StaticValues.sharedPreferences;
    setState(() {
      acc = preferences?.getString(StaticValues.accNumber) ?? "";
      name = preferences?.getString(StaticValues.accName) ?? "";

      accNo.add(acc);
    });
  }

  Future<Map?> fetchBeneficiary() async {
    var id = preferences?.getString(StaticValues.custID);
    print("ID :: $id");
    return await RestAPI().get(APis.fetchBeneficiary(id));
  }

  Future<Map?> deleteBeneficiary(String recieverId) async {
    return await RestAPI().get(APis.deleteBeneficiary(recieverId));
  }

  Future<QrCodeModel> getQrList() async {
    var response1 = await RestAPI().post(
      APis.upiQrCode,
      params: {"Acc_No": acc},
    );

    List<QrCodeModel> qrCodeList = qrCodeModelFromJson(json.encode(response1));

    imgBase64 = qrCodeList[0].qrCode!.split(",")[1];
    //  print("LIJU${snapshot.data.qrCode}");

    _bytesImage = Base64Decoder().convert(imgBase64);
    print("QRCODE : ${_bytesImage.toString()}");

    return qrCodeList[0];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    scaffoldKey = GlobalKey();
    loadData();
    //   getQrList();

    super.initState();
  }

  Widget options() {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView(
        shrinkWrap: true,
        itemExtent: 80.0,
        scrollDirection: Axis.horizontal,
        children: [
          GlobalWidgets().btnWithText(
            icon: Image.asset(
              "assets/otherBankTransfer.png",
              height: 30.0,
              width: 30.0,
              color: Theme.of(context).primaryColor,
            ),
            name: "Other Bank Transfer",
            onPressed: () {
              Scrollable.ensureVisible(
                _peopleKey.currentContext!,
                duration: Duration(milliseconds: 350),
                curve: Curves.easeIn,
              );
            },
          ),
          GlobalWidgets().btnWithText(
            icon: Icon(
              Icons.add,
              size: 30.0,
              color: Theme.of(context).primaryColor,
            ),
            name: "Add Beneficiary",
            onPressed: () async {
              var result = await Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => Beneficiary()));
              print("RESULT ::: $result");
              fetchBeneficiary();
              setState(() {});
            },
          ),
          GlobalWidgets().btnWithText(
            icon: Image.asset(
              "assets/ownBankTransfer.png",
              height: 30.0,
              width: 30.0,
              color: Theme.of(context).primaryColor,
            ),
            name: "Own Bank Transfer",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => OwnBankTransfer()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:
          () async {
                return Navigator.of(context).pushReplacementNamed("/HomePage")
                    as FutureOr<bool>;
              }
              as Future<bool> Function()?,
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _customScrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 1.30,
                  pinned: true,
                  centerTitle: true,
                  title: Text(
                    "Fund Transfer",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).pushReplacementNamed("/HomePage"),
                  ),
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    stretchModes: [
                      StretchMode.fadeTitle,
                      StretchMode.blurBackground,
                    ],
                    background: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /*     QrImage(
                                data: acc,
                                version: QrVersions.auto,
                                size: 200.0,
                                foregroundColor: Colors.white,
                              ),*/
                              FutureBuilder<QrCodeModel>(
                                future: getQrList(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    String imgBase64 =
                                        snapshot.data!.qrCode!.split(",")[1];
                                    print("LIJU${snapshot.data!.qrCode}");

                                    Uint8List _bytesImage = Base64Decoder()
                                        .convert(imgBase64);
                                    print("LIJU${_bytesImage.toString()}");

                                    return Container(
                                      height: 200.0,
                                      width: 200.0,
                                      child: Image.memory(_bytesImage),
                                    );
                                  } else {
                                    return Container(
                                      // child: Text("Please Select AccNo"),
                                    );
                                  }
                                },
                              ),

                              //  _bytesImage = Base64Decoder().convert(_imgString);

                              //   Image.memory(_bytesImage)
                              SizedBox(height: 10.0),
                              TextView(name, color: Colors.white, size: 18),
                              TextView(acc, size: 16.0, color: Colors.white),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.all(20.0),
                            icon: Image.asset(
                              "assets/qr-code.png",
                              color: Colors.white,
                            ),
                            /* onPressed: () {
                                  GlobalWidgets().shoppingPay(
                                      scaffoldKey.currentContext,
                                      setState,
                                      scaffoldKey,
                                      acc);
                                }*/
                            onPressed: () {
                              GlobalWidgets().shoppingPay(
                                scaffoldKey!.currentContext!,
                                setState,
                                scaffoldKey,
                                acc,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  key: _peopleKey,
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              width: 25.0,
                              height: 5.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          LimitedBox(maxHeight: 120.0, child: options()),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 21.0,
                              left: 12.0,
                            ),
                            child: TextView(
                              "People",
                              size: 20.0,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          FutureBuilder<Map?>(
                            future: fetchBeneficiary(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                people = People.fromJson(
                                  snapshot.data as Map<String, dynamic>,
                                );
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10.0,
                                      ),
                                  physics: NeverScrollableScrollPhysics(),
                                  primary: true,
                                  shrinkWrap: true,
                                  itemCount: people.table!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onLongPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Are you sure?"),
                                              content: TextView(
                                                "Do you want delete ${people.table![index].recieverName} beneficiary",
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Theme.of(
                                                              context,
                                                            ).primaryColor,
                                                      ),
                                                  onPressed:
                                                      () =>
                                                          Navigator.of(
                                                            context,
                                                          ).pop(),
                                                  child: TextView(
                                                    "No",
                                                    size: 14.0,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.0,
                                                          ),
                                                    ),
                                                    backgroundColor:
                                                        Theme.of(
                                                          context,
                                                        ).cardColor,
                                                    padding: EdgeInsets.all(
                                                      5.0,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    await deleteBeneficiary(
                                                      people
                                                          .table![index]
                                                          .recieverId!
                                                          .round()
                                                          .toString(),
                                                    );
                                                    fetchBeneficiary();
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: TextView(
                                                    "Yes",
                                                    size: 12.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          SizeRoute(
                                            page: OtherBankTransfer(
                                              peopleTable: people.table![index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Card(
                                            elevation: 6.0,
                                            shape: CircleBorder(),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                15.0,
                                              ),
                                              child: Image.asset(
                                                "assets/otherBankTransfer.png",
                                                height: 30.0,
                                                width: 30.0,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).primaryColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          TextView(
                                            toBeginningOfSentenceCase(
                                              people.table![index].recieverName,
                                            ),
                                          ),
                                          TextView(
                                            toBeginningOfSentenceCase(
                                              people
                                                  .table![index]
                                                  .recieverAccno,
                                            ),
                                            size: 10.0,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SizeRoute extends PageRouteBuilder {
  final Widget? page;

  SizeRoute({this.page})
    : super(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page!,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) => Align(
              child: SizeTransition(sizeFactor: animation, child: child),
            ),
      );
}
