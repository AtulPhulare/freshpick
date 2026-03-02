// final getIt = GetIt.instance;

// void setupLocator() {
//   // Dio Client
//   getIt.registerSingleton<Dio>(Dio());

//   // API Service
//   getIt.registerSingleton<UserRemoteDataSource>(UserRemoteDataSource(getIt()));

//   // Repository
//   getIt.registerSingleton<UserRepository>(UserRepositoryImpl(getIt()));

//   //user
//   getIt.registerSingleton<LoginWithOtpUsecase>(LoginWithOtpUsecase(getIt()));

//   // Bloc
//   getIt.registerFactory<UserBloc>(
//     () => UserBloc(getIt(), getIt(), getIt(), getIt()),
//   );
// }
