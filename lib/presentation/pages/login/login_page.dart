import 'package:cinetix_id/presentation/extensions/build_context_extension.dart';
import 'package:cinetix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:cinetix_id/presentation/widgets/button_loading.dart';
import 'package:cinetix_id/presentation/widgets/buttons.dart';
import 'package:cinetix_id/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../misc/method.dart';
import '../../providers/router/router_provider.dart';

class LoginPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizes = MediaQuery.of(context).size;
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed('main');
          }
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: ListView(children: [
        verticalSpace(100),
        Image.asset(
          'assets/images/cinetix-logo.png',
          height: sizes.height * 0.2,
        ),
        verticalSpace(50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  label: 'Email',
                  controller: emailController,
                ),
                verticalSpace(16),
                CustomTextField(
                  label: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                verticalSpace(8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // ref.read(routerProvider).goNamed('register');
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                verticalSpace(16),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? Button.filled(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ref.read(userDataProvider.notifier).login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          label: 'Login')
                      : ButtonLoading.filled(
                          onPressed: () {},
                        ),
                  _ => ButtonLoading.filled(
                      onPressed: () {},
                    ),
                },
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        // ref.read(routerProvider).goNamed('register');
                      },
                      child: const Text('Register'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
