import 'package:flutter/material.dart';
import 'package:merostore/mero_store/domain/entities/favorites.dart';
import 'package:merostore/mero_store/presentation/bloc/cubit.dart';

Widget rowFavorites(FavoritesDataProduct favoritesDataProduct,context)=> Container(
  decoration:  BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
      boxShadow: [BoxShadow(color: Theme.of(context).primaryColor,blurRadius: 2)]

  ),
  height: 120,
  child:
  Center(
    child: Row(
      children: [
        Expanded(child: buildStackImageFavorites(favoritesDataProduct.image,context)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5,),
                Text(favoritesDataProduct.name,
                  style:  const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(favoritesDataProduct.description,
                  style: const TextStyle(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(favoritesDataProduct.price.toString(),
                        style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      Text(favoritesDataProduct.oldPrice.toString(),
                        style: const TextStyle(fontSize: 12,color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const Spacer(),
                      Expanded(
                        child: IconButton(onPressed: (){
                          AppCubit.get(context).editeFavorites(favoritesDataProduct.productId, context);
                          // AppCubit.get(context).favorites[productsModel.id]= !AppCubit.get(context).favorites[productsModel.id]!;
                        }, icon:
                        AppCubit.get(context).favorites[favoritesDataProduct.productId] ==true ? Icon(Icons.favorite,color: Theme.of(context).primaryColor):
                        const Icon(Icons.favorite_border,color: Colors.grey,)),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20,),

              ],
            ),
          ),
        )
      ],),
  ),
);

Widget buildStackImageFavorites(String image,context)=>
    SizedBox(
      height: 130,
      width: 150,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image:
            NetworkImage(image),
              height: MediaQuery.of(context).size.height*.2,
              width: double.infinity,
            ),
          ),
          Positioned(
              bottom: 8,
              left: 12,
              top: 90,
              child:
              1!=0? Container(
                alignment: Alignment.center,
                color: Colors.red.withOpacity(0.8),
                child: const FittedBox(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('Discount',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ):const SizedBox()
          )
        ],
      ),
    );