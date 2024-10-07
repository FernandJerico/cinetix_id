import 'package:cinetix_id/presentation/extensions/int_extension.dart';
import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:cinetix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/router/router_provider.dart';

Widget userInfo(WidgetRef ref) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 2, 24, 0),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: ref.watch(userDataProvider).valueOrNull?.photoUrl !=
                            null
                        ? NetworkImage(
                            ref.watch(userDataProvider).value!.photoUrl!)
                        : const AssetImage('assets/images/pp-placeholder.png')
                            as ImageProvider,
                    fit: BoxFit.cover)),
          ),
          horizontalSpace(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${getGreeting()}, ${ref.watch(userDataProvider).when(
                      data: (data) => data?.name.split(' ').first ?? '',
                      error: (error, stackTrace) => '',
                      loading: () => 'Loading',
                    )}!',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Let\'s find your favorite movie!',
                style: TextStyle(fontSize: 12),
              ),
              verticalSpace(6),
              GestureDetector(
                onTap: () {
                  ref.read(routerProvider).pushNamed('wallet');
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset('assets/images/wallet.png'),
                    ),
                    horizontalSpace(10),
                    Text(
                      ref.watch(userDataProvider).when(
                            data: (data) =>
                                (data?.balance ?? 0).toIDRCurrencyFormat(),
                            error: (error, stackTrace) => 'IDR 0',
                            loading: () => 'Loading...',
                          ),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}
