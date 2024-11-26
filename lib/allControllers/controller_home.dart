import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safevpn/addPrefernces/add_prefernces.dart';
import 'package:safevpn/addPrefernces/vpnEngine/vpn_engine.dart';
import 'package:safevpn/allControllers/allModels/vpn_configuration.dart';
import 'package:safevpn/allControllers/allModels/vpn_info.dart';

class ControllerHome extends GetxController {
  //creat an instance of vnpobj and assign it to vpninfo
  final Rx<VpnInfo> vpninfo = AddPrefernces.vpnInfoObj.obs;

  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;

  void connectToVpnNow() async{
    if (vpninfo.value.base64OpenVPNConfigurationData.isEmpty) {
      Get.snackbar(
          "Country / Location", "Please select country / location first.");

      return;
    }

    //if user is ready to start the vpn, user can now start the vpn
    if (vpnConnectionState.value == VpnEngine.vpnDisconnectedNow) {
      final dataConfigVpn = const Base64Decoder()
          .convert(vpninfo.value.base64OpenVPNConfigurationData);

      final configuration = const Utf8Decoder().convert(dataConfigVpn);

      final vpnConfiguration = VpnConfiguration(
          config: configuration,
          countryName: vpninfo.value.countryLongName,
          password: "vpn",
          username: "vpn");
          await VpnEngine.startVpnNow(vpnConfiguration);
    }else{
      //if already started they can stop the vpn
      await VpnEngine.stopVpnNow();
    }
  }
  
  Color get getRoundButtonColor{
     switch(vpnConnectionState.value){
      case VpnEngine.vpnDisconnectedNow:
      return Colors.redAccent; 

      case VpnEngine.vpnConnectedNow:
      return Colors.green;
      
      default:
      return Colors.orange; 
 }
  }
   String get getRoundVpnButtonText{
    switch(vpnConnectionState.value){
      case VpnEngine.vpnDisconnectedNow:
      return "Tap to connect"; 

      case VpnEngine.vpnConnectedNow:
      return "Disconnect";
      
      default:
      return "connecting.....";  
     }
   }
}
