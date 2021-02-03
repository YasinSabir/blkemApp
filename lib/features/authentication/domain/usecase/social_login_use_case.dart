import 'package:colibri/core/common/failure.dart';
import 'package:colibri/core/common/usecase.dart';
import 'package:colibri/features/authentication/data/models/login_response.dart';
import 'package:colibri/features/authentication/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@injectable
class SocialLoginUseCase extends UseCase<String,SocialLogin>{
  final AuthRepo authRepo;
  SocialLoginUseCase(this.authRepo);
  @override
  Future<Either<Failure, String>> call(SocialLogin params) {
    if(params==SocialLogin.FB)return authRepo.fbLogin();
    else if(params==SocialLogin.TWITTER)return authRepo.twitterLogin();
    else return authRepo.googleLogin();
  }
}
enum SocialLogin{
  TWITTER,
  FB,
  GOOGLE
}