import 'package:flutter/material.dart';

class LoanSearch extends StatefulWidget {
  const LoanSearch({Key? key}) : super(key: key);

  @override
  _LoanSearchState createState() => _LoanSearchState();
}

class _LoanSearchState extends State<LoanSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Search"),
      ),
    );
  }
}
