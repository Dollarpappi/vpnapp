import 'package:flutter/material.dart';
import 'package:safevpn/main.dart';

class CustomRoundWidget extends StatelessWidget {
  final String title, subTitle;
  final Widget widgetIcon;

  const CustomRoundWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.widgetIcon});

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    return SizedBox(
      width: sizeScreen.width * 0.46,
      child: Column(
        children: [
          widgetIcon,
          const SizedBox(
            height: 7,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
             const SizedBox(
            height: 7,
          ),
            Text(
            subTitle,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
