//checks the status of the vpn
import 'dart:async';

class VpnStatus {
  String? byteIn;
  String? byteOut;
  String? durationTime;
  String? laskPacketReceive;

  VpnStatus({
    this.byteIn,
    this.byteOut,
    this.durationTime,
    this.laskPacketReceive
  });

  factory VpnStatus.fromJson(Map<String, dynamic> jsonData) => VpnStatus(
    durationTime: jsonData["duration"],
    laskPacketReceive: jsonData["last_packet_receive"],
    byteIn: jsonData["byte_in"],
    byteOut: jsonData["byte_out"],
  );

  Map<String, dynamic> toJson() => {
    "byte_in": byteIn,
    "byte_out": byteOut,
    "duration": durationTime,
    "last_packet_receive": laskPacketReceive,
  };
}