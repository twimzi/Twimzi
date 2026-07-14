import 'package:flutter/material.dart';

import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../business/presentation/pages/business_page.dart';
import '../../../chat/presentation/pages/chat_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../search/presentation/pages/search_page.dart';
import '../widgets/categories_section.dart';
import '../widgets/featured_businesses.dart';
import '../widgets/home_header.dart';
import '../widgets/nearby_businesses.dart';
import '../widgets/new_businesses.dart';
import '../widgets/offers_slider.dart';
import '../widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    _homeTab(),
    const SearchPage(),
    const BusinessPage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TwimziBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
    );
  }

  Widget _homeTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        HomeHeader(),
        SizedBox(height: 20),
        SearchBarWidget(),
        SizedBox(height: 24),
        OffersSlider(),
        SizedBox(height: 24),
        CategoriesSection(),
        SizedBox(height: 24),
        FeaturedBusinesses(),
        SizedBox(height: 24),
        NearbyBusinesses(),
        SizedBox(height: 24),
        NewBusinesses(),
        SizedBox(height: 100),
      ],
    );
  }
}