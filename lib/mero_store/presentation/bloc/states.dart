import 'package:merostore/mero_store/data/models/categories_model.dart';
import 'package:merostore/mero_store/data/models/favorit_editing_model.dart';
import 'package:merostore/mero_store/data/models/get_favorites_model.dart';
import 'package:merostore/mero_store/data/models/home_model.dart';
import 'package:merostore/mero_store/data/models/profile_model.dart';

abstract class AppStates {}

class AppInitialStates extends AppStates{}

class AppChangeCurrentIndexStates extends AppStates{}
//Home States
class AppGetHomeDataStates extends AppStates{}
class AppHomeSuccessStates extends AppStates{
  final HomeDataModel homeDataModel;
  AppHomeSuccessStates(this.homeDataModel);
}
class AppHomeErrorStates extends AppStates{
  final String error;
  AppHomeErrorStates(this.error);
}
class AppHomeLoadingStates extends AppStates{}


//Categories States
class AppCategoriesSuccessStates extends AppStates{
  final CategoriesModel categoriesModel;
  AppCategoriesSuccessStates(this.categoriesModel);
}
class AppCategoriesErrorStates extends AppStates{}
class AppGetCategoriesDataStates extends AppStates{}

//Token States
class AppGetTokenStates extends AppStates{}

//Favorites Editing States
class FavoritesSuccessStates extends AppStates{
  final FavoritesEditingModel favoritesEditingModel;
  FavoritesSuccessStates(this.favoritesEditingModel);
}
class FavoritesErrorStates extends AppStates{
  final FavoritesEditingModel favoritesEditingModel;
  FavoritesErrorStates(this.favoritesEditingModel);
}
class FavoritesEditingStates extends AppStates{}

//Favorites Getting States
class GetFavoritesSuccessStates extends AppStates{
  final FavoritesModel favoritesModel;
  GetFavoritesSuccessStates(this.favoritesModel);
}
class GetFavoritesErrorStates extends AppStates{
  final FavoritesModel favoritesModel;
  GetFavoritesErrorStates(this.favoritesModel);
}
class GetFavoritesStates extends AppStates{}


//Profile States
class ProfileSuccessStates extends AppStates{
  final ProfileModel profileModel;
  ProfileSuccessStates(this.profileModel);
}
class ProfileErrorStates extends AppStates{
  final ProfileModel profileModel;
  ProfileErrorStates(this.profileModel);
}
class ProfileStates extends AppStates{}

class LanguageStates extends AppStates{}


//DarkMode
class DarkModeStates extends AppStates{}

//Sign Out
class SignOutSuccessStates extends AppStates{
  final FavoritesEditingModel signOutModel;
  SignOutSuccessStates(this.signOutModel);
}
class SignOutErrorStates extends AppStates{
  final FavoritesEditingModel signOutModel;
  SignOutErrorStates(this.signOutModel);
}
class SignOutStates extends AppStates{}

