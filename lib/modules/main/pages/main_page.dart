import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ninen/modules/home/cubit/home_cubit.dart';
import 'package:ninen/modules/home/pages/home_page.dart';
import 'package:ninen/modules/main/cubit/main_cubit.dart';
import 'package:ninen/modules/progress/pages/progress_page.dart';
import 'package:ninen/modules/purposes/pages/purposes_page.dart';
import 'package:ninen/modules/setting/pages/setting_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainView([
      HomePage(),
      ProgressPage(),
      PurposesPage(),
      SettingPage(),
    ]);
  }
}

class MainView extends StatefulWidget {
  const MainView(this.items, {super.key});

  final List<Widget> items;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    context.read<HomeCubit>().saveAuth(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.items[context.watch<MainCubit>().state],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffffffff),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home_icon.svg'),
            label: '',
            activeIcon: SvgPicture.asset('assets/icons/home_icon_active.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/analitik_icon.svg'),
            label: '',
            activeIcon:
                SvgPicture.asset('assets/icons/analitik_icon_active.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/star_icon.svg'),
            label: '',
            activeIcon: SvgPicture.asset(
              'assets/icons/star_icon_active.svg',
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/setting_icon.svg'),
            label: '',
            activeIcon:
                SvgPicture.asset('assets/icons/setting_icon_active.svg'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: context.watch<MainCubit>().state,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (value) => context.read<MainCubit>().change(value),
      ),
    );
  }
}
