import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safevpn/addPrefernces/add_prefernces.dart';
import 'package:safevpn/addPrefernces/vpnEngine/vpn_engine.dart';
import 'package:safevpn/allControllers/allModels/vpn_info.dart';
import 'package:safevpn/allControllers/controller_home.dart';
import 'package:safevpn/main.dart';

class VpnLocationCard extends StatelessWidget {
  final VpnInfo vpnInfo;
  const VpnLocationCard({super.key, required this.vpnInfo});

  String formatSpeedBytes(int speedBytes, int decimal) {
    if (speedBytes <= 0) {
      return "0 B";
    }

    const suffixesTitle = ["Bps", "Kbps", "Mbps", "Gbps", "Tbps"];

    var speedTitleIndex = (log(speedBytes) / log(1024).floor());

    return "${(speedBytes / pow(1024, speedTitleIndex)).toStringAsFixed(decimal)} ${suffixesTitle[speedTitleIndex as int]}";
  }

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    final homeController = Get.find<ControllerHome>();
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: sizeScreen.height * .01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          homeController.vpninfo.value = vpnInfo;
          AddPrefernces.vpnInfoObj = vpnInfo;

          Get.back();

          if (homeController.vpnConnectionState.value == VpnEngine.vpnConnectedNow) {
            VpnEngine.stopVpnNow();

            Future.delayed(const Duration(seconds: 3), ()=> homeController.connectToVpnNow());
          }else{
            homeController.connectToVpnNow();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

          //country flag
          leading: Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(16)),
            child: Image.asset(
              "assets/countryFlags/${vpnInfo.countryShortName.toLowerCase()}.png",
              height: 40,
              width: sizeScreen.width * .15,
              fit: BoxFit.cover,
            ),
          ),
          //countryname
          title: Text(vpnInfo.countryLongName),

          //vpn speed
          subtitle: Row(
            children: [
              Icon(
                Icons.shutter_speed,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                formatSpeedBytes(vpnInfo.speed, 2),
              ),


            ],
          ),
          
          //number of session
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfo.vpnSessionsNum.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColorLight
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.redAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
