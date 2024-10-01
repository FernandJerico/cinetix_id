import 'package:cinetix_id/domain/usecases/login/login_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/login/login.dart';
import '../../providers/usecases/login_provider.dart';
import '../main_page/main_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                Login login = ref.watch(loginProvider);

                login(LoginParams(
                        email: 'fernand@gmail.com', password: 'zxczxc'))
                    .then((result) {
                  if (result.isSuccess && context.mounted) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MainPage(user: result.resultValue!)));
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.errorMessage!)));
                    }
                  }
                });
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
