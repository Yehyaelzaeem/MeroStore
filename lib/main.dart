import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/auth/presentation/bloc/cubit.dart';
import 'package:merostore/auth/presentation/screens/change_password.dart';
import 'package:merostore/auth/presentation/screens/login.dart';
import 'package:merostore/auth/presentation/screens/update_profile.dart';
import 'package:merostore/core/network/dio.dart';
import 'package:merostore/core/shared_preference/shared_preference.dart';
import 'package:merostore/mero_store/presentation/bloc/cubit.dart';
import 'package:merostore/mero_store/presentation/screens/home.dart';
import 'package:merostore/mero_store/presentation/screens/products.dart';
import 'package:merostore/onBoarding/presentation/bloc/cubit.dart';
import 'core/bloc_observer/bloc_observer.dart';
import 'core/services/services_locator.dart';
import 'onBoarding/presentation/screens/onboarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  // ServicesLocator().init();
  DioHelper.init();
  await CacheHelper.init();
  // await CacheHelper.saveDate(key: 'lang', value: 'en');
  Widget widget;
  var onBoarding = await CacheHelper.getDate(key: 'onBoarding');
  var token = await CacheHelper.getDate(key: 'token');
   print(onBoarding);
   print(token);
  if(onBoarding != null)
  {
    if(token !=null){
      widget =const Home();
    }
    else{
      widget =const LoginScreen();
    }

  }
  else{
    widget = const OnBoardingScreen();
  }

  runApp( MyApp(widget: widget,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.widget});
 final Widget widget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (context) => AppOnBoardingCubit()),
        BlocProvider(create: (context)=>AuthCubit(),),
          BlocProvider(create: (context)=>AppCubit(),),
          // BlocProvider(create: (context)=>AppCubit()..saveLanguage(),),
          // BlocProvider(create: (context)=>AppCubit()..getHomeData(context)..getCategories(context)..getFavoritesData(context)..getProfileData(context),),
        ],
        child:MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MeroStore',
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primaryColor: const Color(0xff8ca1fc),
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.red,
                    ),
                    elevation: 0
                )
              // useMaterial3: true,
            ),
            themeMode: ThemeMode.light,
            darkTheme:ThemeData(
                scaffoldBackgroundColor: Colors.black,
                primaryColor: const Color(0xff1c2860),
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.blueGrey,
                    ),
                    elevation: 0
                )
              // useMaterial3: true,
            ) ,
            home: widget
        ),
    );
  }
}

