import 'package:get/get.dart';
import 'package:safevpn/addPrefernces/add_prefernces.dart';
import 'package:safevpn/allControllers/allModels/vpn_info.dart';
import 'package:safevpn/apiVpnGet/api_vpn_get.dart';

class ControllerVpnLocation extends GetxController{
  List<VpnInfo> vpnFreeServerAvailableList = AddPrefernces.vpnList;

  final RxBool isLoadingNewLoadingLocations = false.obs;

  Future<void> retrieveVpnInformation() async{
    isLoadingNewLoadingLocations.value = true;

    vpnFreeServerAvailableList.clear();

    vpnFreeServerAvailableList = await ApiVpnGet.retrieveAvailableFreeVpnServer();

    isLoadingNewLoadingLocations.value = false;
  }
}