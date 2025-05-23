import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:passbook_core_jayant/styles.dart';

class SimUiGrid extends StatelessWidget {
  const SimUiGrid({super.key, required this.sims, this.onSimSelected});
  final List<Map<String, dynamic>> sims;
  final Function(String)? onSimSelected;
  @override
  Widget build(BuildContext context) {
    customPrint("sims =$sims");
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemCount: sims.length,
      itemBuilder: (context, index) {
        final sim = sims[index];
        final number = sim['number'] ?? 'Unknown';
        return GestureDetector(
          onTap: () {
            if (onSimSelected != null) {
              onSimSelected!(number);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sim_card_alert_outlined,
                  color: AppTheme().primaryColor,
                  size: 36,
                ),
                const SizedBox(height: 8),
                Text(
                  sim["carrierName"] ?? "SIM ${index + 1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void showSimGridBottomSheet(
  BuildContext context,
  List<Map<String, dynamic>> sims,
  Function(String) onNumberSelected,
) {
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: SizedBox(
          height: h * 0.35,
          child: Padding(
            padding: EdgeInsets.all(w * 0.05),
            child: Column(
              spacing: 10,
              children: [
                TextView(
                  text: "Verify Your Mobile Number",
                  size: 20.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  color: Theme.of(context).focusColor,
                ),
                Text(
                  "Choose the Mobile Number Registered with the Bank",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: w * 0.035,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SimUiGrid(
                  sims: sims,
                  onSimSelected: (number) {
                    Navigator.of(context).pop(); // close bottom sheet
                    onNumberSelected(number); // send number to parent
                  },
                ),
                SizedBox(
                  height: h * 0.05,
                  width: w * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme().primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
