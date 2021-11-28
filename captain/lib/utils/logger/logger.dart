import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class Logger {
  void info(String tag, String msg) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');
  }

  void warn(String tag, String msg) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');
  }

  void error(String tag, String msg, StackTrace? trace) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');
   FirebaseCrashlytics.instance
       .recordError('$time: \t $tag \t $msg', trace);
   FirebaseCrashlytics.instance.log('$time: \t $tag \t $msg');
   FirebaseCrashlytics.instance.sendUnsentReports();
  }
}
