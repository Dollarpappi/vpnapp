import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safevpn/addPrefernces/add_prefernces.dart';
import 'package:safevpn/addPrefernces/vpnEngine/vpn_engine.dart';
import 'package:safevpn/allControllers/allModels/vpn_status.dart';
import 'package:safevpn/allControllers/controller_home.dart';
import 'package:safevpn/allWidgets/custom_widget.dart';
import 'package:safevpn/main.dart';
import 'package:safevpn/screens/available_vpn_servers_location_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(ControllerHome());

  locationSelectedBottomNavigation(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: () {
          Get.to(() => AvailableVpnServersLocationScreen());
        },
        child: Container(
          color: const Color.fromARGB(255, 40, 129, 180),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 62,
          child: const Row(
            children: [
              Icon(
                CupertinoIcons.flag_circle,
                color: Colors.white,
                size: 36,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "Select Country / location",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.blueAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget vpnRoundButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.amber),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeController.getRoundButtonColor.withOpacity(.1),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: sizeScreen.width * .2,
                  height: sizeScreen.height * .2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.getRoundButtonColor.withOpacity(.3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color:
                            homeController.getRoundButtonColor.withOpacity(.1),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        "Tap to connect",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen(
      (event) {
        homeController.vpnConnectionState.value = event;
      },
    );
    sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 129, 180),
        title: const Text("Safe VPN"),
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.perm_device_info)),
        actions: [
          IconButton(
              onPressed: () {
                Get.changeThemeMode(AddPrefernces.isModeDark
                    ? ThemeMode.light
                    : ThemeMode.dark);
                //if true it will become not true vise vasa
                AddPrefernces.isModeDark = !AddPrefernces.isModeDark;
              },
              icon: const Icon(Icons.brightness_2_outlined)),
        ],
      ),
      bottomNavigationBar: locationSelectedBottomNavigation(context),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///location + ping
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //location
                  CustomRoundWidget(
                      title:
                          homeController.vpninfo.value.countryLongName.isEmpty
                              ? "Location"
                              : homeController.vpninfo.value.countryLongName,
                      subTitle: "Free",
                      widgetIcon: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.purpleAccent,
                        child:
                            homeController.vpninfo.value.countryLongName.isEmpty
                                ? const Icon(
                                    Icons.flag_circle,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : null,
                        backgroundImage: homeController
                                .vpninfo.value.countryLongName.isEmpty
                            ? null
                            : AssetImage(
                                "assets/countryFlags/${homeController.vpninfo.value.countryShortName.toLowerCase()}"),
                      )),

                  //ping
                  CustomRoundWidget(
                      title:
                          homeController.vpninfo.value.countryLongName.isEmpty
                              ? "60 ms"
                              : homeController.vpninfo.value.ping + " ms",
                      subTitle: "Ping",
                      widgetIcon: const CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.amberAccent,
                        child: Icon(
                          Icons.graphic_eq,
                          size: 30,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),

            //vpn button
            vpnRoundButton(),

            //download and upload
            StreamBuilder<VpnStatus?>(
              stream: VpnEngine.snapshotVpnStatus(),
              initialData: VpnStatus(),
              builder: (context, dataSnapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRoundWidget(
                        title: dataSnapshot.data?.byteIn ?? "0 kbps",
                        subTitle: "Download",
                        widgetIcon: const CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.arrow_circle_down,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                    CustomRoundWidget(
                        title: dataSnapshot.data?.byteOut ?? "0 kbps",
                        subTitle: "Upload",
                        widgetIcon: const CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.arrow_circle_up,
                            size: 30,
                            color: Colors.white,
                          ),
                        ))
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
