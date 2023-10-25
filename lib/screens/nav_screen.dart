import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_mobile/cubits/cubits.dart';
import 'package:netflix_mobile/screens/home_screen.dart';
import 'package:netflix_mobile/widgets/widgets.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(
      key: PageStorageKey('homeScreen'),
    ),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  final Map<String, IconData> _icons = const {
    'Trang chủ': Icons.home,
    'Tìm kiếm': Icons.search,
    'Sắp diễn ra': Icons.queue_play_next,
    'Tải xuống': Icons.file_download,
    'Thêm': Icons.menu,
  };
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider<AppBarCubit>(
        create: (context) => AppBarCubit(),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: !Responsive.isDesktop(context)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              items: _icons
                  .map((title, icon) => MapEntry(
                      title,
                      BottomNavigationBarItem(
                        icon: Icon(icon, size: 30.0),
                        label: title,
                      )))
                  .values
                  .toList(),
              currentIndex: _currentIndex,
              selectedItemColor: Colors.white,
              selectedFontSize: 11.0,
              unselectedFontSize: 11.0,
              unselectedItemColor: Colors.grey,
              onTap: (index) => setState(() {
                _currentIndex = index;
              }),
            )
          : null,
    );
  }
}
