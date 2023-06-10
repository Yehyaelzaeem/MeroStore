import 'package:merostore/onBoarding/data/models/model.dart';
import '../../../core/image/image.dart';

abstract class BaseLocalDataBase {
   getData();
}
class LocalDataBase implements BaseLocalDataBase{
  @override
  getData() {
    List<OnBoardingModel> list =[
      OnBoardingModel(
          title: 'Shopping Online',
          image: App.onBoarding1,
          description: 'You can shopping anytime,anywhere\nthat you want',
      ),
      OnBoardingModel(
        title: 'Easy Payment',
        image: App.onBoarding2,
        description: 'Payment can be made in easy, Fast and Safe ways',
      ),
      OnBoardingModel(
        title: 'Fast Delivery',
        image: App.onBoarding3,
        description: 'Delivery of food orders from the \n restaurant to your home',
      ),
    ];
    return list;
  }
}