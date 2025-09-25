import '../../core/constants/app_string.dart';
import '../utils/utils.dart';

extension DateExtension on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  String timeAgo() {
    final Duration difference = DateTime.now().toLocal().difference(toLocal());

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return readableDate(this, pattern: AppString.readableDateFormat);
    }
  }
}

extension NullableDateExtension on DateTime? {
  bool isToday() {
    if (this == null) return false;

    final now = DateTime.now();
    return this!.year == now.year && this!.month == now.month && this!.day == now.day;
  }

  String timeAgo() {
    if (this == null) return 'N/A';

    final Duration difference = DateTime.now().toLocal().difference(this!.toLocal());

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return readableDate(this!, pattern: AppString.readableDateFormat);
    }
  }
}
