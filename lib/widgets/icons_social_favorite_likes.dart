import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/strategies_services.dart';
import '../share_preferences/preferences.dart';



class IconsSocialFavoriteLike extends StatefulWidget {
  const IconsSocialFavoriteLike({
    Key? key,
    required this.isFavorite,
    required this.idStrategy,
    required this.likesNumber,
    required this.isStarred,
  }) : super(key: key);

  final bool isFavorite;
  final int idStrategy;
  final int likesNumber;
  final bool isStarred;

  @override
  State<IconsSocialFavoriteLike> createState() =>
      IconsSocialFavoriteLikeState();
}

class IconsSocialFavoriteLikeState extends State<IconsSocialFavoriteLike> {
  @override
  Widget build(BuildContext context) {
    
    final strategySocial = Provider.of<StrategySocial>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          // Like Icon

          Container(
            // Star Favorite
            child: Row(
              children: [
                StarButton(
                  iconColor: Colors.yellow.shade900,
                  iconDisabledColor: const Color.fromARGB(161, 178, 178, 178),
                  iconSize: 40,
                  isStarred: widget.isStarred,
                  valueChanged: (_isFavorite) {
                    Preferences.updateTheStrategies = true;
                    print('Is Favorite $_isFavorite)');
                    strategySocial
                        .put(widget.idStrategy, {"favorite": _isFavorite});
                  },
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Row(
            children: [
              FavoriteButton(
                iconSize: 30,
                isFavorite: widget.isFavorite,
                iconDisabledColor: const Color.fromARGB(161, 178, 178, 178),
                valueChanged: (_isFavorite) {
                  print('Is Favorite $_isFavorite)');

                  Preferences.updateTheStrategies = true;

                  strategySocial
                      .put(widget.idStrategy, {"likes": _isFavorite});

                  setState(() {});
                },
              ),
              const SizedBox(width: 10),
              Text('${widget.likesNumber}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300)),
            ],
          ),

          Expanded(child: Container()),
        ],
      ),
    );
  }
}