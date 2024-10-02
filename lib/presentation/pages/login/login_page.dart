import 'package:cinetix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/router/router_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed('main');
          }
        } else if (next is AsyncError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(next.error.toString()),
          ));
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineTix ID'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login'),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(userDataProvider.notifier)
                    .login(email: 'fernand@gmail.com', password: 'zxczxc');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
