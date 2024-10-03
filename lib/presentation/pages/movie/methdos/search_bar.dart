import 'package:flutter/material.dart';

Widget searchBar(BuildContext context) => Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 24 - 24 - 90,
          height: 50,
          margin: const EdgeInsets.only(left: 24, right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF252836),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            style: TextStyle(color: Colors.grey.shade400),
            decoration: InputDecoration(
                hintText: 'Search movie',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: InputBorder.none,
                icon: const Icon(Icons.search)),
          ),
        ),
        SizedBox(
          height: 50,
          width: 80,
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: const Center(
              child: Icon(Icons.search),
            ),
          ),
        )
      ],
    );
