import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/core/service/app_service.dart';
import 'package:taba3ni/core/service/local_storage_service.dart';
import 'package:taba3ni/core/service/network_service.dart';
import 'package:get_it/get_it.dart';
import 'package:taba3ni/features/add_group/data/datasource/add_group_remote_data_source.dart';
import 'package:taba3ni/features/add_group/data/repository/add_group_repository_impl.dart';
import 'package:taba3ni/features/add_group/domain/repository/add_group_repository.dart';
import 'package:taba3ni/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:taba3ni/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taba3ni/features/auth/domain/repositories/auth_repository.dart';
import 'package:taba3ni/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:taba3ni/features/auth/domain/usecases/login_parent_usecase.dart';
import 'package:taba3ni/features/auth/domain/usecases/login_teacher_usecase.dart';
import 'package:taba3ni/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:taba3ni/features/group_details/data/datasource/group_details_remote_data_source.dart';
import 'package:taba3ni/features/group_details/data/repository/group_details_repository_impl.dart';
import 'package:taba3ni/features/group_details/domain/repository/group_details_repository.dart';
import 'package:taba3ni/features/group_details/domain/usecase/group_details_usecase.dart';
import 'package:taba3ni/features/group_details/presentation/cubit/cubit/group_details_cubit.dart';
import 'package:taba3ni/features/group_students/data/datasource/student_remote_data_source.dart';
import 'package:taba3ni/features/group_students/data/repository/student_repository_impl.dart';
import 'package:taba3ni/features/group_students/domain/repository/student_repository.dart';
import 'package:taba3ni/features/group_students/domain/usecase/get_student_usecase.dart';
import 'package:taba3ni/features/group_students/presentation/cubit/group_student_cubit.dart';
import 'package:taba3ni/features/groups/data/datasource/group_remote_data_source.dart';
import 'package:taba3ni/features/groups/data/repository/group_repository_impl.dart';
import 'package:taba3ni/features/groups/domain/repository/group_repository.dart';
import 'package:taba3ni/features/add_group/domain/usecase/add_group_usecase.dart';
import 'package:taba3ni/features/groups/domain/usecase/delete_group_usecase.dart';
import 'package:taba3ni/features/groups/domain/usecase/get_groups_usecase.dart';
import 'package:taba3ni/features/add_group/presentation/cubit/add_group_cubit.dart';
import 'package:taba3ni/features/groups/presentation/cubit/group_cubit.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //* External
  sl.registerLazySingleton(() => Connectivity());

  //* SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  //* Supabase
  sl.registerLazySingleton(() => Supabase.instance.client);
  //* Services
  sl.registerLazySingleton(() => NetworkService());
  sl.registerLazySingleton(() => LocalStorageService(sl()));

  //* App
  sl.registerLazySingleton(
    () => AppService(localStorage: sl(), networkService: sl()),
  );

  //* Features - Auth
  //? Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  //? Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  //? Use Cases
  sl.registerFactory(() => LoginTeacherUseCase(sl()));
  sl.registerFactory(() => LoginParentUseCase(sl()));
  sl.registerFactory(() => LogoutUseCase(sl()));
  //? Cubit
  sl.registerFactory(
    () => AuthCubit(
      loginTeacher: sl(),
      loginParent: sl(),
      logout: sl(),
      localStorage: sl(),
    ),
  );

  //* Features - Groups

  //? Remote Data Source
  sl.registerLazySingleton<GroupRemoteDataSource>(
    () => GroupRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<GroupRepository>(() => GroupRepositoryImpl(sl()));
  //? Use Cases
  sl.registerFactory(() => GetGroupsUseCase(sl()));
  sl.registerFactory(() => DeleteGroupUseCase(sl()));
  //? GroupCubit
  sl.registerFactory(
    () => GroupCubit(getGroupsUseCase: sl(), deleteGroupUseCase: sl()),
  );

  //* Features - Add Groups

  //? Remote Data Source
  sl.registerLazySingleton<AddGroupRemoteDataSource>(
    () => AddGroupRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<AddGroupRepository>(
    () => AddGroupRepositoryImpl(sl()),
  );
  //? Use Cases
  sl.registerFactory(() => AddGroupUseCase(sl()));
  //? AddGroupCubit
  sl.registerFactory(() => AddGroupCubit(addGroupUseCase: sl()));

    //* Features - Groups Details
  //? Remote Data Source
  sl.registerLazySingleton<GroupDetailsRemoteDataSource>(
    () => GroupDetailsRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<GroupDetailsRepository>(
    () => GroupDetailsRepositoryImpl(sl()),
  );
  //? Use Cases
  sl.registerFactory(() => GetGroupDetailsUseCase(sl()));
  //? GroupDetailsCubit
  sl.registerFactory(
    () => GroupDetailsCubit(getGroupDetails: sl()),
  );

      //* Features - Groups Students
  //? Remote Data Source
  sl.registerLazySingleton<StudentsRemoteDataSource>(
    () => StudentsRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<StudentsRepository>(
    () => StudentsRepositoryImpl(sl()),
  );
  //? Use Cases
  sl.registerFactory(() => GetStudentsByGroupUseCase(sl()));
  //? StudentsCubit
  sl.registerFactory(
    () => GroupStudentsCubit(getStudentsByGroupUseCase: sl()),
  );

}
