import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merostore/onBoarding/data/models/model.dart';

Widget customPageViewColum(OnBoardingModel onBoardingModel)=> Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image.asset(onBoardingModel.image)),
      const SizedBox(height: 10,),
       Text(onBoardingModel.title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold
          )),
      const SizedBox(height: 15,),
       Text(onBoardingModel.description,
          style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold
          )),
    ]
);