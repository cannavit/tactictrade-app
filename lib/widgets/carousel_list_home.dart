import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/home_categories_provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class CarouselListHome extends StatelessWidget {
  final dynamic categoriesList;

  const CarouselListHome({
    Key? key,
    required this.categoriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final categoriesList = Provider.of<CategorySelected>(context);

    final themeColors = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 40,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categoriesList.categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categoriesList.categories[index].name;
          return GestureDetector(
            onTap: () {
              print(' --- --- --- --- --- --- --- ---');
              print('${categoriesList.categories[index].name}');
              categoriesList.selectedCategory =
                  categoriesList.categories[index].name;

              print('${categoriesList.categories[index].navigationPage}');

              // if (categoriesList.categories[index].navigationPage) {

              Navigator.pushReplacementNamed(context,
                  '${categoriesList.categories[index].navigationPage}');

              // };
            },
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color:
                        Preferences.isDarkmode ? Colors.white : Colors.white70,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    // Icon
                    Container(
                        // width: 12,
                        height: categoriesList.categories[index].icon != null
                            ? 30
                            : 0,
                        margin: categoriesList.categories[index].icon != null
                            ? const EdgeInsets.symmetric(horizontal: 14)
                            : const EdgeInsets.symmetric(horizontal: 0),
                        child: categoriesList.categories[index].icon != null
                            ? Icon(
                                categoriesList.categories[index].icon,
                                //Todo add dynamics colors.
                                // color: Colors.black54,
                                color:
                                    (categoriesList.selectedCategory == cName)
                                        ? themeColors.accentColor
                                        : const Color(0xff142A32),
                              )
                            : Icon(null)),

                    Text(
                      '${cName[0].toUpperCase()}${cName.substring(1)}',
                      style: TextStyle(
                          color: (categoriesList.selectedCategory == cName)
                              ? themeColors.accentColor
                              : Color(0xff142A32),
                          fontSize: 16,
                          fontWeight: (categoriesList.selectedCategory == cName)
                              ? FontWeight.w600
                              : FontWeight.w400),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
