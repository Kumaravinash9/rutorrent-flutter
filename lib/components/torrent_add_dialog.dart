import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import '../api/api_conf.dart';
import '../constants.dart' as Constants;
import 'package:flutter/material.dart';

class TorrentAddDialog extends StatelessWidget {

  final Api api;
  final TextEditingController urlTextController = TextEditingController();

  TorrentAddDialog(this.api);

  _addTorrentUrl(String url) async {
    HttpClient httpClient = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(httpClient);
    await ioClient.post(Uri.parse(api.addTorrentUrl),
        headers: {
          'authorization':api.getBasicAuth(),
        },
        body: {
          'url': urlTextController.text,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
    ),
      ),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                style: TextStyle(fontSize: 16,color: Constants.kDarkGrey),
                controller: urlTextController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    hintText: 'Enter Url'),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Constants.kBlue,
                  child: Text('Add',style: TextStyle(color: Colors.white,fontSize: 16),),
                  onPressed: (){
                    Fluttertoast.showToast(msg: 'Adding torrent');
                    Navigator.pop(context);
                    _addTorrentUrl(urlTextController.text);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
