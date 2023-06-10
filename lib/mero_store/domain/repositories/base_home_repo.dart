abstract class BaseHomeRepo {
  Future getHomeDate(context);
  Future getCategoriesDate(context);
  Future editFavoritesDate(int id,context);
  Future getFavorites(context);
  Future getProfile(context);
  Future signOut(context);

}