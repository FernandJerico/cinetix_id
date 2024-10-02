import 'package:cinetix_id/presentation/extensions/build_context_extension.dart';
import 'package:cinetix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../misc/method.dart';
import '../../providers/router/router_provider.dart';
import '../../widgets/button_loading.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_text_field.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          ref.read(routerProvider).goNamed('main');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: ListView(children: [
        verticalSpace(50),
        Image.asset(
          'assets/images/cinetix-logo.png',
          height: sizes.height * 0.2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                verticalSpace(20),
                CustomTextField(
                  label: 'Name',
                  controller: nameController,
                ),
                verticalSpace(16),
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
                verticalSpace(16),
                CustomTextField(
                  label: 'Confirm Password',
                  controller: confirmController,
                  obscureText: true,
                ),
                verticalSpace(16),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? Button.filled(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (passwordController.text ==
                                  confirmController.text) {
                                ref.read(userDataProvider.notifier).register(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                              } else {
                                context.showSnackBar('Password not match');
                              }
                            }
                          },
                          label: 'Register',
                        )
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
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        ref.read(routerProvider).goNamed('login');
                      },
                      child: const Text('Login'),
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
