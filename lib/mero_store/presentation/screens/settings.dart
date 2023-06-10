import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/auth/presentation/screens/change_password.dart';
import 'package:merostore/auth/presentation/screens/login.dart';
import 'package:merostore/auth/presentation/screens/update_profile.dart';
import 'package:merostore/auth/presentation/widgets/widget.dart';
import 'package:merostore/core/services/routeing_page/reoute.dart';
import 'package:merostore/core/shared_preference/shared_preference.dart';
import 'package:merostore/mero_store/domain/entities/get_profile.dart';
import 'package:merostore/mero_store/presentation/bloc/cubit.dart';
import 'package:merostore/mero_store/presentation/bloc/states.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>
      (builder: (context,state){
      return ConditionalBuilder(
          condition: AppCubit.get(context).profileModel !=null,
          builder: (context)=>settingPage(AppCubit.get(context).profileModel!.profileData, context),
          fallback:  (context)=>Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),));
    }, listener: (context,state){
        if(state is SignOutSuccessStates){
          if(state.signOutModel.status ==true){
            CacheHelper.removeData(key: 'token').then((value) => {
              NavigetPages.persistentNavBarNavigator(const LoginScreen(), context),
            showToast(state.signOutModel.message, ToastStates.success, context),
            });
          }else{
            showToast(state.signOutModel.message, ToastStates.error, context);
          }
        }
    });
  }
}
Widget settingPage(ProfileData profileData,context)=>   Container(
  height: double.infinity,
  width: double.infinity,
  color: Colors.white,
  child: SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 190,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(0))
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: SizedBox(
                width: double.infinity,
                child:
                Row(children: [
                  const SizedBox(width: 10,),
                  Container(
                    height: 120,
                    width: 120,
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(170)),
                      border:Border.all(color: Theme.of(context).primaryColor,width: 2),
                      boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 7)]
                    ),
                    child:  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(170)),
                      child:  Image(image:
                      NetworkImage(profileData.image),fit: BoxFit.cover,),
                    ),
                  ),
                  const SizedBox(width: 20,),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profileData.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [BoxShadow(color: Colors.black54,blurRadius: 5)],
                          color: Colors.white
                        ),),
                        const SizedBox(height: 10,),
                        Text(profileData.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white70
                          ),),
                        const SizedBox(height: 5,),
                        Text(profileData.phone,  maxLines: 1,
                          overflow: TextOverflow.ellipsis, style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white70
                        ),),
                      ],
                  ),
                   ),
                  const SizedBox(width: 10,),


                ],),
              ),
            )
          ],
        ),
         const Padding(
          padding: EdgeInsets.only(top: 20.0,bottom: 10,left: 15),
          child: Text('Settings',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              color: Color(0xff7487d5),
            ),
          ),
        ),
        InkWell(
            onTap: (){
              bool x = !AppCubit.get(context).isDarkMode;
              AppCubit.get(context).darkMode(x);
            },
            child: rowSetting(Icons.dark_mode,'Dark Mode',context,true,(){})),
        divider(),
        InkWell(
            onTap: (){
              NavigetPages.pushToPage(const UpDateProfile(), context);
            },
            child: rowSetting(Icons.person_outlined,'Manage Account',context,false,(){},)),
        divider(),
        InkWell(
            onTap: (){
              NavigetPages.pushToPage(const ChangePassword(), context);
            },
            child: rowSetting(Icons.lock_open,'Change Password',context,false,(){},)),
        divider(),
        InkWell(
            onTap: (){
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>  AlertDialog(
                      title: const Text("Change Language !!"),
                      titleTextStyle:
                      const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,fontSize: 20),
                      actionsOverflowButtonSpacing: 20,
                      actions: [
                        MaterialButton(onPressed: (){
                          // AppCubit.get(context).saveLanguage('en',context).then((value) =>
                          // {
                          //   AppCubit.get(context).getHomeData(context),
                          //   Navigator.pop(context),
                          // });
                          Navigator.pop(context);
                        },
                            color: Theme.of(context).primaryColor,
                            child: const Text("English")),
                        MaterialButton(onPressed: (){
                          // AppCubit.get(context).saveLanguage('ar',context).then((value) =>
                          // { AppCubit.get(context).getHomeData(context),
                          // Navigator.pop(context),});
                          Navigator.pop(context);
                        },
                            color: Theme.of(context).primaryColor,
                            child: const Text("Arabic")),
                      ],
                      content: const Text("Depending on the language you choose, the details will be in it !!"),
                    ));
            },
            child: rowSetting(Icons.language_outlined,'Language',context,false,(){},)),
        divider(),
        InkWell(
            onTap: (){
            },
            child: rowSetting(Icons.info_outline,'About',context,false,(){},)),
        const SizedBox(height: 40,),
        BlocConsumer<AppCubit,AppStates>
          (builder: (context,state) {
          return ConditionalBuilder(
              condition: AppCubit.get(context).isSignOut ==false,
              builder: (context)=> Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      AppCubit.get(context).signOut(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: 15,
                      backgroundColor:Theme.of(context).primaryColor,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                    child: const Text('Sign Out',style:
                    TextStyle(fontSize: 17)
                      ,),
                  ),
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),),

          );
          },
            listener: (context,state){})




      ],
    ),
  ),
);


Widget divider ()=> const Padding(
  padding: EdgeInsets.only(left: 20.0,right: 13,top: 10,bottom: 10),
  child: Divider(
    thickness: 2,
  ),
);

Widget rowSetting(IconData iconData,String text,context,bool x,void Function()? onPressed)=> Row(
  children: [
    const SizedBox(width: 20,),
    Icon(iconData,size: 30,
        color: const Color(0xff7487d5),
    ),
    const SizedBox(width: 20,),
     Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(text,
        style: const TextStyle(
            fontSize: 20,
          color: Color(0xff7487d5),

        ),
      ),
    ),
    const Spacer(),
   x==false?
   Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor):
   BlocConsumer<AppCubit,AppStates>
     (
       builder: (context,state){
     return Switch(
         activeColor: const Color(0xff7487d5),
         value:  AppCubit.get(context).isDarkMode,
         onChanged: (bool y){
           AppCubit.get(context).darkMode(y);
         });
   }, listener: (context,state){}),
    const SizedBox(width: 15,),


  ],
);