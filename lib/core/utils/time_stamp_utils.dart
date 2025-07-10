import 'package:intl/intl.dart';

class TimestampUtils {
  static String formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return 'Unknown';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
    final difference = today.difference(messageDate).inDays;

    // Today: show time in 12-hour AM/PM format (e.g., "2:30 PM")
    if (difference == 0) {
      return DateFormat('h:mm a').format(timestamp);
    }
    // Yesterday: show "yesterday"
    else if (difference == 1) {
      return 'yesterday';
    }
    // Within last week (2-7 days): show day name (e.g., "Monday")
    else if (difference <= 7) {
      return DateFormat('EEEE').format(timestamp);
    }
    // Within 1-4 weeks: show "X weeks ago"
    else if (difference <= 28) {
      final weeks = (difference / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    }
    // Older than a month: show month and year (e.g., "June 2025")
    else {
      return DateFormat('MMMM yyyy').format(timestamp);
    }
  }
}