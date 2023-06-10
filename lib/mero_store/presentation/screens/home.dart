import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/mero_store/presentation/bloc/cubit.dart';
import 'package:merostore/mero_store/presentation/bloc/states.dart';
import 'package:merostore/mero_store/presentation/widgets/products_home_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {

    return
    BlocProvider(create: (context)=>AppCubit()..getHomeData(context)..getCategories(context)..getFavoritesData(context)..getProfileData(context),
    child:  BlocConsumer<AppCubit,AppStates>(
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: Theme.of(context).primaryColor,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Theme.of(context).primaryColor
            ),
            title: const Center(child: Text('Mero Store')),
            actions: [
              IconButton(onPressed: (){},
                icon: const Icon(Icons.search),),
              IconButton(onPressed: (){},
                  icon: const Icon(Icons.shopping_cart_checkout_sharp)
              )
            ],
            elevation: 0,
          ),
          body:
          PersistentTabView(
            context,
            controller: AppCubit.get(context).controller,
            screens: AppHomeWidgets.screens,
            items: AppHomeWidgets.navBarsItems(context),
            confineInSafeArea: true,
            backgroundColor: Colors.white, // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: false, // Default is true.
            hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),

            navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
          ),
        );
      },
      listener: (context,state){},
    ),
    );


  }
}

