import 'package:flutter/material.dart';


class CircleImage extends StatelessWidget {
  final double radius;
  final double size;
  final String urlImage;

  const CircleImage({
    Key? key,
    this.radius = 30.0,
    this.size = 60,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(1),

      width: size,
      height: size,

      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(radius)),

      child: CircleAvatar(
        backgroundImage: urlImage.startsWith('http')
            ? NetworkImage(urlImage)
            : Image.asset(urlImage).image,
      ),

      // decoration:
    );
  }
}