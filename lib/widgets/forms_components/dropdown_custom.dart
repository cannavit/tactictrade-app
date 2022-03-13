import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../share_preferences/preferences.dart';
import '../strategyCard.dart';

class DropDownSelectBroker extends StatefulWidget {
  const DropDownSelectBroker({Key? key, required this.brokerList})
      : super(key: key);

  final dynamic brokerList;

  @override
  State<DropDownSelectBroker> createState() => _DropDownSelectBrokerState();
}

class _DropDownSelectBrokerState extends State<DropDownSelectBroker> {
  @override
  Widget build(BuildContext context) {
    //  final themeColors = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    dynamic? selectedValue;
    // Preferences.selectedBrokerInFollowStrategy = 'Select your broker';

    final dataItem = widget.brokerList[0]['broker'];
    print(dataItem);

    var itemsData = [];

    for (var data in widget.brokerList) {
      print(data);

      itemsData.add({
        'id': data['id'].toString(),
        'name': data['brokerName'],
        'type': data['broker']
      });
    }

    return Container(
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            buttonWidth: MediaQuery.of(context).size.height * 0.7,
            isExpanded: true,
            hint: Row(
              children: const [
                Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'Select your broker',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: itemsData
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: item['type'] == 'paperTrade'
                                      ? AssetImage(
                                          'assets/ReduceBrokerTacticTradeIcon.png')
                                      : AssetImage('assets/AlpacaMiniLogo.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const SizedBox(height: 5, width: 10),
                          Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {

              Preferences.selectedBrokerInFollowStrategy = json.encode(value);

              setState(() {
                selectedValue = value;
              });
            },
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.grey,
            iconDisabledColor: Colors.grey,
            buttonHeight: 50,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: themeProvider.currentTheme.scaffoldBackgroundColor,
              ),
              color: themeProvider.currentTheme.scaffoldBackgroundColor,
            ),
            buttonElevation: 4,
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownWidth: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: themeProvider.currentTheme
                  .scaffoldBackgroundColor, //TODO Add the colors join Preferences.
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0),
          ),
        ),
      ),
    );
  }
}
