import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/Util/custom_drop_down.dart';

class NewUser extends StatelessWidget {
  const NewUser({super.key});

  @override
  Widget build(BuildContext context) {
    final h= MediaQuery.of(context).size.height;
    final w= MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
         "New User",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ), 
      body: ListView(
        children: [
          SizedBox(height: h*0.02,),
          LabelWithDropDownField(textDropDownLabel: "Branch", items: [
            "A","B"
          ])
        ],
      ),
    ));
  }
}
