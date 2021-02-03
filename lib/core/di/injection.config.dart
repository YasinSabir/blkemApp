// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import '../common/api/api_helper.dart';
import '../../features/authentication/domain/repo/auth_repo.dart';
import '../../features/authentication/data/datasource/auth_repo_impl.dart';
import '../../features/feed/presentation/bloc/bookmark_cubit.dart';
import '../../features/messages/presentation/bloc/chat_cubit.dart';
import '../../features/feed/presentation/bloc/feed_cubit.dart';
import '../../features/feed/domain/repo/feed_repo.dart';
import '../../features/feed/data/repo_impl/feed_repo_impl.dart';
import '../datasource/local_data_source.dart';
import '../../features/authentication/presentation/bloc/login_cubit.dart';
import '../../features/authentication/domain/usecase/login_use_case.dart';
import '../../features/messages/presentation/bloc/message_cubit.dart';
import '../../features/notifications/presentation/bloc/notification_cubit.dart';
import 'register_module.dart';
import '../../features/authentication/presentation/bloc/reset_password_cubit.dart';
import '../../features/authentication/domain/usecase/reset_password_use_case.dart';
import '../../features/search/presentation/bloc/search_cubit.dart';
import '../../features/authentication/presentation/bloc/signup_cubit.dart';
import '../../features/authentication/domain/usecase/sign_up_case.dart';
import '../../features/authentication/domain/usecase/social_login_use_case.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<BookmarkCubit>(() => BookmarkCubit());
  gh.factory<ChatCubit>(() => ChatCubit());
  gh.lazySingleton<Dio>(() => registerModule.dio);
  gh.factory<FeedCubit>(() => FeedCubit());
  gh.lazySingleton<FlutterSecureStorage>(() => registerModule.storage);
  gh.lazySingleton<GoogleSignIn>(() => registerModule.googleLogin);
  gh.factory<LocalDataSource>(
      () => LocalDataSourceImpl(get<Dio>(), get<FlutterSecureStorage>()));
  gh.factory<MessageCubit>(() => MessageCubit());
  gh.factory<NotificationCubit>(() => NotificationCubit());
  gh.factory<SearchCubit>(() => SearchCubit());
  gh.lazySingleton<TwitterLogin>(() => registerModule.twitterLogin);
  gh.factory<ApiHelper>(() => ApiHelper(get<LocalDataSource>()));
  gh.factory<FeedRepo>(() => FeedRepoImpl(get<ApiHelper>()));
  gh.factory<LoginUseCase>(() => LoginUseCase(get<AuthRepo>()));
  gh.factory<ResetPasswordUseCase>(() => ResetPasswordUseCase(get<AuthRepo>()));
  gh.factory<SignUpUseCase>(() => SignUpUseCase(get<AuthRepo>()));
  gh.factory<SocialLoginUseCase>(() => SocialLoginUseCase(get<AuthRepo>()));
  gh.factory<LoginCubit>(() => LoginCubit(
        get<LocalDataSource>(),
        get<LoginUseCase>(),
        get<SocialLoginUseCase>(),
      ));
  gh.factory<ResetPasswordCubit>(
      () => ResetPasswordCubit(get<ResetPasswordUseCase>()));
  gh.factory<SignUpCubit>(
      () => SignUpCubit(get<SignUpUseCase>(), get<SocialLoginUseCase>()));

  // Eager singletons must be registered in the right order
  gh.singleton<AuthRepo>(AuthRepoImpl(
    get<ApiHelper>(),
    get<GoogleSignIn>(),
    get<TwitterLogin>(),
    get<LocalDataSource>(),
  ));
  return get;
}

class _$RegisterModule extends RegisterModule {}
