import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/auth_firebase_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/change_password.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';
import '../../domain/entities/user_entity.dart';

final authDataSourceProvider = Provider<AuthFirebaseDataSource>(
      (ref) => AuthFirebaseDataSource(),
);

final authRepositoryProvider = Provider<AuthRepositoryImpl>(
      (ref) => AuthRepositoryImpl(ref.read(authDataSourceProvider)),
);

final signInProvider = Provider<SignIn>(
      (ref) => SignIn(ref.read(authRepositoryProvider)),
);

final signUpProvider = Provider<SignUp>(
      (ref) => SignUp(ref.read(authRepositoryProvider)),
);

final signOutProvider = Provider<SignOut>(
      (ref) => SignOut(ref.read(authRepositoryProvider)),
);

final forgotPasswordProvider = Provider<ForgotPassword>(
      (ref) => ForgotPassword(ref.read(authRepositoryProvider)),
);

final changePasswordProvider = Provider<ChangePassword>(
      (ref) => ChangePassword(ref.read(authRepositoryProvider)),
);

final authStateProvider = StreamProvider<UserEntity?>(
      (ref) => ref.read(authRepositoryProvider).authStateChanges(),
);

final loadingProvider = StateProvider<bool>((ref) => false);