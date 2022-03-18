// // import 'dart:ffi';
// // import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:tactictrade/services/auth_service.dart';
// import 'package:http/http.dart' as http;
// import 'package:tactictrade/services/notifications_service.dart';
// import 'package:tactictrade/services/positions_service.dart';
// import 'package:tactictrade/widgets/generic_appbar_widget.dart';
// import 'package:tactictrade/widgets/user_appbar_widget.dart';

// class PositionScreen extends StatefulWidget {
//   const PositionScreen({Key? key}) : super(key: key);

//   @override
//   State<PositionScreen> createState() => _PositionScreenState();
// }

// class _PositionScreenState extends State<PositionScreen> {
//   final postionSevice = new PositionServices();

//   // print(WidgetsBinding.instance?.window.platformBrightness);
//   // Get the data when using RefreshControler
//   RefreshController _refreshController =
//       RefreshController(initialRefresh: false);

//   List<dynamic> PositionData = [];

//   @override
//   void initState() {
//     this._getPositions();
//     super.initState();
//   }

//   final String textNavBar = 'Prositions';
//   @override
//   Widget build(BuildContext context) {
//     final themeColors = Theme.of(context);
//     // final authService = Provider.of<AuthService>(context, listen: false);

//     return Scaffold(
//       // appBar: CustomAppBar(context),
//       // appBar: GenericAppBar(themeColors, context, 'Positions' ),
//       //Use the SmartRefreser here
//       body: Stack(
//         children: [SmartRefreshPositions()],
//       ),
//     );
//   }

//   SmartRefresher SmartRefreshPositions() {
//     return SmartRefresher(
//       controller: _refreshController,
//       child: _listViewPositions(),
//       enablePullDown: true,
//       onRefresh: _getPositions,
//       header: WaterDropHeader(
//         complete: Icon(Icons.check, color: Colors.blue[400]),
//         // waterDropColor: Colors.blue[400],
//       ),
//     );
//   }

//   _getPositions() async {
//     //TODO add request to api here

//     final url = Uri.http('localhost:8000', '/trading/positions');
//     setState(() {});
//     _refreshController.refreshCompleted();
//   }

//   ListView _listViewPositions() {
//     return ListView.separated(
//         itemBuilder: (_, i) => _PositionsListTitle(PositionData[i]),
//         separatorBuilder: (_, i) => const Divider(),
//         itemCount: PositionData.length);
//   }

//   Dismissible _PositionsListTitle(PositionData) {
//     print(PositionData);
//     print(PositionData['id']);

//     final stock = PositionData['symbol'];

//     return Dismissible(
//       key: Key(PositionData['id']),
//       direction: DismissDirection.startToEnd,
//       onDismissed: (direction) async {
//         //TODO call api for close the operation

//         print('Here is neccesary close the opreration');

//         final responseClosePosition =
//         // print(responseClosePosition.body['message']);

//         NotificationsService.showSnackbar(responseClosePosition);

//         showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text('Close Position ${stock}',
//                     style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold)),
//                 content: const Text('Are you sure of Close the Position?',
//                     style: TextStyle(
//                         color: Colors.black54,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w300)),
//                 actions: [
//                   MaterialButton(
//                     child: Text('Continue',
//                         style: TextStyle(
//                             color: Colors.red[500],
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold)),
//                     elevation: 5,
//                     onPressed: () {},
//                   ),
//                 ],
//               );
//             });
//       },
//       background: Container(
//         padding: EdgeInsets.only(left: 8.0),
//         color: Colors.red[400],
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: Row(
//             children: const [
//               Icon(Icons.close, color: Colors.white),
//               Text('Close Position',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 17,
//                       fontWeight: FontWeight.w600)),
//             ],
//           ),
//         ),
//       ),
//       child: ListTile(
//         title: Row(
//           children: [
//             Text(PositionData['symbol'],
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold)),
//             Text(' ' + PositionData['totalProfit'],
//                 style: TextStyle(
//                     color: PositionData['totalProfit'].contains('+')
//                         ? Colors.green[500]
//                         : Colors.red,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold)),
//             Text(' ' + PositionData['marketValue'],
//                 style: const TextStyle(
//                     color: Colors.black54,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w300)),
//           ],
//         ),
//         subtitle: Column(
//           children: [
//             Row(
//               children: [
//                 const Text('Bot',
//                     style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500)),
//                 Text(' ' + PositionData['tradingbot']),
//                 const Text(' E',
//                     style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500)),
//                 Text(PositionData['efficiencyBot'],
//                     style: TextStyle(
//                         color: Colors.blue[600],
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700)),
//               ],
//             ),
//             Row(
//               children: [
//                 const Text('Broker',
//                     style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500)),
//                 Text(' ' + PositionData['broker']),
//               ],
//             ),
//           ],
//         ),
//         leading: CircleAvatar(
//           //TODO fix the error when not found image.
//           backgroundImage: NetworkImage(
//               'https://universal.hellopublic.com/companyLogos/' +
//                   PositionData['symbol'] +
//                   '@2x.png'),
//         ),
//         trailing: Container(
//           width: 10,
//           height: 10,
//           decoration: BoxDecoration(
//               // color: PositionData.isActive ? Colors.green[300] : Colors.red,
//               color: Colors.green[300],
//               borderRadius: BorderRadius.circular(100)),
//         ),
//       ),
//     );
//   }
// }
