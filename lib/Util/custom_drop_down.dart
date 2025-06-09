import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelWithDropDownField<T> extends StatelessWidget {
  const LabelWithDropDownField({
    super.key,
    required this.textDropDownLabel,
    this.hintText,
    this.labelText,
    this.onChanged,
    required this.items,
    this.icon,
    this.showSelectedItems = true,
    this.itemAsString,
    this.alignLabelWithHint,
    this.onBeforePopupOpening,
    this.isHintvalue = false,
    this.showboxshadow = false,
    this.padding,
  });
  final String textDropDownLabel;
  final Future<bool?> Function(T?)? onBeforePopupOpening;
  final String? hintText;
  final String? labelText;
  final List<T>? items;
  final ValueChanged<T>? onChanged;
  final bool? alignLabelWithHint;
  final Widget? icon;
  final bool showSelectedItems;
  final bool? isHintvalue;
  final String Function(T)? itemAsString;
  final double? padding;

  final bool? showboxshadow;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textDropDownLabel,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5),
          DropdownSearch<T>(
            popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              showSelectedItems: showSelectedItems,
              containerBuilder: (context, popupWidget) {
                return Material(
                  color: Colors.white, // ✅ Set popup background color to white

                  elevation: 4,
                  child: popupWidget,
                );
              },
            ),
            items: (filter, loadProps) => items ?? [],
            onBeforePopupOpening: onBeforePopupOpening,
            compareFn: (item, selectedItem) => item == selectedItem,
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                alignLabelWithHint: alignLabelWithHint,
                icon: icon,
                fillColor: Colors.white,
                filled: false,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 0.5),
                ),
                disabledBorder: const OutlineInputBorder(),
                contentPadding: EdgeInsets.all(padding ?? 10),
                hintText: hintText ?? "",
                hintStyle: GoogleFonts.poppins(
                  color: isHintvalue == true ? Colors.black : Colors.black,
                  fontSize: 14,
                ),

                labelText: labelText ?? "",
                labelStyle: GoogleFonts.poppins(
                  color: isHintvalue == true ? Colors.black : Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            onChanged: (value) {
              if (onChanged != null && value != null) {
                onChanged!(value);
              }
            },
            itemAsString: itemAsString,
          ),
        ],
      ),
    );
  }
}
