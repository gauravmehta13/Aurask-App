import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class Paytm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaytmState();
  }
}

class _PaytmState extends State<Paytm> {
  String mid = "lziDdZ71034278533888", orderId = "", amount = "", txnToken = "";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "https://securegw-stage.paytm.in/";
  bool restrictAppInvoke = false;

  @override
  void initState() {
    print("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                EditText('Merchant ID', mid, onChange: (val) => mid = val),
                EditText('Order ID', orderId, onChange: (val) => orderId = val),
                EditText('Amount', amount, onChange: (val) => amount = val),
                EditText('Transaction Token', txnToken,
                    onChange: (val) => txnToken = val),
                Row(
                  children: <Widget>[
                    Checkbox(
                        activeColor: Theme.of(context).buttonColor,
                        value: isStaging,
                        onChanged: (bool? val) {
                          setState(() {
                            isStaging = val!;
                          });
                        }),
                    Text("Staging")
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                        activeColor: Theme.of(context).buttonColor,
                        value: restrictAppInvoke,
                        onChanged: (bool? val) {
                          setState(() {
                            restrictAppInvoke = val!;
                          });
                        }),
                    Text("Restrict AppInvoke")
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: isApiCallInprogress
                        ? null
                        : () {
                            _startTransaction();
                          },
                    child: Text('Start Transcation'),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text("Message : "),
                ),
                Container(
                  child: Text(result),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startTransaction() async {
    if (txnToken.isEmpty) {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": amount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke
    };
    print(sendMap);
    try {
      var response = AllInOneSdk.startTransaction(
          mid, orderId, amount, txnToken, "null", isStaging, restrictAppInvoke);
      response.then((value) {
        print(value);
        setState(() {
          result = value.toString();
        });
      }).catchError((onError) {
        print(onError.toString());
        if (onError is PlatformException) {
          setState(() {
            result = onError.message! + " \n  " + onError.details.toString();
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err.toString();
    }
  }
}

class EditText extends StatefulWidget {
  final String text, value;
  final Function? onChange;
  EditText(this.text, this.value, {this.onChange});
  @override
  State<StatefulWidget> createState() {
    return _EditTextState();
  }
}

class _EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            widget.text,
            style: TextStyle(fontSize: 18),
          ),
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.fromLTRB(12, 8, 0, 0),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: TextField(
            controller: TextEditingController(text: widget.value),
            onChanged: (e) {},
            decoration: InputDecoration(
              hintText: 'Enter ${widget.text}',
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
