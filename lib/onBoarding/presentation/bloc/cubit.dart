import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/auth/presentation/screens/login.dart';
import 'package:merostore/core/services/routeing_page/reoute.dart';
import 'package:merostore/core/shared_preference/shared_preference.dart';
import 'package:merostore/onBoarding/data/data_sources/local_database.dart';
import 'package:merostore/onBoarding/data/models/model.dart';
import 'package:merostore/onBoarding/data/repositories/repo.dart';
import 'package:merostore/onBoarding/domain/repositories/base_repo.dart';
import 'package:merostore/onBoarding/domain/use_cases/use_case.dart';
import 'package:merostore/onBoarding/presentation/bloc/states.dart';

class AppOnBoardingCubit extends Cubit<AppOnBoardingStates>{


  AppOnBoardingCubit() : super(AppInitialOnBoardingStates()){
     BaseLocalDataBase baseLocalDataBase =LocalDataBase();
     BaseOnBoardingRepo baseOnBoardingRepo =OnBoardingRepo(baseLocalDataBase);
     list= OnBoardingUseCase(baseOnBoardingRepo).getOnBoarding();
     emit(AppGetData());
  }



  static AppOnBoardingCubit get(context)=>BlocProvider.of(context);
  List<OnBoardingModel> list=[];
  int page =0;
  int s =55;
  void changingPageView(context){
    if(page == list.length-1){
       CacheHelper.saveDate(key: 'onBoarding', value: true).then((value) =>
       {
         NavigetPages.pushReplacePage(const LoginScreen(), context)
       });
    }
    else
    {
      pageController.nextPage(
          duration: const Duration(milliseconds: 1000), curve: Curves.easeInBack);
    }
    emit(AppChangingPageView());
  }

  PageController pageController=PageController();

}