import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransactionRecordRowWidget extends StatelessWidget {

  const TransactionRecordRowWidget({
    Key? key,
    required this.qty_open,
    required this.qty_close,
    required this.price_open,
    required this.price_closed,
    required this.base_cost,
    required this.close_cost,
    required this.amount_open,
    required this.amount_close,
    required this.spread,
    required this.order,
    required this.operation,
    required this.create_at,
    required this.updated_at,
    required this.is_winner,
    required this.profit,
    required this.profit_percentage,
  }) : super(key: key);

  final double qty_open;
  final double qty_close;
  final double price_open;
  final double price_closed;
  final double base_cost;
  final double close_cost;
  final double amount_open;
  final double amount_close;
  final double spread;
  final String order;
  final String operation;
  final String create_at;
  final String updated_at;
  final bool is_winner;
  final double profit;
  final double profit_percentage;

  // final iconShort = CupertinoIcons.arrow_down_right;
  // const iconLong = CupertinoIcons.arrow_up_right;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),


      child: Row(children: [


        // Operation

        Column(children: [

          Text('${operation}'.toUpperCase(),
            style: GoogleFonts.openSans( textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w400))
                ),

          const SizedBox(height: 4),
          
          Icon(
            operation == 'long' ? CupertinoIcons.arrow_up_right : CupertinoIcons.arrow_down_right, 
            color: operation == 'long' ? Colors.green : Colors.red,
            size: 18,
          ),
        
        ],),

        const SizedBox(width: 8 ),
        
        Column(children: [

          Text('BUY',
            style: GoogleFonts.openSans( textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600))
                ),
          const SizedBox(height: 8),

          Text('SELL',
            style: GoogleFonts.openSans( textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600))
                ),
        
        ],),

        const SizedBox(width: 8 ),


        Column(children: [

          Text('${create_at}',
            style: GoogleFonts.openSans( textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w400))
                ),
          const SizedBox(height: 8),

          Text('${updated_at}',
            style: GoogleFonts.openSans( textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w400))
                ),
        
        ],),

        const SizedBox(width: 8 ),

        Column(children: [

          Text('${qty_open}',
            style: GoogleFonts.openSans( textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w400))
                ),
          const SizedBox(height: 8),

          Text('${qty_close}',
            style: GoogleFonts.openSans( textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w400))
                ),
        
        ],),

        const SizedBox(width: 8 ),

        Column(children: [

          Text('${price_open}',
            style: GoogleFonts.openSans( textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w400))
                ),
          const SizedBox(height: 8),

          Text('${price_closed}',
            style: GoogleFonts.openSans( textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w400))
                ),
        
        ],),

        const SizedBox(width: 8 ),


        Column(children: [

          Text('${base_cost}',
            style: GoogleFonts.openSans( textStyle:  TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w600))
                ),
          const SizedBox(height: 6),
          
          Text('USD',
            style: GoogleFonts.openSans( textStyle:  TextStyle(
                color: Colors.blue,
                fontSize: 12,
                fontWeight: FontWeight.w600))
                ),        
        ],),

        const SizedBox(width: 8 ),
        
        Column(children: [

          Text('${profit_percentage}',
            style: GoogleFonts.openSans( textStyle:  TextStyle(
                color: is_winner ? Colors.green : Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w600))
                ),
          const SizedBox(height: 3),
          
          Text('%',
            style: GoogleFonts.openSans( textStyle:  TextStyle(
                color: is_winner ? Colors.green : Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w600))
                ),        
        ],),




        // Column(children: [

        //   Text('${operation}',
        //     style: GoogleFonts.openSans( textStyle: const TextStyle(
        //         color: Colors.white,
        //         fontSize: 15,
        //         fontWeight: FontWeight.w300))
        //         ),
        //   Icon(
        //     operation == 'long' ? CupertinoIcons.arrow_up_right : CupertinoIcons.arrow_down_right, 
        //     color: operation == 'long' ? Colors.green : Colors.red,
        //   ),
        
        // ],),



        // Text('${qty_open}',
        //     style: GoogleFonts.openSans( textStyle: const TextStyle(
        //         color: Colors.white,
        //         fontSize: 15,
        //         fontWeight: FontWeight.w300))
                
        //         ),



        // Text('dasdsd 2',
        //     style: TextStyle(
        //         color: Colors.black54,
        //         fontSize: 15,
        //         fontWeight: FontWeight.w300)),



      ]),
    );
  }
}
