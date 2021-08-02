import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Remote_Configs/Cod_config.dart';
import 'package:flutter_application_3/views/Address.dart';

class Placeorder extends StatefulWidget {
  _PlaceorderState createState() => _PlaceorderState();
}

class _PlaceorderState extends State<Placeorder> {
  String radioItem = '';
  bool codenable = true;
  testRConfig() async {
    RemoteConfig config = await MyConfigures.contro();
    setState(() => codenable = config.getString("COD") == "true");
  }

  @override
  void initState() {
    testRConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Userorderscreendetails()));
              },
              splashColor: Colors.deepPurple,
              child: Text(
                'placeorder',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Payment Method"),
            RadioListTile(
              groupValue: radioItem,
              title: Text('COD'),
              value: 'COD',
              onChanged: codenable
                  ? (val) {
                      setState(() {
                        radioItem = val.toString();
                        print(radioItem);
                      });
                    }
                  : null,
            ),
            Visibility(visible: !codenable, child: Text("COD Unavailable")),
            RadioListTile(
              groupValue: radioItem,
              title: Text('UPI'),
              value: 'UPI',
              onChanged: (val) {
                setState(() {
                  radioItem = val.toString();
                  print(radioItem);
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("PaymentMode:$radioItem"),
              TextButton(onPressed: () {}, child: Text("Confirm Order"))
            ],
          ),
        ),
      ),
    );
  }
}
