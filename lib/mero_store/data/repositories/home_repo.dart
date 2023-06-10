import 'package:merostore/mero_store/data/data_sources/home_datasource.dart';
import 'package:merostore/mero_store/domain/repositories/base_home_repo.dart';

class HomeRepo extends BaseHomeRepo{
  final BaseHomeDataSource baseHomeDataSource ;
  HomeRepo(this.baseHomeDataSource);

  @override
  Future getHomeDate(context)async {
    return await baseHomeDataSource.getHomeDate(context);
  }

  @override
  Future getCategoriesDate(context)async {
  return await baseHomeDataSource.getCategories(context);
  }

  @override
  Future editFavoritesDate(int id, context) async{
   return await baseHomeDataSource.editFavorites(id, context);
  }

  @override
  Future getFavorites(context) async{
    return await baseHomeDataSource.getFavorites(context);
  }

  @override
  Future getProfile(context) async{
  return await baseHomeDataSource.getProfile(context);
  }
 @override
  Future signOut(context) async{
  return await baseHomeDataSource.signOut(context);
  }

}