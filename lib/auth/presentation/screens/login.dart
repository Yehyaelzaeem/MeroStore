import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/auth/presentation/bloc/cubit.dart';
import 'package:merostore/auth/presentation/bloc/states.dart';
import 'package:merostore/auth/presentation/widgets/widget.dart';
import 'package:merostore/core/image/image.dart';
import 'package:merostore/core/services/routeing_page/reoute.dart';
import 'package:merostore/core/shared_preference/shared_preference.dart';
import 'package:merostore/mero_store/presentation/screens/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AuthCubit,AppAuthStates>(
                listener: (context,state){
                  if(state is LoginSuccessStates){
                    if(state.loginModel.status==true){
                      CacheHelper.saveDate(key: 'token', value: state.loginModel.userData!.token).then((value) =>
                      {
                          showToast(state.loginModel.message, ToastStates.success,context),
                           NavigetPages.pushReplacePage(const Home(), context),
                           AuthCubit.get(context).email.text='',
                           AuthCubit.get(context).password.text='',
                      });

                    }else{
                      showToast(state.loginModel.message, ToastStates.error,context);
                    }
                  }
                },
                builder: (context,state){
                  return WillPopScope(
                       onWillPop: ()
                       {
                         showDialog<String>(
                             context: context,
                             builder: (BuildContext context) =>  AlertDialog(
                           title: const Text("Are You Sure ?"),
                           titleTextStyle:
                           const TextStyle(
                               fontWeight: FontWeight.bold,
                               color: Colors.black,fontSize: 20),
                           actionsOverflowButtonSpacing: 20,
                           actions: [
                             MaterialButton(onPressed: (){
                               Navigator.pop(context);
                             },
                                 color: Theme.of(context).primaryColor,
                                 child: const Text("Back")),
                             MaterialButton(onPressed: (){
                               exit(0);
                             },
                                 color: Theme.of(context).primaryColor,
                                 child: const Text("Yes")),
                           ],
                           content: const Text("Want to close the app"),
                         ));
                         return Future.value(false);
                       },
                      child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor),
                      elevation: 0,
                      toolbarHeight: 0,
                    ),
                    body:
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                width: 200,
                                decoration:  BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(200),
                                    ),
                                    color: Theme.of(context).primaryColor
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                width: 200,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(205),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Expanded(
                                child:Stack(
                                  children: [
                                    Container(
                                      decoration:  BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(120),
                                        ),
                                        color:Theme.of(context).primaryColor,
                                      ),

                                    ),
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 50,top: 20),
                                        height: 190,
                                        child: Image.asset(App.logImage,fit: BoxFit.cover,),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        customLoginDesign(context),
                      ],
                    ),
                  ),
                     );
                },
            );
  }
}
