// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:passbook_core_jayant/Account/Model/AccountsDepositModel.dart';
// import 'package:passbook_core_jayant/Account/Model/AccountsLoanModel.dart';
// import 'package:passbook_core_jayant/MainScreens/CardsModel.dart';
// import 'package:passbook_core_jayant/MainScreens/bloc/bloc.dart';
// import 'package:passbook_core_jayant/Passbook/ChittyTransaction.dart';
// import 'package:passbook_core_jayant/Passbook/LoanTransaction.dart';
// import 'package:passbook_core_jayant/Passbook/Model/PassbookListModel.dart';
// import 'package:passbook_core_jayant/Passbook/PassbookDPSH.dart';
// import 'package:passbook_core_jayant/Util/util.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AccountMenus extends StatefulWidget {
//   const AccountMenus({Key? key}) : super(key: key);

//   @override
//   _AccountMenusState createState() => _AccountMenusState();
// }

// class _AccountMenusState extends State<AccountMenus>
//     with TickerProviderStateMixin {
//   SharedPreferences? preferences;
//   var userId = "", acc = "", name = "", address = "";
//   List<AccountsLoanTable>? _accLoanTableModel = [];
//   List<AccountsDepositTable>? _accDepositModel = [];
//   List<PassbookTable>? _chittyModel = [], _shareModel = [];
//   double _pageViewHeight = 200;
//   HomeBloc _homeBloc = HomeBloc(initialState: AccDepositLoading());

//   void loadData() async {
//     preferences = StaticValues.sharedPreferences;
//     setState(() {
//       userId = preferences?.getString(StaticValues.custID) ?? "";
//       acc = preferences?.getString(StaticValues.accNumber) ?? "";
//       name = preferences?.getString(StaticValues.accName) ?? "";
//       address = preferences?.getString(StaticValues.address) ?? "";
//       print("userName");
//       print(userId);
//       print(acc);
//       print(name);
//     });

//     _homeBloc.add(AccDepositEvent(userId));
//     _homeBloc.add(AccLoanEvent(userId));
//     _homeBloc.add(ChittyEvent(userId));
//     _homeBloc.add(ShareEvent(userId));
//   }

//   @override
//   void initState() {
//     loadData();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _homeBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           CustomScrollView(
//             physics: BouncingScrollPhysics(),
//             slivers: [
//               SliverAppBar(
//                 centerTitle: true,
//                 pinned: true,
//                 stretch: true,
//                 title: TextView(text:"Account", size: 20.0, color: Colors.white),
//                 leading: IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
//                   onPressed: () => Navigator.of(context).pop(),
//                 ),
//               ),
//               SliverSafeArea(
//                 sliver: SliverList(
//                   delegate: SliverChildListDelegate([
//                     BlocListener<HomeBloc, HomeState>(
//                       bloc: _homeBloc,
//                       listener: (context, snapshot) {
//                         if (snapshot is AccDepositResponse) {
//                           setState(() {
//                             _accDepositModel =
//                                 snapshot.accountsDepositModel.table;
//                           });
//                         }
//                         if (snapshot is AccLoanResponse) {
//                           setState(() {
//                             _accLoanTableModel =
//                                 snapshot.accountsLoanModel.table;
//                           });
//                         }
//                         if (snapshot is ChittyResponse) {
//                           setState(() {
//                             _chittyModel = snapshot.chittyListModel.table;
//                           });
//                         }
//                         if (snapshot is ShareResponse) {
//                           setState(() {
//                             _shareModel = snapshot.shareListModel.table;
//                           });
//                         }
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextView(text:
//                           "Deposit",
//                           size: 24.0,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff707070),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: _pageViewHeight,
//                       child: BlocBuilder<HomeBloc, HomeState>(
//                         bloc: _homeBloc,
//                         builder: (context, snapshot) {
//                           if (snapshot is AccDepositLoading) {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                           if (_accDepositModel!.length > 0) {
//                             return PageView.builder(
//                               itemCount: _accDepositModel!.length,
//                               scrollDirection: Axis.horizontal,
//                               controller: PageController(viewportFraction: .95),
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: DepositCardModel(
//                                     accountsDeposit: _accDepositModel![index],
//                                     onPressed: () {
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                           builder:
//                                               (context) =>
//                                                   PassbookDPSH(type: "DP"),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                             );
//                           }
//                           return Center(
//                             child: TextView(text:
//                               "You don't have a deposit in this bank",
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextView(text:
//                         "Loan",
//                         size: 24.0,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff707070),
//                       ),
//                     ),
//                     SizedBox(
//                       height: _pageViewHeight,
//                       child: BlocBuilder<HomeBloc, HomeState>(
//                         bloc: _homeBloc,
//                         builder: (context, snapshot) {
//                           if (snapshot is AccLoanLoading) {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                           if (_accLoanTableModel!.length > 0) {
//                             return PageView.builder(
//                               controller: PageController(viewportFraction: .95),
//                               itemCount: _accLoanTableModel!.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: LoanCardModel(
//                                     accountsLoanTable:
//                                         _accLoanTableModel![index],
//                                     onPressed: () {
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                           builder:
//                                               (context) => LoanTransaction(
//                                                 accNo:
//                                                     _accLoanTableModel![index]
//                                                         .loanNo,
//                                               ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                             );
//                           }
//                           return Center(
//                             child: TextView(text:
//                               "You don't have a loan in this bank",
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Visibility(
//                         visible: false,
//                         child: TextView(text:
//                           "Chitty",
//                           size: 24.0,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff707070),
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                       visible: false,
//                       child: SizedBox(
//                         height: _pageViewHeight,
//                         child: BlocBuilder<HomeBloc, HomeState>(
//                           bloc: _homeBloc,
//                           builder: (context, snapshot) {
//                             if (snapshot is ChittyLoading) {
//                               return Center(child: CircularProgressIndicator());
//                             }
//                             if (_chittyModel!.length > 0) {
//                               return PageView.builder(
//                                 controller: PageController(
//                                   viewportFraction: .95,
//                                 ),
//                                 itemCount: _chittyModel!.length,
//                                 scrollDirection: Axis.horizontal,
//                                 itemBuilder: (context, index) {
//                                   return Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: ChittyCardModel(
//                                       chittyListTable: _chittyModel![index],
//                                       onPressed: () {
//                                         Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                             builder:
//                                                 (context) => ChittyTransaction(
//                                                   accNo:
//                                                       _chittyModel![index]
//                                                           .accNo,
//                                                 ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   );
//                                 },
//                               );
//                             }
//                             return Center(
//                               child: TextView(text:
//                                 "You don't have a chitty in this bank",
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextView(text:
//                         "Share",
//                         size: 24.0,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff707070),
//                       ),
//                     ),
//                     SizedBox(
//                       height: _pageViewHeight,
//                       child: BlocBuilder<HomeBloc, HomeState>(
//                         bloc: _homeBloc,
//                         builder: (context, snapshot) {
//                           if (snapshot is ShareLoading) {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                           if (_shareModel!.length > 0) {
//                             return PageView.builder(
//                               controller: PageController(viewportFraction: .95),
//                               itemCount: _shareModel!.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: ShareCardModel(
//                                     shareListTable: _shareModel![index],
//                                     onPressed: () {
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                           builder:
//                                               (context) =>
//                                                   PassbookDPSH(type: "SH"),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                             );
//                           }
//                           return Center(
//                             child: TextView(text:
//                               "You don't have a share in this bank",
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 10.0),
//                     /*     Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Image.asset(
//                           "assets/safesoftware_logo.png",
//                           width: 200,
//                         )),*/
//                   ]),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsDepositModel.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsLoanModel.dart';
import 'package:passbook_core_jayant/MainScreens/CardsModel.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/home/home_bloc.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/home/home_event.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/home/home_state.dart';
import 'package:passbook_core_jayant/Passbook/Model/PassbookListModel.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account/Model/AccountsShareModel.dart';

class AccountMenus extends StatefulWidget {
  const AccountMenus({super.key});

  @override
  _AccountMenusState createState() => _AccountMenusState();
}

class _AccountMenusState extends State<AccountMenus>
    with TickerProviderStateMixin {
  late SharedPreferences preferences;
  var userId = "", acc = "", name = "", address = "", cmpCode = "";
  List<AccountsLoanTable> _accLoanTableModel = [];
  List<AccountsDepositTable> _accDepositModel = [];
  List<AccountsShareTable> _accShareModel = [];
  List<PassbookItem> _chittyModel = [], _shareModel = [];
  final double _pageViewHeight = 200;
  final HomeBloc _homeBloc = HomeBloc();

  void loadData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getString(StaticValues.custID) ?? "";
      acc = preferences.getString(StaticValues.accNumber) ?? "";
      name = preferences.getString(StaticValues.accName) ?? "";
      address = preferences.getString(StaticValues.address) ?? "";
      cmpCode = preferences.getString(StaticValues.cmpCodeKey) ?? "";
      print("userName");
      alertPrint("custId=$userId");
      print(acc);
      print(name);
    });

    _homeBloc.add(AccDepositEvent(userId, cmpCode, "DEPOSIT"));
    _homeBloc.add(AccLoanEvent(userId, cmpCode, "LOAN"));
    _homeBloc.add(ChittyEvent(userId, cmpCode, "Chitty"));
    _homeBloc.add(AccShareEvent(userId, cmpCode, "SHARE"));
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                stretch: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: TextView(
                  text: "Account",
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
              SliverSafeArea(
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    BlocListener<HomeBloc, HomeState>(
                      bloc: _homeBloc,
                      listener: (context, snapshot) {
                        if (snapshot is AccDepositResponse) {
                          setState(() {
                            _accDepositModel =
                                snapshot.accountsDepositModel.data;
                          });
                        }
                        if (snapshot is AccLoanResponse) {
                          setState(() {
                            _accLoanTableModel =
                                snapshot.accountsLoanModel.data;
                          });
                        }
                        if (snapshot is ChittyResponse) {
                          setState(() {
                            _chittyModel = snapshot.chittyListModel.table;
                          });
                        }
                        if (snapshot is ShareResponse) {
                          setState(() {
                            // _shareModel = snapshot.shareListModel.table;
                            _accShareModel = snapshot.accountsShareModel.data;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextView(
                          text: "Deposit",
                          size: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff707070),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _pageViewHeight,
                      child: BlocBuilder<HomeBloc, HomeState>(
                        bloc: _homeBloc,
                        buildWhen:
                            (previous, current) =>
                                current is AccDepositLoading ||
                                current is AccDepositResponse ||
                                current is AccDepositErrorException,
                        builder: (context, snapshot) {
                          customPrint(
                            "Current state in account deposit: $snapshot",
                          );
                          if (snapshot is AccDepositLoading) {
                            customPrint("acc deposit circular");
                            return Center(child: CircularProgressIndicator());
                          } else if (_accDepositModel.isNotEmpty) {
                            return PageView.builder(
                              itemCount: _accDepositModel.length,
                              scrollDirection: Axis.horizontal,
                              controller: PageController(viewportFraction: .95),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: DepositCardModel(
                                    accountsDeposit: _accDepositModel[index],
                                    onPressed: () {
                                      /* Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => PassbookDPSH(
                                                    type: "DP",
                                                  )));*/
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: TextView(
                                text: "You don't have a deposit in this bank",
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextView(
                        text: "Loan",
                        size: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff707070),
                      ),
                    ),
                    SizedBox(
                      height: _pageViewHeight,
                      child: BlocBuilder<HomeBloc, HomeState>(
                        bloc: _homeBloc,
                        buildWhen:
                            (previous, current) =>
                                current is AccLoanLoading ||
                                current is AccLoanResponse ||
                                current is AccLoanResponseErrorException,
                        builder: (context, snapshot) {
                          if (snapshot is AccLoanLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (_accLoanTableModel.isNotEmpty) {
                            return PageView.builder(
                              controller: PageController(viewportFraction: .95),
                              itemCount: _accLoanTableModel.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: LoanCardModel(
                                    accountsLoanTable:
                                        _accLoanTableModel[index],
                                    onPressed: () {
                                      /* Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => LoanTransaction(
                                                    accNo: _accLoanTableModel[index].loanNo,
                                                  )));*/
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: TextView(
                                text: "You don't have a loan in this bank",
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextView(
                        text: "Chitty",
                        size: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff707070),
                      ),
                    ),
                    SizedBox(
                      height: _pageViewHeight,
                      child: BlocBuilder<HomeBloc, HomeState>(
                        bloc: _homeBloc,
                        buildWhen:
                            (previous, current) =>
                                current is ChittyLoading ||
                                current is ChittyResponse ||
                                current is ChittyResponseErrorException,
                        builder: (context, snapshot) {
                          alertPrint("chitty $snapshot");
                          if (snapshot is ChittyLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (_chittyModel.isNotEmpty) {
                            return PageView.builder(
                              controller: PageController(viewportFraction: .95),
                              itemCount: _chittyModel.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ChittyCardModel(
                                    chittyListTable: _chittyModel[index],
                                    onPressed: () {
                                      /* Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => ChittyTransaction(
                                                    accNo: _chittyModel[index].accNo,
                                                  )));*/
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: TextView(
                                text: "You don't have a chitty in this bank",
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextView(
                        text: "Share",
                        size: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff707070),
                      ),
                    ),
                    SizedBox(
                      height: _pageViewHeight,
                      child: BlocBuilder<HomeBloc, HomeState>(
                        bloc: _homeBloc,
                        buildWhen:
                            (previous, current) =>
                                current is ShareLoading ||
                                current is ShareResponse ||
                                current is ShareResponseErrorException,
                        builder: (context, snapshot) {
                          customPrint(
                            "Current state in account share: $snapshot",
                          );
                          if (snapshot is ShareLoading) {
                            customPrint("acc share circular");
                            return Center(child: CircularProgressIndicator());
                            // } else if (_shareModel.isNotEmpty) {
                          } else if (_accShareModel.isNotEmpty) {
                            // return Center(
                            //   child: Text("Please Contact the Branch"),
                            // );
                            return PageView.builder(
                              controller: PageController(viewportFraction: .95),
                              // itemCount: _shareModel.length,
                              itemCount: _accShareModel.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ShareCardModel(
                                    // accountsShare: _shareModel[index],
                                    accountsShare: _accShareModel[index],
                                    onPressed: () {
                                      /*  Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => PassbookDPSH(
                                                    type: "SH",
                                                  )));*/
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: TextView(
                                text: "You don't have a share in this bank",
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "assets/safesoftware_logo.png",
                        width: 200,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
