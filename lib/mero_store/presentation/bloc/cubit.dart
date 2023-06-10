import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/mero_store/data/data_sources/home_datasource.dart';
import 'package:merostore/mero_store/data/models/categories_model.dart';
import 'package:merostore/mero_store/data/models/favorit_editing_model.dart';
import 'package:merostore/mero_store/data/models/get_favorites_model.dart';
import 'package:merostore/mero_store/data/models/home_model.dart';
import 'package:merostore/mero_store/data/models/profile_model.dart';
import 'package:merostore/mero_store/data/repositories/home_repo.dart';
import 'package:merostore/mero_store/domain/repositories/base_home_repo.dart';
import 'package:merostore/mero_store/domain/use_cases/home_usecase.dart';
import 'package:merostore/mero_store/presentation/bloc/states.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialStates());
  static AppCubit get(context)=>BlocProvider.of(context);
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
 bool isDarkMode =false;
  bool isLoading=true;
  bool isSignOut=false;
  Map<int ,bool> favorites={};
  FavoritesEditingModel? favoritesEditingModel ;
  FavoritesEditingModel? signOutModel ;
  CategoriesModel? categoriesModel;
  HomeDataModel? homeDataModel;
  FavoritesModel? favoritesModel;
  ProfileModel? profileModel;
  void darkMode(bool x){
    isDarkMode =x;
    emit(DarkModeStates());
  }

 Future getHomeData(context)async{
   homeDataModel =null;
   emit(AppHomeLoadingStates());
   BaseHomeDataSource baseHomeDataSource =HomeDataSource();
   BaseHomeRepo baseHomeRepo =HomeRepo(baseHomeDataSource);
     await HomeUseCase(baseHomeRepo).getHomeData(context).then((value) => {
         homeDataModel =value,
         homeDataModel!.homeData.products.forEach((element) {
         favorites.addAll({
           element.id: element.inFavorites,
         });
       }),
       if(homeDataModel!.status==true){
         emit(AppHomeSuccessStates(homeDataModel!))
       }else{
         emit(AppHomeErrorStates('error')),
       }
     });
    emit(AppGetHomeDataStates());
  }

  Future getCategories(context)async{
   BaseHomeDataSource baseHomeDataSource =HomeDataSource();
   BaseHomeRepo baseHomeRepo =HomeRepo(baseHomeDataSource);
   await HomeUseCase(baseHomeRepo).getCategoriesDate(context).then((value) =>
    {
      categoriesModel=value,
      if(categoriesModel!.status==true){
        emit(AppCategoriesSuccessStates(categoriesModel!)),
      }
      else{
        emit(AppCategoriesErrorStates()),
      }
    });
    emit(AppGetCategoriesDataStates());
  }

  Future editeFavorites(int id,context)async{
      favorites[id] = !favorites[id]!;
      emit(FavoritesEditingStates());
     BaseHomeDataSource baseHomeDataSource =HomeDataSource();
     BaseHomeRepo baseHomeRepo =HomeRepo(baseHomeDataSource);
      await HomeUseCase(baseHomeRepo).editFavoritesDate(id,context).then((value) =>
      {
        favoritesEditingModel=value,
        if(favoritesEditingModel!.status==false){
          favorites[id] = !favorites[id]!,
          emit(FavoritesErrorStates(favoritesEditingModel!)),
            }
        else{
          getFavoritesData(context),
          emit(FavoritesSuccessStates(favoritesEditingModel!)),
           }
      });
      emit(FavoritesEditingStates());
    }


  Future getFavoritesData(context)async{
    BaseHomeDataSource baseHomeDataSource =HomeDataSource();
    BaseHomeRepo baseHomeRepo =HomeRepo(baseHomeDataSource);
    await HomeUseCase(baseHomeRepo).getFavorites(context).then((value) => {
      favoritesModel=value,
       if(favoritesModel!.status==true){
         emit(GetFavoritesSuccessStates(favoritesModel!)),
       }
       else{
         emit(GetFavoritesErrorStates(favoritesModel!)),
       },
    });
    emit(GetFavoritesStates());
  }

  Future getProfileData(context)async{
    BaseHomeDataSource baseHomeDataSource =HomeDataSource();
    BaseHomeRepo baseHomeRepo =HomeRepo(baseHomeDataSource);
    await HomeUseCase(baseHomeRepo).getProfile(context).then((value) => {
         profileModel=value,
       if(profileModel!.status==true){
         emit(ProfileSuccessStates(profileModel!)),
       }
       else{
         emit(ProfileErrorStates(profileModel!)),
       },
    });
    emit(ProfileStates());
  }

  // Future saveLanguage(String lang,context)async{
  //    CacheHelper.saveDate(key: 'lang', value: lang).then((value) => {
  //      getFavoritesData(context),
  //    emit(GetFavoritesStates()),
  //    });
  //   emit(LanguageStates());
  // }

  Future signOut(context)async{
    isSignOut=true;
    emit(SignOutStates());
    BaseHomeDataSource baseHomeDataSource =HomeDataSource();
    BaseHomeRepo baseHomeRepo =HomeRepo(baseHomeDataSource);
    await HomeUseCase(baseHomeRepo).signOut(context).then((value) => {
          signOutModel =value,
          if(signOutModel!.status==true){
            isSignOut=false,
            emit(SignOutSuccessStates(signOutModel!)),
          }
          else{
              isSignOut=false,
              emit(SignOutErrorStates(signOutModel!)),
          }
    });
    emit(SignOutStates());
  }






  //Categories States
  Future appCategoriesErrorStates()async
  {emit(AppCategoriesErrorStates());}

  // //Home States
  Future homeErrorStates(String error)async
  {emit(AppHomeErrorStates(error));}

}