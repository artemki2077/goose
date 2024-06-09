import 'package:flutter/material.dart';


import 'package:goose/ui/pages/main_pages/pages/home_page/home_page.dart';
import 'package:goose/ui/pages/main_pages/pages/profile_page/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index){
          setState(() {
            pageIndex = index;
            // print(pageIndex);
          });
        },
        children: const [
          HomePage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type : BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        // fixedColor: MainColors.gray2,
        // landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        onTap: (int indexPage){
          pageController.jumpToPage(indexPage);
        },
        currentIndex: pageIndex,
        selectedLabelStyle: const TextStyle(fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
    
  }
}