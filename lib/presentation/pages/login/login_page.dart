import 'package:cinetix_id/data/dummies/dummy_authentication.dart';
import 'package:cinetix_id/data/dummies/dummy_user_repositort.dart';
import 'package:cinetix_id/domain/usecases/login/login_params.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/login/login.dart';
import '../main_page/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                Login login = Login(
                    authentication: DummyAuthentication(),
                    userRepository: DummyUserRepositort());

                login(LoginParams(
                        email: 'fernand@gmail.com', password: 'password'))
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
