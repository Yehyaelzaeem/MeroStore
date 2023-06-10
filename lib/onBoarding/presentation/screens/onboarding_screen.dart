import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/onBoarding/presentation/bloc/states.dart';
import 'package:merostore/onBoarding/presentation/widgets/widges.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc/cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AppOnBoardingCubit, AppOnBoardingStates>(
        builder: (context, state) {
          return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                            controller: AppOnBoardingCubit.get(context).pageController,
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (int index){
                               AppOnBoardingCubit.get(context).page=index;
                            },
                            itemCount: 3,
                            itemBuilder: (context, i) {
                              return customPageViewColum(AppOnBoardingCubit.get(context).list[i]);
                            }),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          SmoothPageIndicator(
                              controller: AppOnBoardingCubit.get(context).pageController,
                              count: 3,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Theme.of(context).primaryColor,
                              dotColor: const Color(0xffe4e9ff),
                              expansionFactor: 2.5,
                              dotHeight: 10,
                            ),
                          ),
                          const Spacer(),
                          FloatingActionButton(
                            onPressed: () {
                              AppOnBoardingCubit.get(context).changingPageView(context);
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Icon(Icons.arrow_forward_ios),
                          )
                        ],
                      )
                    ],
                  )));
        },
        listener: (context, state) {},
      );
  }
}
