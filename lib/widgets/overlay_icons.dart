import 'package:assignment/utils/size_config.dart';
import 'package:flutter/material.dart';

class OverlayIcons extends StatelessWidget {
  const OverlayIcons({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                onTap;
              },
              icon: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            verticalSpaceTiny,
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
