import 'package:cinetix_id/domain/entities/user.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final User user;
  const MainPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineTix ID'),
      ),
      body: Center(
        child: Text(user.toString()),
      ),
    );
  }
}
