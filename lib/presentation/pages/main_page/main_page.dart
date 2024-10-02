import 'package:cinetix_id/presentation/extensions/build_context_extension.dart';
import 'package:cinetix_id/presentation/widgets/bottom_navbar.dart';
import 'package:cinetix_id/presentation/widgets/bottom_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (previous != null && next is AsyncData && next.value == null) {
          ref.read(routerProvider).goNamed('login');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                selectedPage = index;
              });
            },
            children: const [
              Center(child: Text('Home')),
              Center(child: Text('Ticket')),
              Center(child: Text('Profile')),
            ],
          ),
          BottomNavbar(
              items: [
                BottomNavbarItem(
                  index: 0,
                  isSelected: selectedPage == 0,
                  title: 'Home',
                  image: 'assets/images/movie.png',
                  selectedImage: 'assets/images/movie-selected.png',
                ),
                BottomNavbarItem(
                  index: 1,
                  isSelected: selectedPage == 1,
                  title: 'Ticket',
                  image: 'assets/images/ticket.png',
                  selectedImage: 'assets/images/ticket-selected.png',
                ),
                BottomNavbarItem(
                  index: 2,
                  isSelected: selectedPage == 2,
                  title: 'Profile',
                  image: 'assets/images/profile.png',
                  selectedImage: 'assets/images/profile-selected.png',
                ),
              ],
              onTap: (index) {
                selectedPage = index;

                pageController.animateToPage(selectedPage,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut);
              },
              selectedIndex: 0),
        ],
      ),
    );
  }
}
