import 'package:timeago/timeago.dart' as TimeAgo;

class TimeUtils {
  static String getTimeFromMilisecond(int milisecond) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(milisecond);
    return TimeAgo.format(time);
  }
}
