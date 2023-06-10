import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merostore/mero_store/data/models/home_model.dart';
import 'package:merostore/mero_store/domain/entities/get_categories.dart';
import 'package:merostore/mero_store/domain/entities/home.dart';
import 'package:merostore/mero_store/presentation/bloc/cubit.dart';
import 'package:merostore/mero_store/presentation/screens/categories.dart';
import 'package:merostore/mero_store/presentation/screens/favorite.dart';
import 'package:merostore/mero_store/presentation/screens/products.dart';
import 'package:merostore/mero_store/presentation/screens/settings.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AppHomeWidgets {
  static List<Widget> screens = [
    const Products(),
    const Categories(),
    const Favorite(),
    const Settings(),
  ];

  static List<PersistentBottomNavBarItem> navBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.apps),
        title: ("Categories"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        title: ("Favorite"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}

Widget customProductColum(HomeDataModel homeDataModel,context) =>
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: homeDataModel.homeData.banners.map((e) =>
                    Image(image:NetworkImage(e.image),
                    fit: BoxFit.fill,),).toList(),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height*0.30,
                  // aspectRatio: 16 / 9,
                  viewportFraction: 2,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text("Categories",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 100,
                    child:ListView.separated(
                         physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>listViewCategories(AppCubit.get(context).categoriesModel!.getCategoriesData.categoriesData[index]),
                        separatorBuilder: (context,i)=> const SizedBox(width: 10,),
                        itemCount: AppCubit.get(context).categoriesModel!.getCategoriesData.categoriesData.length)
                  ),
                  const SizedBox(height: 20,),

                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text("New Products ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child:
              GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio:1/1.45,
                  children: List.generate(
                      homeDataModel.homeData.products.length,
                          (index) => buildGridProduct(homeDataModel.homeData.products[index],context)),
              )
              ,)
          ],
        ),
      ),
    );

Widget buildGridProduct(ProductsModel productsModel,context)=>
    Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
      Expanded(
        child: 
       Stack(
         alignment: Alignment.bottomLeft,
         children: [
           Image(image:NetworkImage(productsModel.image),
             height: MediaQuery.of(context).size.height*.25,
             width: double.infinity,
           ),
          productsModel.discount!=0? Container(
             padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 1),
             color: Colors.red,
             child: const Text('Discount',
             style: TextStyle(
               fontSize: 12,
               color: Colors.white
             ),
             ),
           ):const SizedBox()
         ],
       )
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5),
        child: Text(productsModel.description,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
        child: Row(
          children: [
            Text('${(productsModel.price)}',
              style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
             SizedBox(width: MediaQuery.of(context).size.width*0.02,),
            Text(productsModel.discount!=0?'${productsModel.oldPrice}':'',
              style: const TextStyle(fontSize: 12,color: Colors.grey,
              decoration: TextDecoration.lineThrough
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const Spacer(),
            Expanded(
              child: IconButton(onPressed: (){
                AppCubit.get(context).editeFavorites(productsModel.id, context);
                // AppCubit.get(context).favorites[productsModel.id]= !AppCubit.get(context).favorites[productsModel.id]!;
              }, icon:
              AppCubit.get(context).favorites[productsModel.id] ==true ? Icon(Icons.favorite,color: Theme.of(context).primaryColor):
              const Icon(Icons.favorite_border,color: Colors.grey,)),
            )
          ],
        ),
      ),
],);


Widget listViewCategories(CategoriesData categoriesData)=> Stack(
  alignment: Alignment.bottomCenter,
  children: [
      SizedBox(
        width: 130,
        height: 100,
        child:ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Image(image:
          NetworkImage(categoriesData.image,
          ),fit: BoxFit.cover,),
            
        )
    ),
    Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
      ),
      width: 130,
      child:
      Padding(
        padding: const EdgeInsets.all(3.0),
        child:  Text(categoriesData.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    )

  ],
);
