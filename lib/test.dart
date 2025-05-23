import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'Util/sim_sender.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(home: SimSelectionScreen()));
}

class SimSelectionScreen extends StatefulWidget {
  const SimSelectionScreen({super.key});

  @override
  _SimSelectionScreenState createState() => _SimSelectionScreenState();
}

class _SimSelectionScreenState extends State<SimSelectionScreen> {
  List<Map<String, dynamic>> sims = [];

  @override
  void initState() {
    super.initState();
    loadSims();
  }

  void loadSims() async {
    final status = await Permission.phone.request();
    if (!status.isGranted) {
      debugPrint("Phone permission not granted");
      return;
    }

    final simList = await SimSender.getSimList();
    successPrint("list sime==${simList.length}");
    setState(() {
      sims = simList;
    });
  }

  // void sendMessage(int subscriptionId) async {
  //   final success = await SimSender.sendSMS(
  //     subscriptionId,
  //     "9876543210",
  //     "BANK_VERIFY",
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(success ? "SMS sent" : "Failed to send SMS")),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select SIM to Verify")),
      body:
          sims.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: sims.length,
                itemBuilder: (_, i) {
                  final sim = sims[i];
                  return ListTile(
                    title: Text("${sim['carrierName']} - ${sim['number']}"),
                    subtitle: Text(
                      "Slot: ${sim['slotIndex']}, ID: ${sim['subscriptionId']}",
                    ),
                    // trailing: ElevatedButton(
                    //   onPressed: () => sendMessage(sim['subscriptionId']),
                    //   child: Text("Send SMS"),
                    // ),
                  );
                },
              ),
    );
  }
}
