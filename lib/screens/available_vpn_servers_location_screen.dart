import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safevpn/allControllers/controller_vpn_location.dart';
import 'package:safevpn/allWidgets/vpn_location_card.dart';

class AvailableVpnServersLocationScreen extends StatelessWidget {
  AvailableVpnServersLocationScreen({super.key});

  final vpnLocationController = ControllerVpnLocation();

  loadingUIWidget(){
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),),

            SizedBox(height: 8,),

            Text("Gathering free VPN location", style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w700,
            ),)
         ] )
        
      );
    
  }
  
  noVpnServerFoundUIWidget(){
    return const Center( 
      child: Text("No VPNs Found, Try Again", style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w700,
            ),),
    );
  }
  
  vpnAvailableServerData(){
    return ListView.builder(
      itemCount: vpnLocationController.vpnFreeServerAvailableList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(3),
      itemBuilder: (context, index){
          return VpnLocationCard(vpnInfo: vpnLocationController.vpnFreeServerAvailableList[index]);
      });
   }
  @override
  Widget build(BuildContext context) {
    if (vpnLocationController.vpnFreeServerAvailableList.isEmpty) {
      vpnLocationController.retrieveVpnInformation();
    }
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("VPN Location${vpnLocationController.vpnFreeServerAvailableList.length}"),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 10, right: 10),
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: (){
                vpnLocationController.retrieveVpnInformation();
              },
              child: const  Icon(
                //CupertinoIcons
                CupertinoIcons.refresh_circled,
                size: 40,
              ),),

          ),
          body: vpnLocationController.isLoadingNewLoadingLocations.value
              ? loadingUIWidget()
              : vpnLocationController.vpnFreeServerAvailableList.isEmpty
                  ? noVpnServerFoundUIWidget()
                  : vpnAvailableServerData(),
        ));
  }
}
