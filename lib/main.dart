import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/FundTransfer/FundTransfer.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/transfer_bloc.dart';
import 'package:passbook_core_jayant/MainScreens/Login.dart';
import 'package:passbook_core_jayant/MainScreens/bloc/user/user_bloc.dart';
import 'package:passbook_core_jayant/MainScreens/home_page.dart';
import 'package:passbook_core_jayant/MainScreens/sub_page.dart';
import 'package:passbook_core_jayant/Passbook/bloc/pass_book_bloc.dart';
import 'package:passbook_core_jayant/Search/bloc/search_bloc.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:passbook_core_jayant/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/StaticValue.dart';
import 'NewDesign/LoginNew.dart';
import 'configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This widget is the root of your application.
  final String extDownloadPath = '';
  runApp(
    CoreApp(
      titleDecoration: TitleDecoration(
        label: "JINL Co-Operative Multipurpose Society",
        logoPath: "assets/mini-logo.png",
        labelColor: Colors.black,
      ),

      /// Production API
      // apiGateway: "apirbl.jayantindia.com:6391",

      /// Test API
      apiGateway: "apirbl.jayantindia.com:6386",

      defaultScreen: Login(),
      themeData: AppTheme().themeData(),
      sharedPreferences: await SharedPreferences.getInstance(),
      extDownloadPath: extDownloadPath,
      homePageConfiguration: HomePageConfiguration(
        baseOption: true,
        fundTransferOption: true,
        rechargeOption: false,
        shoppingOption: false,
        cardOption: false,
        search: true,
      ),
    ),
  );
}

class CoreApp extends StatelessWidget {
  //  final Widget _defaultScreen = Receipt(accFrom: "339202010056217",accTo: "1234567890123",amount: "10000",paidTo: "Dithesh Vishalakshan",transID: "PS/258160/200/50041/280PM",);
  final Widget? defaultScreen;
  final String? apiGateway;
  final SharedPreferences? sharedPreferences;
  final TitleDecoration? titleDecoration;
  final String? extDownloadPath;
  final HomePageConfiguration? homePageConfiguration;
  final ThemeData? themeData;

  const CoreApp({
    super.key,
    this.defaultScreen,
    this.apiGateway,
    this.sharedPreferences,
    this.titleDecoration,
    this.homePageConfiguration,
    this.themeData,
    this.extDownloadPath,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor),
    );
    StaticValues.themeData = themeData;
    StaticValues.apiGateway = apiGateway;
    StaticValues.titleDecoration = titleDecoration;
    StaticValues.sharedPreferences = sharedPreferences;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PassBookBloc()),
        BlocProvider(create: (context) => TransferBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => UserBloc()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          );
        },
        title: StaticValues.titleDecoration!.label!,
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: Scaffold(body: defaultScreen),
        routes: <String, WidgetBuilder>{
          "/SubPage": (BuildContext context) => SubPage(),
          //  "/LoginPage": (BuildContext context) => Login(),
          "/LoginPage": (BuildContext context) => LoginNew(),
          "/FundTransfer": (BuildContext context) => FundTransfer(),
          "/HomePage":
              (BuildContext context) =>
                  HomePage(homePageConfiguration: homePageConfiguration),
        },
      ),
    );
  }
}
