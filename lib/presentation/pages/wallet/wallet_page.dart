import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/router/router_provider.dart';
import '../../widgets/back_navigation_bar.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                BackNavigationBar(
                  title: 'My Wallet',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                // const WalletCard(),
                verticalSpace(24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
