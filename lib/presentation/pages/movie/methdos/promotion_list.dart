import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> promotionList(List<String> promotionsImageFilename) => [
      Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 16),
        child: Text(
          'Promotions',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: promotionsImageFilename
                .map((filename) => Container(
                      width: 240,
                      height: 160,
                      margin: EdgeInsets.only(
                          left: filename == promotionsImageFilename.first
                              ? 24
                              : 10,
                          right: filename == promotionsImageFilename.last
                              ? 24
                              : 0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/$filename'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                    ))
                .toList()),
      )
    ];
