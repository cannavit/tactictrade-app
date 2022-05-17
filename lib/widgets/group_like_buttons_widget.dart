import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';


class GroupLikeButtons extends StatelessWidget {
  final String numberLikes;

  const GroupLikeButtons({
    Key? key,
    required this.numberLikes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      // color: Colors.orange,
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              // const SizedBox(width: 10),
              FavoriteButton(
                iconSize: 30,
                valueChanged: (_isFavorite) {
                  print('Is Favorite $_isFavorite)');
                },
              ),
              Text(numberLikes,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500))
            ],
          )),
          StarButton(
            iconSize: 40,
            valueChanged: (_isFavorite) {},
          ),
        ],
      ),
    ));
  }
}