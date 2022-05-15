import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/home/pages/profile/profie_page.dart';
import 'package:projex_app/screens/home/pages/projects/projects_page.dart';
import 'package:projex_app/screens/home/pages/settings/settings_page.dart';
import 'package:projex_app/screens/home/widgets/home_fab.dart';
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

  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(editingProvider(EditReason.profile));
    return Scaffold(
      floatingActionButton: const HomeFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home,
          Icons.list,
          Icons.settings,
        ],
        activeColor: Colors.blue,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeIn,
          );
        }),
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
