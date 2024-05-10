import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_pay/blocs/transaction/transaction_bloc.dart';
import 'package:full_pay/blocs/user_cards/user_cards_bloc.dart';
import 'package:full_pay/blocs/user_cards/user_cards_event.dart';
import 'package:full_pay/screens/routes.dart';
import 'package:full_pay/screens/tab/card/card_screen.dart';
import 'package:full_pay/screens/tab/history/history_screen.dart';
import 'package:full_pay/screens/tab/home/home_screen.dart';
import 'package:full_pay/screens/tab/profile/profile_screen.dart';
import 'package:full_pay/utils/images/app_images.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  List<Widget> _screens = [];
  int _activeIndex = 0;

  @override
  void initState() {
    _screens = [
      HomeScreen(),
      HistoryScreen(),
      CardScreen(),
      ProfileScreen(),
    ];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_activeIndex],
      bottomNavigationBar: SizedBox(
        height: 90.h,
        child: BottomNavigationBar(
          selectedLabelStyle: AppTextStyle.interBlack,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.4),

          currentIndex:_activeIndex,
          onTap: (newActiveIndex){_activeIndex = newActiveIndex; setState(() {

          });},
          items: [
            BottomNavigationBarItem(

              icon: SvgPicture.asset(AppImages.home,height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
              label: "Home",
              activeIcon: SvgPicture.asset(AppImages.home,height: 36, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),),
            ),
            BottomNavigationBarItem(

              icon: SvgPicture.asset(AppImages.history,height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
              label: "History",
              activeIcon: SvgPicture.asset(AppImages.history,height: 36, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),),
            ),
            BottomNavigationBarItem(

              icon: SvgPicture.asset(AppImages.cardIcon,height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
              label: "Cards",
              activeIcon: SvgPicture.asset(AppImages.cardIcon,height: 36, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),),
            ),
            BottomNavigationBarItem(

              icon: SvgPicture.asset(AppImages.profileTab,height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
              label: "Profile",
              activeIcon: SvgPicture.asset(AppImages.profileTab,height: 36, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // context.read<TransactionBloc>().add(SetInitialEvent());
        context.read<UserCardsBloc>().add(GetCardsByUserIdEvent(userId: FirebaseAuth.instance.currentUser!.uid));
        Navigator.pushNamed(context, RouteNames.transferRoute);
      },
      child: Icon(Icons.add_card),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
