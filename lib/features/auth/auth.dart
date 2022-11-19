import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/firestore/app_user_repository.dart';
import '../../utils/exceptions/base.dart';
import '../../utils/firebase_messaging.dart';
import '../../utils/loading.dart';
import '../../utils/logger.dart';

final _authProvider = Provider<FirebaseAuth>((_) => FirebaseAuth.instance);

final authUserProvider = StreamProvider<User?>(
  (ref) => ref.watch(_authProvider).userChanges(),
);

final userIdProvider = Provider<AsyncValue<String?>>(
  (ref) => ref.watch(authUserProvider).whenData((user) => user?.uid),
);

final isSignedInProvider = Provider(
  (ref) => ref.watch(userIdProvider).whenData((userId) => userId != null),
);

/// test1@example.com 〜 test5@example.com
final signInAsTestUserProvider = Provider.autoDispose.family<Future<void> Function(), int>(
  (ref, userNumber) => () async {
    try {
      final userCredential = await ref
          .watch(_authProvider)
          .signInWithEmailAndPassword(email: 'test$userNumber@example.com', password: '12345678');
      final user = userCredential.user;
      if (user == null) {
        throw const AppException(message: 'Email とパスワードによるサインインに失敗しました。');
      }
      final fcmToken = await ref.read(getFcmTokenProvider)();
      await ref
          .read(appUserRepositoryProvider)
          .updateUserFcmToken(appUserId: user.uid, fcmToken: fcmToken);
    } on FirebaseException catch (e) {
      logger.warning(e.toString());
    } on AppException catch (e) {
      logger.warning(e.toString());
    }
  },
);

/// FirebaseAuth の匿名ログインを行って、そのユーザー ID でユーザードキュメントを作成する。
final signInAnonymouslyProvider = Provider.autoDispose<Future<void> Function()>(
  (ref) => () async {
    try {
      final userCredential = await ref.watch(_authProvider).signInAnonymously();
      final user = userCredential.user;
      if (user == null) {
        throw const AppException(message: '匿名サインインに失敗しました。');
      }
      final fcmToken = await ref.read(getFcmTokenProvider)();
      // await ref.read(appUserRepositoryProvider).setUser(appUserId: user.uid, fcmToken: fcmToken);
    } on FirebaseException catch (e) {
      logger.warning(e.toString());
    } on AppException catch (e) {
      logger.warning(e.toString());
    }
  },
);

/// FirebaseAuth からログアウトする。
final signOutProvider = Provider.autoDispose<Future<void> Function()>(
  (ref) => () async {
    try {
      ref.read(overlayLoadingProvider.notifier).update((state) => true);
      await ref.watch(_authProvider).signOut();
    } finally {
      ref.read(overlayLoadingProvider.notifier).update((state) => false);
    }
  },
);
