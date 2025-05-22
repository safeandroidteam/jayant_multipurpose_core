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

  final bool? showboxshadow;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(textDropDownLabel,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(15),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(showboxshadow == false ? 0.1 : 0.0),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            width: w,
            child: DropdownSearch<T>(
              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                showSelectedItems: showSelectedItems,
              ),
              items: (filter, loadProps) => items ?? [],
              onBeforePopupOpening: onBeforePopupOpening,
              compareFn: (item, selectedItem) => item == selectedItem,
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  alignLabelWithHint: alignLabelWithHint,
                  icon: icon,
                  fillColor: Colors.white,
                  filled: true,
                  border:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 0.3,
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.3,
                    ),
                  ),
                  enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 0.3,
                      )),
                  disabledBorder: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.all(15),
                  hintText: hintText ?? "",
                  hintStyle: GoogleFonts.poppins(
                      color: isHintvalue == true
                          ? Colors.black
                          : Colors.grey,
                      fontSize: 14),
                  labelText: labelText ?? "",
                  labelStyle: GoogleFonts.poppins(
                      color: isHintvalue == true
                          ? Colors.black
                          : Colors.grey,
                      fontSize: 14),
                ),
              ),
              onChanged: (value) {
                if (onChanged != null && value != null) {
                  onChanged!(value);
                }
              },
              itemAsString: itemAsString,
            ),
          ),
        ],
      ),
    );
  }
}
