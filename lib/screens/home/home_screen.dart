import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/home/pages/profile/profie_page.dart';
import 'package:projex_app/screens/home/pages/projects/projects_page.dart';
import 'package:projex_app/screens/home/pages/settings/settings_page.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:projex_app/state/editing.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final colorMappings = <int, Color>{
    0: Colors.blue,
    1: Colors.green,
    2: Colors.teal,
  };
  final icons = [
    Icons.home,
    Icons.list,
    Icons.settings,
  ];
  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(editingProvider(EditReason.profile));
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: AnimatedBottomNavigationBar(
          icons: icons,
          gapWidth: 0,
          activeColor: colorMappings[_selectedIndex],
          activeIndex: _selectedIndex,
          onTap: (index) => setState(
            () {
              _selectedIndex = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeIn,
              );
            },
          ),
        ),
      ),
      body: PageView(
        physics: isEditing ? const NeverScrollableScrollPhysics() : null,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: const [
          HomeProfilePage(),
          HomeProjectsPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
