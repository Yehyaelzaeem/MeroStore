import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/auth/presentation/bloc/cubit.dart';
import 'package:merostore/auth/presentation/bloc/states.dart';
import 'package:merostore/auth/presentation/widgets/widget.dart';
import 'package:merostore/core/image/image.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:Theme.of(context).primaryColor
        ),
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
        BlocConsumer<AuthCubit,AppAuthStates>
          (builder: (context,state){
          return  SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: AuthCubit.get(context).registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.38,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.89,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: customTextField(false, context, TextInputType.text,
                          TextInputAction.next,
                              (value) {if (value!.isEmpty) {}
                            return null;
                          }, AuthCubit.get(context).name, 'Name', Icons.person, false,
                          null, (b) {}),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.89,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: customTextField(false, context, TextInputType.number,
                          TextInputAction.next, (value) {
                            if (value!.isEmpty) {}
                            return null;
                          }, AuthCubit.get(context).phone, 'Phone', Icons.phone, false,
                          null, (b) {}),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.89,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: customTextField(false, context,TextInputType.text,
                          TextInputAction.next,
                              (value) {
                            if (value!.isEmpty) {}
                            return null;
                          }, AuthCubit.get(context).email, 'User name/Email ',
                          Icons.email_outlined, false, null, (b) {}),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.89,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: customTextField(true, context,                 TextInputType.text,
                        TextInputAction.next, (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                        AuthCubit.get(context).password,
                        'Password',
                        Icons.lock_open,
                        !AuthCubit.get(context).isEyePassword,
                        IconButton(
                          onPressed: () {
                            AuthCubit.get(context).changeEyePasswordRegister();
                          },
                          icon: Icon(
                              AuthCubit.get(context).isEyePassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AuthCubit.get(context).isEyePassword == false
                                  ? Colors.white
                                  : Colors.blue.shade300),
                        ),
                            (b) {},
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.89,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child:
                      customTextField(
                        true, context, TextInputType.text,
                        TextInputAction.done, (value) {
                          if (value!.isEmpty) {}
                          if(value != AuthCubit.get(context).password.text){
                            showToast('The Confirm Password Not Like Password', ToastStates.warning, context);
                          }
                          return null;
                        },
                        AuthCubit.get(context).confirmPassword,
                        'Confirm Password',
                        Icons.lock_open,
                        !AuthCubit.get(context).isEyeConPassword,
                        IconButton(
                          onPressed: () {
                            AuthCubit.get(context).changeEyeConPasswordRegister();
                          },
                          icon: Icon(
                              AuthCubit.get(context).isEyeConPassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AuthCubit.get(context).isEyeConPassword == false
                                  ? Colors.white
                                  : Colors.blue.shade300),
                        ),
                            (value) {
                          if (AuthCubit.get(context).registerFormKey.currentState!.validate()) {
                            AuthCubit.get(context).register(
                                AuthCubit.get(context).name.text,
                                AuthCubit.get(context).phone.text,
                                AuthCubit.get(context).email.text,
                                AuthCubit.get(context).confirmPassword.text,
                                '',context);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.07,
                    ),
                    customSAuthButton(context, 0.5, 'Sign In', () {
                      if (AuthCubit.get(context).registerFormKey.currentState!.validate()) {
                          AuthCubit.get(context).register(
                              AuthCubit.get(context).name.text,
                              AuthCubit.get(context).phone.text,
                              AuthCubit.get(context).email.text,
                              AuthCubit.get(context).confirmPassword.text,
                              '',context);
                      }

                    })
                  ],
                ),
              ),
            ),
          );

        }, listener: (context,state){
            if(state is RegisterSuccessStates){
              if(state.registerModel.status==true){
                Navigator.pop(context);
                showToast(state.registerModel.message, ToastStates.success, context);
                AuthCubit.get(context).name.text='';
                AuthCubit.get(context).phone.text='';
                AuthCubit.get(context).email.text='';
                AuthCubit.get(context).password.text='';
                AuthCubit.get(context).confirmPassword.text='';
                AuthCubit.get(context).isEyePassword=false;
                AuthCubit.get(context).isEyeConPassword=false;
              }
              else{
                showToast(state.registerModel.message, ToastStates.error, context);
              }
            }
        })
      ],
    ));
  }
}
