import 'package:flutter/material.dart';
import 'package:merostore/mero_store/domain/entities/get_categories.dart';

Widget rowCategories(context,CategoriesData categoriesData)=> Container(
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
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image(image:
              NetworkImage(categoriesData.image,
              ),fit: BoxFit.cover,),
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: Text(categoriesData.name,
            style:  const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        Center(child: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios))),
      ],),
  ),
);