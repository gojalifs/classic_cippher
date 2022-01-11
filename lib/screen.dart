import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'logic.dart';

Logic logic = new Logic();
String result;

class Screen extends StatefulWidget {
  final title;

  Screen({this.title});

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      result = '';
    });
  }

  inputFormattin() {
    if (widget.title == 'CAESAR CIPHER' || widget.title == 'VIGENERE CIPHER')
      return <TextInputFormatter>[
        new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
      ];
  }

  keyFormattin() {
    if (widget.title == 'CAESAR CIPHER' || widget.title == "RAIL FENCE CIPHER")
      return <TextInputFormatter>[
        new FilteringTextInputFormatter.allow(RegExp("[0-9]"))
      ];
    else if (widget.title == 'VIGENERE CIPHER' ||
        widget.title == 'KEYWORD CIPHER')
      return <TextInputFormatter>[
        new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
      ];
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController input = TextEditingController();
  TextEditingController key = TextEditingController();
  TextEditingController additionalParam = TextEditingController();

  int maxChar = -1;
  String all = '';
  List decryptedList = [];
  bool checked = false;
  bool fullVigenere = false;
  bool encryption = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus.unfocus(),
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                      maxLines: null,
                      controller: input,
                      inputFormatters: inputFormattin(),
                      validator: (value) {
                        if (value.isEmpty) return 'Required';
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          hintText: 'Text'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: widget.title == 'ROT13' || widget.title == 'OTP'
                        ? SizedBox()
                        : TextFormField(
                            controller: key,
                            inputFormatters: keyFormattin(),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Required';
                              else if (widget.title == 'RAIL FENCE CIPHER' &&
                                  int.parse(value) > input.text.length)
                                return 'Number key should not be bigger than length of text.';
                              else if (widget.title == 'PLAYFAIR CIPHER' &&
                                  key.text.length < 6)
                                return 'Playfair key size must atleast be 6 characters long.';
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                hintText: 'Key'),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: widget.title == 'VIGENERE CIPHER'
                        ? TextFormField(
                            controller: additionalParam,
                            inputFormatters: keyFormattin(),
                            validator: (value) {
                              if (value.length != 26 && value.length != 0) {
                                return 'Alphabeth Must Be 26 Digit Of Char';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                hintText: 'Alphabeth (Optional)'),
                          )
                        : SizedBox(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: widget.title != 'AFFINE CIPHER'
                        ? SizedBox()
                        : TextFormField(
                            controller: additionalParam,
                            inputFormatters: keyFormattin(),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                hintText: 'Prime'),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                FocusManager.instance.primaryFocus.unfocus();
                                if (formKey.currentState.validate())
                                  setState(() {
                                    if (widget.title == "CAESAR CIPHER") {
                                      encryption = true;
                                      result = logic.caesar(
                                          input.text, int.parse(key.text), 1);
                                      decryptedList.clear();
                                    } else if (widget.title ==
                                        "VIGENERE CIPHER")
                                      result = logic.vigenere(
                                          input.text,
                                          key.text,
                                          fullVigenere,
                                          1,
                                          additionalParam.text);
                                    else if (widget.title ==
                                        "RAIL FENCE CIPHER")
                                      result = logic.railfenceEncrypt(
                                          input.text, int.parse(key.text));
                                    else if (widget.title == "PLAYFAIR CIPHER")
                                      result = logic.playfairEncrypt(
                                          input.text, key.text);
                                    else if (widget.title == "KEYWORD CIPHER")
                                      result = logic.keywordEncrypt(
                                          input.text, key.text);
                                    else if (widget.title == 'ROT13') {
                                      result = logic.caesar(input.text, 13, 1);
                                    } else if (widget.title ==
                                        'AFFINE CIPHER') {
                                      result = logic.affineChipper(
                                          input.text,
                                          int.parse(key.text),
                                          int.parse(additionalParam.text));
                                    } else if (widget.title == 'OTP') {
                                      result = logic.otp(input.text);
                                    } else if (widget.title ==
                                        'KUNCI BERULANG') {
                                      result = logic.kunciBerulang(
                                          input.text, key.text);
                                    }
                                  });
                              },
                              icon: Icon(Icons.lock_outline),
                              label: Text('ENCRYPT'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                FocusManager.instance.primaryFocus.unfocus();
                                if (formKey.currentState.validate())
                                  setState(() {
                                    if (additionalParam.text.isNotEmpty) {
                                      fullVigenere = true;
                                    } else {
                                      fullVigenere = false;
                                    }

                                    if (widget.title == "CAESAR CIPHER") {
                                      encryption = false;
                                      decryptedList.clear();
                                      int maxCount = 0;
                                      var counts = <int, int>{};
                                      for (var char in input.text.runes) {
                                        int count = counts.update(
                                            char, (n) => n + 1,
                                            ifAbsent: () => 1);
                                        if (count > maxCount) {
                                          setState(() {
                                            maxCount = count;
                                            maxChar = char;
                                          });
                                        }
                                      }
                                      for (var i = 0; i < 26; i++) {
                                        all = logic.caesar(input.text, i, 0);
                                        decryptedList.add(all);
                                      }
                                      result = logic.caesar(
                                          input.text, int.parse(key.text), 0);
                                    } else if (widget.title ==
                                        "VIGENERE CIPHER") {
                                      result = logic.vigenere(
                                          input.text,
                                          key.text,
                                          fullVigenere,
                                          0,
                                          additionalParam.text);
                                    } else if (widget.title ==
                                        "RAIL FENCE CIPHER")
                                      result = logic.railfenceDecrypt(
                                          input.text, int.parse(key.text));
                                    else if (widget.title == "PLAYFAIR CIPHER")
                                      result = logic.playfairDecrypt(
                                          input.text, key.text);
                                    else if (widget.title == "KEYWORD CIPHER")
                                      result = logic.keywordDecrypt(
                                          input.text, key.text);
                                    else if (widget.title == 'ROT13') {
                                      result = logic.caesar(input.text, 13, 0);
                                    }
                                  });
                              },
                              icon: Icon(Icons.lock_open_rounded),
                              label: Text('DECRYPT'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: ListTile(
                        title: Text(
                      'OUTPUT',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Container(
                      child: widget.title == 'CAESAR CIPHER'
                          ? encryption == true
                              ? SelectableText(result)
                              : SelectableText(result)
                          // ListView.builder(
                          //     shrinkWrap: true,
                          //     primary: false,
                          //     itemCount: decryptedList.length,
                          //     itemBuilder: (context, index) {
                          //       return Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceAround,
                          //         children: [
                          //           Text(index.toString()),
                          //           SelectableText(
                          //               decryptedList[index].toString()),
                          //         ],
                          //       );
                          //     },
                          // ),
                          : Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              constraints: BoxConstraints.expand(
                                width: 500,
                                height: 100,
                              ),
                              child: result == ''
                                  ? SelectableText('Output Will Shown Here')
                                  : SelectableText(result)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
