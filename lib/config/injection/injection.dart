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
import 'package:taba3ni/features/add_group/domain/usecase/update_group_usecase.dart';
import 'package:taba3ni/features/add_student/data/datasource/add_student_remote_data_source.dart';
import 'package:taba3ni/features/add_student/data/repository/add_student_repository_impl.dart';
import 'package:taba3ni/features/add_student/domain/repository/add_student_repository.dart';
import 'package:taba3ni/features/add_student/domain/usecase/add_student_usecase.dart';
import 'package:taba3ni/features/add_student/presentation/cubit/add_student_cubit.dart';
import 'package:taba3ni/features/attendance_stats/data/datasource/attendance_remote_data_source.dart';
import 'package:taba3ni/features/attendance_stats/data/repository/attendance_repository_impl.dart';
import 'package:taba3ni/features/attendance_stats/domain/repository/attendance_repository.dart';
import 'package:taba3ni/features/attendance_stats/domain/usecase/student_attendance_usecase.dart';
import 'package:taba3ni/features/attendance_stats/presentation/cubit/student_attendance_cubit.dart';
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
import 'package:taba3ni/features/group_lesson/data/datasource/group_lesson_remote_data_source.dart';
import 'package:taba3ni/features/group_lesson/data/repository/group_lesson_repository_impl.dart';
import 'package:taba3ni/features/group_lesson/domain/repository/group_lesson_repository.dart';
import 'package:taba3ni/features/group_lesson/domain/usecase/get_group_lessons_usecase.dart';
import 'package:taba3ni/features/group_lesson/presentation/cubit/group_lessons_cubit.dart';
import 'package:taba3ni/features/group_students/data/datasource/student_remote_data_source.dart';
import 'package:taba3ni/features/group_students/data/repository/student_repository_impl.dart';
import 'package:taba3ni/features/group_students/domain/repository/student_repository.dart';
import 'package:taba3ni/features/group_students/domain/usecase/delete_student_usecase.dart';
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
import 'package:taba3ni/features/lesson_attendance/data/datasource/lesson_attendance_remote_data_source.dart';
import 'package:taba3ni/features/lesson_attendance/data/repository/lesson_attendance_repository_impl.dart';
import 'package:taba3ni/features/lesson_attendance/domain/repository/lesson_attendance_repository.dart';
import 'package:taba3ni/features/lesson_attendance/domain/usecase/get_lesson_attendance_usecase.dart';
import 'package:taba3ni/features/lesson_attendance/presentation/cubit/lessons_attendance_cubit.dart';
import 'package:taba3ni/features/payment/data/datasource/payment_remote_data_source.dart';
import 'package:taba3ni/features/payment/data/repository/payment_repository_impl.dart';
import 'package:taba3ni/features/payment/domain/repository/payment_repository.dart';
import 'package:taba3ni/features/payment/domain/usecase/add_payment_usecase.dart';
import 'package:taba3ni/features/payment/domain/usecase/get_payments_by_group_usecase.dart';
import 'package:taba3ni/features/payment/domain/usecase/get_payments_usecase.dart';
import 'package:taba3ni/features/payment/domain/usecase/update_payment_usecase.dart';
import 'package:taba3ni/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:taba3ni/features/start_lesson/data/datasource/start_lesson_remote_data_source.dart';
import 'package:taba3ni/features/start_lesson/data/repository/start_lesson_repository_impl.dart';
import 'package:taba3ni/features/start_lesson/domain/repository/start_lesson_repository.dart';
import 'package:taba3ni/features/start_lesson/domain/usecase/create_lesson_usecase.dart';
import 'package:taba3ni/features/start_lesson/domain/usecase/record_attendance_usecase.dart';
import 'package:taba3ni/features/start_lesson/presentation/cubit/start_lesson_cubit.dart';

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
  //? Cubit
  sl.registerFactory(
    () => GroupCubit(getGroupsUseCase: sl(), deleteGroupUseCase: sl()),
  );

  //* Features - Add Groups

  //? Remote Data Source
  sl.registerLazySingleton<AddGroupRemoteDataSource>(
    () => AddGroupRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<AddUpdateGroupRepository>(
    () => AddUpdateGroupRepositoryImpl(sl()),
  );
  //? Use Cases
  sl.registerFactory(() => AddGroupUseCase(sl()));
  sl.registerFactory(() => UpdateGroupUseCase(sl()));
  //? Cubit
  sl.registerFactory(() => AddGroupCubit(addGroupUseCase: sl(),updateGroupUseCase: sl()));

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
  //?  Cubit
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
  sl.registerFactory(() => DeleteStudentUsecase(sl()));
  //?  Cubit
  sl.registerFactory(
    () => GroupStudentsCubit(getStudentsByGroupUseCase: sl(),deleteStudentUsecase: sl()),
  );

      //* Features - Groups Lessons
//? Remote Data Source
  sl.registerLazySingleton<GroupLessonsRemoteDataSource>(
    () => GroupLessonsRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<GroupLessonsRepository>(
    () => GroupLessonsRepositoryImpl(sl()),
  );
  //? Use Cases
  sl.registerFactory(() => GetGroupLessonsUsecase(sl()));
   //?  Cubit
  sl.registerFactory(
    () => GroupLessonsCubit(groupLessonsUsecase: sl()),
  );

      //* Features - Atttendance State
//? Remote Data Source
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<StudentAttendanceStatsRepository>(
    () => StudentAttendanceStatsRepositoryImpl(sl()),
  );
  //? Use Cases
  sl.registerFactory(() => GetStudentAttendanceStatsUseCase(sl()));
   //?  Cubit
  sl.registerFactory(
    () => StudentAttendanceCubit(getStudentAttendanceStatsUseCase: sl()),
  );

        //* Features - Lesson Atttendance 
//? Remote Data Source
  sl.registerLazySingleton<LessonAttendanceRemoteDataSource>(
    () => LessonAttendanceRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<LessonAttendanceRepository>(
    () => LessonAttendanceRepositoryImpl(sl()),
  );
  //? Use Cases
  sl.registerFactory(() => GetLessonsAttendanceUseCase(sl()));
   //?  Cubit
  sl.registerFactory(
    () => LessonsAttendanceCubit(getLessonsAttendanceUseCase: sl()),
  );

   //* Features - Add Student 

   //? Remote Data Source
  sl.registerLazySingleton<AddStudentRemoteDataSource>(
    () => AddStudentRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<AddStudentRepository>(
    () => AddStudentRepositoryImpl(sl()),
  );
  //? Use Cases
  sl.registerFactory(() => AddStudentUseCase(sl()));
   //?  Cubit
  sl.registerFactory(
    () => AddStudentCubit(usecase: sl(),addPaymentUseCase: sl()),
  );

  
   //* Features - Start Lesson 

   //? Remote Data Source
  sl.registerLazySingleton<StartLessonRemoteDataSource>(
    () => StartLessonRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<StartLessonRepository>(
    () => StartLessonRepositoryImpl(sl()),
  );
  //? Use Cases
  sl.registerFactory(() => CreateLessonUseCase(sl()));
  sl.registerFactory(() => RecordAttendanceUseCase(sl()));
   //?  Cubit
  sl.registerFactory(
    () => StartLessonCubit(createLesson: sl(),recordAttendance: sl()),
  );

   //* Features - Payment 

   //? Remote Data Source
  sl.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(sl()),
  );
  //? Repository
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(sl()),
  );
  //? Use Cases
  sl.registerFactory(() => GetPaymentsByGroupUseCase(sl()));
  sl.registerFactory(() => GetPaymentsUseCase(sl()));
  sl.registerFactory(() => UpdatePaymentUsecase(sl()));
  sl.registerFactory(() => AddPaymentUseCase(sl()));
   //?  Cubit
  sl.registerFactory(
    () => PaymentCubit( getPaymentsByGroupUseCase: sl(),getPaymentsByStudentUseCase: sl(),updatePaymentUsecase: sl(),studentRepo : sl()),
  );

}
