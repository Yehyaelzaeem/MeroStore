import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merostore/auth/presentation/bloc/cubit.dart';
import 'package:merostore/auth/presentation/bloc/states.dart';
import 'package:merostore/auth/presentation/screens/register.dart';
import 'package:merostore/core/services/routeing_page/reoute.dart';
Widget customLoginDesign(context)=>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
     SizedBox(height: MediaQuery.of(context).size.height*.2,),
      customWidgetsLogin(context),
    SizedBox(height: MediaQuery.of(context).size.height*.04,),
       Padding(
        padding: const EdgeInsets.only(left: 28.0,right: 28),
        child: Row(
          children: [
            const Expanded(child: Divider(thickness: 2,)),
            SizedBox(width: MediaQuery.of(context).size.width*.02,),
            const Text('Sign In With',
              style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(width: MediaQuery.of(context).size.width*.02,),
            const Expanded(child: Divider(thickness: 2,)),
          ],
        ),
      ),
       SizedBox(height: MediaQuery.of(context).size.height*.01,),
      customAccountsIcons(context),
  ],
),
    );

Widget customWidgetsLogin(context)=> Container(
  decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 20)]
  ),
  alignment: Alignment.center,
  height: 465,
  width: MediaQuery.of(context).size.width*0.89,
  child:  Padding(
    padding: const EdgeInsets.only(left: 22.0,right: 22),
    child:
    Form(
      key: AuthCubit.get(context).formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.04,),
          const Text('SIGN IN',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.06,),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
            child:
             customTextField(
                 false, context,
                 TextInputType.text,
                 TextInputAction.next, (value) {
                       if(value!.isEmpty){
                       }
                       return null;
                     },
                 AuthCubit.get(context).emailLog, 'User name/Email ', Icons.person,false,null,(b){})) ,
          SizedBox(height: MediaQuery.of(context).size.height*.03,),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
            child:
            customTextField(true, context,                 TextInputType.text,
              TextInputAction.done, (value){
              if(value!.isEmpty){}return null;},
                AuthCubit.get(context).passwordLog, 'Password',
                Icons.lock, !AuthCubit.get(context).isEye,
                IconButton(onPressed: (){AuthCubit.get(context).changeEyePassword();}, icon:
                             Icon(AuthCubit.get(context).isEye==false ?
                             Icons.visibility_off: Icons.visibility,
                               color: AuthCubit.get(context).isEye==false ?
                               Colors.white:Colors.blue.shade300) ,),
                  (value){
                        if(AuthCubit.get(context).formKey.currentState!.validate() ){
                          AuthCubit.get(context).login(AuthCubit.get(context).emailLog.text, AuthCubit.get(context).passwordLog.text,context);
                        }
                      },
              ),),
          Container(
              alignment: Alignment.topRight,
              child: TextButton(onPressed: (){}, child:  Text("Forget Password?",
                style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w800),
              ))),
          SizedBox(height: MediaQuery.of(context).size.height*.04,),
          BlocConsumer<AuthCubit,AppAuthStates>(
              builder: (context,state)=>
                  ConditionalBuilder(
            condition: AuthCubit.get(context).isNotLoading,
            builder: (context)=>

          customSAuthButton(context, 0.38, 'LOGIN', () {
              if(AuthCubit.get(context).formKey.currentState!.validate() ){
                 AuthCubit.get(context).login(AuthCubit.get(context).emailLog.text, AuthCubit.get(context).passwordLog.text,context);}}),
            fallback: (context)=> Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),),
          ), listener: (context,state){}),
          const Spacer(),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade600),
                ),
                TextButton(onPressed: (){
                  NavigetPages.pushToPage(const Register(), context);
                }, child:  Text("Sign Up",
                  style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w800,fontSize: 16),
                ))
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.01,),

        ],
      ),
    ),
  ),
);

Widget customSAuthButton(context,double x,String text, void Function()? onPressed)=>    SizedBox(
  width: MediaQuery.of(context).size.width*x,
  child: ElevatedButton(
    onPressed:onPressed,
    style: ElevatedButton.styleFrom(
      shadowColor: Colors.black,
      elevation: 15,
      backgroundColor:Theme.of(context).primaryColor,
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
    ),
    child:  Text(text,style:
    const TextStyle(fontSize: 17)
      ,),
  ),
);

  Widget customTextField(
    bool isPassword,
    context,
    TextInputType? keyboardType,
    TextInputAction textInputAction,
    String? Function(String?)? validator,
    TextEditingController? controller,
    String hintText,
    IconData iconData,
     bool? obscureText ,
Widget? suffixIcon,
    void Function(String)? onFieldSubmitted
    )=>  TextFormField(
  textInputAction:textInputAction,
  validator:validator,
  keyboardType: keyboardType,
  controller:controller,
  style: const TextStyle(color: Colors.white,fontSize: 16),
  decoration:  InputDecoration(
      hintText:hintText,
      hintStyle: const TextStyle(fontSize: 15,color: Colors.white),
      prefixIcon:Icon(iconData,color: Colors.white,),
      errorBorder: InputBorder.none,
       border: InputBorder.none,
    suffixIcon:  isPassword ==true?suffixIcon:null,
  ),
    onFieldSubmitted:  onFieldSubmitted,
    obscureText :obscureText!,
);

Widget customAccountsIcons(context)=>Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    IconButton(onPressed: (){
    },
      icon:  Icon(FontAwesomeIcons.facebook, size: 30,color: Theme.of(context).primaryColor,),),
    IconButton(onPressed: (){
    },
      icon:  const Icon(FontAwesomeIcons.instagram, size: 30,color: Color(0xffF500A2),),),
    IconButton(onPressed: (){
    },
      icon:  Icon(FontAwesomeIcons.twitter, size: 30,color: Colors.blue.shade400,),),
    InkWell(
      onTap: (){
      },
      child: SizedBox(
        height: 37,
        width:37,
        child:Image.asset('assets/image/auth/google.png',fit: BoxFit.cover,),
      ),
    ),


  ],);


void showToast(
    String text,
    ToastStates state,
    context
    )=>
    Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseColor(state,context),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates{success ,error,warning}

Color chooseColor(ToastStates state,context){
  Color color;
  switch(state){
    case ToastStates.success:
      color =Theme.of(context).primaryColor;
      break;
    case ToastStates.error:
      color=Colors.red;
      break;
    case ToastStates.warning:
      color=Colors.amber;
      break;
  }
  return color;
}
