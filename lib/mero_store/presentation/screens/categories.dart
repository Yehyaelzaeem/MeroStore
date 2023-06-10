import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/mero_store/presentation/bloc/cubit.dart';
import 'package:merostore/mero_store/presentation/bloc/states.dart';
import 'package:merostore/mero_store/presentation/widgets/categories_widgets.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          return ConditionalBuilder(
              condition: AppCubit.get(context).categoriesModel !=null,
              builder: (context)=> SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0,left: 5,right: 5),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>rowCategories(context,AppCubit.get(context).categoriesModel!.getCategoriesData.categoriesData[index]),
                        separatorBuilder: (context,i)=>const SizedBox(height: 10,),
                        itemCount: AppCubit.get(context).categoriesModel!.getCategoriesData.categoriesData.length),
                  )
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),));

        },
        listener: (context,state){});
  }
}
