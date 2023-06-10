import 'package:merostore/mero_store/domain/repositories/base_home_repo.dart';

class HomeUseCase {
  final BaseHomeRepo baseHomeRepo;
  HomeUseCase(this.baseHomeRepo);

  Future getHomeData(context)async{
    return await baseHomeRepo.getHomeDate(context);
  }
  Future getCategoriesDate(context)async{
    return await baseHomeRepo.getCategoriesDate(context);
  }

  Future editFavoritesDate(int id,context)async{
    return await baseHomeRepo.editFavoritesDate(id,context);
  }
  Future getFavorites(context)async{
    return await baseHomeRepo.getFavorites(context);
  }
  Future getProfile(context)async{
    return await baseHomeRepo.getProfile(context);
  }
  Future signOut(context)async{
    return await baseHomeRepo.signOut(context);
  }
}