import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class LabelCustomTextField extends StatefulWidget {
  const LabelCustomTextField({
    super.key,
    required this.hintText,
    this.hintstyle,
    this.onPressed,
    this.onchanged,
    this.passwordfield,
    this.showSuffixicon,
    this.controller,
    this.inputFormatters,
    this.suffix,
    this.validator,
    this.inputType,
    this.lines,
    this.onTap,
    this.readOnly,
    this.prefix,
    this.label,
    this.labelText,
    this.enable,
    this.autofillHints,
    required this.textFieldLabel,
    this.textInputAction,
    this.textFieldLabelstyle,
    this.isRemoveVerticalPadding,
    this.padding,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool? showSuffixicon;
  final bool? enable;
  final Function? onPressed;
  final Function? onTap;
  final Function? onchanged;
  final bool? passwordfield;
  final Widget? suffix;
  final Function(String)? validator;
  final TextInputType? inputType;
  final int? lines;
  final Widget? prefix;
  final bool? readOnly;
  final Widget? label;
  final TextStyle? hintstyle;
  final TextStyle? textFieldLabelstyle;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final String textFieldLabel;
  final TextInputAction? textInputAction;
  final bool? isRemoveVerticalPadding;
  final EdgeInsetsGeometry? padding;

  @override
  State<LabelCustomTextField> createState() => _LabelCustomTextField();
}

class _LabelCustomTextField extends State<LabelCustomTextField> {
  bool showpassword = true;
  late bool showPrefixIcon;
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  @override
  void initState() {
    showPrefixIcon = widget.showSuffixicon ?? false;
    _focusNode.addListener(_handleFocusChange);
    super.initState();
  }

  void _handleFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    final primaryColor = Colors.black;
    return Padding(
      padding:
          widget.padding ??
          (widget.isRemoveVerticalPadding == true
              ? EdgeInsets.symmetric(horizontal: 6)
              : const EdgeInsets.all(6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.textFieldLabel,
            style:
                widget.textFieldLabelstyle ??
                GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(height: widget.textFieldLabel.isEmpty ? 0 : 5),
          TextFormField(
            focusNode: _focusNode,
            readOnly: widget.readOnly ?? false,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            autofillHints: widget.autofillHints,
            inputFormatters: widget.inputFormatters,
            onChanged: (value) {
              if (widget.onchanged != null) {
                widget.onchanged!(value);
              }
            },
            controller: widget.controller,
            validator:
                widget.validator == null
                    ? null
                    : (val) => widget.validator!(val ?? ""),
            obscureText: widget.passwordfield == true ? showpassword : false,
            keyboardType: widget.inputType ?? TextInputType.text,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            maxLines: widget.passwordfield == true ? 1 : widget.lines,
            decoration: InputDecoration(
              filled: true,
              label: widget.label,
              labelText: widget.labelText,
              labelStyle: const TextStyle(),
              fillColor: Colors.white,
              prefixIcon:
                  showPrefixIcon == true
                      ? IconTheme(
                        data: IconThemeData(
                          color: _hasFocus ? Colors.black : Colors.grey,
                        ),
                        child: widget.prefix ?? SizedBox.shrink(),
                      )
                      : null,
              suffixIcon:
                  widget.passwordfield == true
                      ? IconButton(
                        onPressed: () {
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                        icon:
                            showpassword
                                ? Icon(
                                  Ionicons.eye_off,
                                  size: 20,
                                  color: _hasFocus ? Colors.black : Colors.grey,
                                )
                                : Icon(
                                  Icons.remove_red_eye,
                                  color: _hasFocus ? Colors.black : Colors.grey,
                                ),
                      )
                      : widget.suffix,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.3),
              ),
              hintText: widget.hintText,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.grey, width: 0.3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.grey, width: 0.3),
              ),
              disabledBorder: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              hintStyle:
                  widget.hintstyle ??
                  TextStyle(color: _hasFocus ? primaryColor : Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
