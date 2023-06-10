import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/auth/presentation/bloc/cubit.dart';
import 'package:merostore/auth/presentation/bloc/states.dart';
import 'package:merostore/auth/presentation/widgets/widget.dart';
import 'package:merostore/core/image/image.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).primaryColor),
          elevation: 0,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(200),
                        ),
                        color: Theme.of(context).primaryColor),
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
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(120),
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 50, top: 20),
                            height: 190,
                            child: Image.asset(
                              App.logImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 28.0),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: const Text(
                              "Change Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    )),
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
            BlocProvider(create: (context)=>AuthCubit(),
              child: BlocConsumer<AuthCubit, AppAuthStates>(builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: AuthCubit.get(context).changeFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.38,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                            child:
                            customTextField(true, context,  TextInputType.text,
                              TextInputAction.next, (value){
                                if(value!.isEmpty){}return null;},
                              AuthCubit.get(context).password, 'Password',
                              Icons.lock, !AuthCubit.get(context).isEyePassword,
                              IconButton(onPressed: (){AuthCubit.get(context).changeEyePasswordRegister();}, icon:
                              Icon(AuthCubit.get(context).isEyePassword==false ?
                              Icons.visibility_off: Icons.visibility,
                                  color: AuthCubit.get(context).isEyePassword==false ?
                                  Colors.white:Colors.blue.shade300) ,),
                                  (value){},
                            ),),SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                            child:
                            customTextField(true, context, TextInputType.text,
                              TextInputAction.done, (value){
                                if(value!.isEmpty){}
                                return null;},
                              AuthCubit.get(context).confirmPassword, 'New Password',
                              Icons.lock, !AuthCubit.get(context).isEyeConPassword,
                              IconButton(onPressed: (){
                                AuthCubit.get(context).changeEyeConPasswordRegister();}, icon:
                              Icon(AuthCubit.get(context).isEyeConPassword==false ?
                              Icons.visibility_off: Icons.visibility,
                                  color: AuthCubit.get(context).isEyeConPassword==false ?
                                  Colors.white:Colors.blue.shade300) ,),
                                  (value){
                                if(AuthCubit.get(context).changeFormKey.currentState!.validate() ){
                                  AuthCubit.get(context).changePassword(AuthCubit.get(context).password.text,
                                      AuthCubit.get(context).confirmPassword.text, context);
                                }
                              },
                            ),),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          const SizedBox(height: 60,),
                          ConditionalBuilder(
                              condition: AuthCubit.get(context).y ==false,
                              builder: (context)=> customSAuthButton(context, 0.5, 'Save', () {
                                if (AuthCubit.get(context).changeFormKey.currentState!.validate()) {
                                     AuthCubit.get(context).changePassword(AuthCubit.get(context).password.text,
                                         AuthCubit.get(context).confirmPassword.text, context);
                                }
                              }),
                              fallback: (context)=>Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),))
                        ],
                      ),
                    ),
                  ),
                );
              }, listener: (context, state) {
                if (state is ChangePasswordSuccessStates) {
                  if (state.changePasswordModel.status == true) {
                    Navigator.pop(context);
                    showToast(state.changePasswordModel.message, ToastStates.success, context);
                    AuthCubit.get(context).password.text  = '';
                    AuthCubit.get(context).confirmPassword.text = '';
                  } else
                  {
                    showToast(state.changePasswordModel.message , ToastStates.error, context);
                  }
                }
              }),
            )
          ],
        ));
  }
}
