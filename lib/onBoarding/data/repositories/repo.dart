import 'package:merostore/onBoarding/data/data_sources/local_database.dart';
import 'package:merostore/onBoarding/domain/repositories/base_repo.dart';

class OnBoardingRepo extends BaseOnBoardingRepo{
  final BaseLocalDataBase baseLocalDataBase;

  OnBoardingRepo(this.baseLocalDataBase);

  @override
   getOnBoarding() {
   return baseLocalDataBase.getData();
  }

}