import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:timeago/timeago.dart' as timeago;

class Receipt extends StatefulWidget {
  final String amount, paidTo, transID, accFrom, accTo;
  final String? pushReplacementNamed;
  final bool isFailure;
  final String message;

  const Receipt({
    super.key,
    this.amount = "",
    this.paidTo = "",
    this.transID = "",
    this.accFrom = "",
    this.accTo = "",
    this.message = "",
    this.pushReplacementNamed,
    this.isFailure = false,
  });

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  bool _shareBtnHide = true;

  final controller = ScreenshotController();

  @override
  void didChangeDependencies() {
    _controller.forward();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _fadeIn = Tween(begin: 0.8, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed("/HomePage");
        return true;
      },
      child: Screenshot(
        controller: controller,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor:
                widget.isFailure ? Colors.red[400] : Colors.green[700],
            centerTitle: true,
            title: Text("Receipt"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 30.0),
              onPressed:
                  () => Navigator.of(
                    context,
                  ).pushReplacementNamed(widget.pushReplacementNamed!),
            ),
          ),
          body: RepaintBoundary(
            key: _globalKey,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        color:
                            widget.isFailure
                                ? Colors.red[400]
                                : Colors.green[700],
                      ),
                    ),
                    Expanded(flex: 2, child: Container(color: Colors.white)),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.user, color: Colors.white),
                      SizedBox(height: 5.0),
                      TextView(
                        text: "${StaticValues.rupeeSymbol}${widget.amount}",
                        size: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15.0),
                      TextView(text: "Paid to", color: Colors.white),
                      TextView(
                        text: widget.paidTo,
                        size: 18.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                FadeTransition(
                  opacity: _fadeIn,
                  child: SlideTransition(
                    position: slideTransmit(
                      const Offset(0.0, 0.1),
                      const Offset(0.0, 0.0),
                      _controller,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * .9,
                        width: MediaQuery.of(context).size.width * .8,
                        child: Card(
                          elevation: 10.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green[400],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  title: TextView(
                                    text:
                                        "Paid ${StaticValues.rupeeSymbol}${widget.amount}",
                                    size: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  subtitle: Text(
                                    timeago.format(
                                      DateTime.now(),
                                      locale: 'en',
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.grey[400], height: 1.0),
                                ListTile(
                                  title: TextView(text: "Transaction ID"),
                                  subtitle: TextView(
                                    text: widget.transID,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: ListTile(
                                        title: TextView(text: "From"),
                                        subtitle: TextView(
                                          text:
                                              "••••${widget.accFrom.substring(widget.accFrom.length - 4)}",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: ListTile(
                                        title: TextView(text: "To"),
                                        subtitle: TextView(
                                          text:
                                              widget.accTo.isEmpty
                                                  ? ""
                                                  : "••••${widget.accTo.substring(widget.accTo.length - 4)}",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                TextView(text: widget.message),
                                SizedBox(height: 20.0),
                                Column(
                                  children: [
                                    Visibility(
                                      visible: _shareBtnHide,
                                      child: InkWell(
                                        onFocusChange: (_) {
                                          print("onFocusChange");
                                        },
                                        /*   onTapDown: (_) {
                                            print("onTapDown");
                                          },*/
                                        onTap: () async {
                                          setState(() {
                                            _shareBtnHide = false;
                                          });
                                          /* await Future.delayed(
                                                Duration(milliseconds: 120));
                                            Uint8List imageMemory =
                                                await _capturePng();

                                            print("Value:: $imageMemory");

                                            _shareBtnHide = true;
                                            setState(() {});
                                           await Share.file(
                                              '${widget.transID.hashCode}',
                                              "${widget.transID.hashCode}.png",
                                               imageMemory,
                                              'image/png',
                                            );*/
                                          // await Share.text("Hellloo", "Test File", "Test One");
                                          final image =
                                              await controller.capture();

                                          saveAndShare(image!);
                                        },
                                        borderRadius: BorderRadius.circular(
                                          50.0,
                                        ),
                                        splashColor:
                                            Theme.of(context).primaryColor,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              50.0,
                                            ),
                                            border: Border.all(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).primaryColor,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextView(
                                              text: "Share receipt",
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextView(
                          text:
                              "Payment may take up to 3 working days to be reflected in your account",
                          size: 10,
                          textAlign: TextAlign.center,
                          color: Colors.grey,
                        ),
                      ),
                      Opacity(
                        opacity: .5,
                        child: Image.asset(
                          "assets/safesoftware_logo.png",
                          width: 125,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareXFiles([XFile(image.path)]);
  }

  Animation<Offset> slideTransmit(
    Offset begin,
    Offset end,
    AnimationController controller,
  ) {
    Animation<Offset> anime;
    Animatable<Offset> animeOffset = Tween<Offset>(
      begin: begin,
      end: end,
    ).chain(CurveTween(curve: Curves.easeInOut));
    anime = controller.drive(animeOffset);
    return anime;
  }

  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary? boundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary!.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    return pngBytes;
  }
}
