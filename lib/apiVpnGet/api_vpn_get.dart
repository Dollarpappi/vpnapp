import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safevpn/addPrefernces/add_prefernces.dart';
import 'package:safevpn/allControllers/allModels/ip_info.dart';
import 'package:safevpn/allControllers/allModels/vpn_info.dart';
import 'package:http/http.dart' as http;

class ApiVpnGet {
  //firstly lets retrieve all available vpn
  static Future<List<VpnInfo>> retrieveAvailableFreeVpnServer() async {
    final List<VpnInfo> vpnServerList = [];

    try {
      // WE ARE GETTING THE OPEN GATE VPN SERVERS

      final responseFromApi =
          await http.get(Uri.parse("http://www.vpngate.net/api/iphone/"));
      //data is being transmitted in csv format and we want to seperate the data
      final commaSeperatedValuesString =
          responseFromApi.body.split("#")[1].replaceAll("*", " ");
      //converting csv to list
      List<List<dynamic>> listData =
          const CsvToListConverter().convert(commaSeperatedValuesString);

      final header = listData[0];
      for (int counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};
        for (int innerCounter = 1;
            innerCounter < header.length;
            innerCounter++) {
          jsonData.addAll({
            header[innerCounter].toString(): listData[counter][innerCounter]
          });
        }
        vpnServerList.add(VpnInfo.fromJson(jsonData));
      }
    } catch (e) {
      Get.snackbar("Error Occured", e.toString(),
          colorText: Colors.redAccent.withOpacity(.8));
    }

    vpnServerList.shuffle();
//ASSIGNING THE VPN SERVER INTO VPNLIST
    if (vpnServerList.isNotEmpty) AddPrefernces.vpnList = vpnServerList;

    return vpnServerList;
  }

  //HOW TO GET IP DETAILS OF VPN SERVER
  static Future<void> retrieveIPDetails(
      {required Rx<IpInfo> ipinformation}) async {
    try {
     final responseFromApi = await http.get(Uri.parse("http://ip-api.com/json/"));
     final dataFromApi = jsonDecode(responseFromApi.body);

    ipinformation.value = IpInfo.fromJson(dataFromApi);
    } catch (e) {
      Get.snackbar("Error Occured", e.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.redAccent.withOpacity(.8));
    }
  }

  
}
