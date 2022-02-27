import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class CustomProfilImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final IconData icon;

  const CustomProfilImage(
      {Key? key,
      required this.imagePath,
      required this.onClicked,
      this.icon = Icons.edit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            child: buildEditImageIcon(themeColors.primaryColor, icon),
            bottom: 0,
            right: 1,
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = imagePath.contains('http')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 148,
          height: 148,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditImageIcon(Color color, IconData icon) => ClipOval(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(3),
          child: ClipOval(
            child: Container(
                color: color,
                padding: const EdgeInsets.all(8),
                child: Icon(icon, size: 20, color: Colors.white)),
          ),
        ),
      );
}
