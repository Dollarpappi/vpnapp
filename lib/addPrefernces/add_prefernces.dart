import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:safevpn/allControllers/allModels/vpn_info.dart';

class AddPrefernces{
  static late Box boxOfDate;

  static Future<void> initHive() async{
    await Hive.initFlutter();

    boxOfDate = await Hive.openBox("data");

  }

  //saving users choice about theme selection
  static bool get isModeDark => boxOfDate.get("isModeDark") ?? false;

  static set isModeDark(bool value) => boxOfDate.put("isModeDark", value);

  // for saving single vpn details
  static VpnInfo get vpnInfoObj => VpnInfo.fromJson(jsonDecode(boxOfDate.get("vpn") ?? "{}"));
  static set vpnInfoObj(VpnInfo value)=> boxOfDate.put("vpn", jsonEncode(value));
 

  //for savinf all vpn server details
  static List<VpnInfo> get vpnList{
    //we get each vpn server and store it inthe tempvpnlist then return the list

    List<VpnInfo> tempVpnList = [];
    final dataVpn = jsonDecode(boxOfDate.get("vpnList") ?? "[]");
    for(var data in dataVpn){
      tempVpnList.add(VpnInfo.fromJson(data));
    }
    return tempVpnList;
  }

  static set vpnList(List<VpnInfo> valueList) => boxOfDate.put("vpnList", jsonEncode(valueList));
}

// extension AppTheme on ThemeData{
//   Color get lightTextColor  => AddPrefernces.isModeDark ? Color.fromARGB(255, 40, 129, 180) : Colors.black54;
//   Color get bottNavigationColor => AddPrefernces.isModeDark ? Colors.white12 : Colors.blue.withOpacity(0.5);
// }