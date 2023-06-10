import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/auth/presentation/widgets/widget.dart';
import 'package:merostore/mero_store/presentation/bloc/cubit.dart';
import 'package:merostore/mero_store/presentation/bloc/states.dart';
import 'package:merostore/mero_store/presentation/widgets/products_home_widgets.dart';

class Products extends StatelessWidget {
  const Products({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {
            return ConditionalBuilder(
                condition: AppCubit.get(context).homeDataModel != null,
                builder: (context) => customProductColum(AppCubit.get(context).homeDataModel!,context),
                fallback: (context) =>
                     Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),));
          },
          listener: (context, state) {
            if(state is FavoritesErrorStates){
                if(state.favoritesEditingModel.status==false){
                  showToast(state.favoritesEditingModel.message, ToastStates.error,context);
                }
            }
            else if( state is FavoritesSuccessStates){
              if(state.favoritesEditingModel.status==true){
                showToast(state.favoritesEditingModel.message, ToastStates.success,context);
              }
            }
          });
  }

}