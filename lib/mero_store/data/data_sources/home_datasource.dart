import 'package:merostore/core/network/apis.dart';
import 'package:merostore/core/network/dio.dart';
import 'package:merostore/mero_store/data/models/categories_model.dart';
import 'package:merostore/mero_store/data/models/favorit_editing_model.dart';
import 'package:merostore/mero_store/data/models/get_favorites_model.dart';
import 'package:merostore/mero_store/data/models/home_model.dart';
import 'package:merostore/mero_store/data/models/profile_model.dart';
import 'package:merostore/mero_store/presentation/bloc/cubit.dart';

abstract class BaseHomeDataSource {
  Future getHomeDate(context);
  Future getCategories(context);
  Future editFavorites(int id,context);
  Future getFavorites(context);
  Future getProfile(context);
  Future signOut(context);
}
class HomeDataSource implements BaseHomeDataSource{

  @override
  Future<HomeDataModel> getHomeDate (context) async {
  var res= await DioHelper.getData(url: AppApis.home,);
  if(res.statusCode==200){
    return HomeDataModel.fromJson(res.data);
  }
  else {
    AppCubit.get(context).homeErrorStates('Error');
     throw 'Error';
  }
  }


  @override
  Future<CategoriesModel> getCategories(context)async {
    var res=await DioHelper.getData(url: AppApis.categories,);
    if(res.statusCode==200){
      return CategoriesModel.fromJson(res.data);
    }
    else{
      AppCubit.get(context).appCategoriesErrorStates();
      throw 'Error';
    }
  }


  @override
  Future<FavoritesEditingModel> editFavorites(int id,context)async {
    var res=await DioHelper.postData(url: AppApis.favorites, data: {"product_id": id},);
    if(res.statusCode==200){
      return FavoritesEditingModel.fromJson(res.data);
    }
    else{
      AppCubit.get(context).favorites[id] = !AppCubit.get(context).favorites[id]!;
      return throw 'Error';
    }
  }

  @override
  Future<FavoritesModel> getFavorites(context) async{
     var res =await DioHelper.getData(url: AppApis.favorites);
     if(res.statusCode==200){
       return FavoritesModel.fromJson(res.data);
     }
     else{
       throw 'Error';
     }
  }
  @override
  Future<ProfileModel> getProfile(context) async{
     var res =await DioHelper.getData(url: AppApis.profile);
     if(res.statusCode==200){
       return ProfileModel.fromJson(res.data);
     }
     else{
       throw 'Error';
     }
  }

  @override
  Future<FavoritesEditingModel> signOut(context) async{
    var res=await DioHelper.postData(url: AppApis.signOut, data: {},);
    if(res.statusCode==200){
      return FavoritesEditingModel.fromJson(res.data);
    }
    else{
      return throw 'Error';
    }
  }
}
