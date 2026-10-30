// "3d 4h", "5h 12m" or "12m" until [until]; "now" once it has passed
String timeLeft(DateTime until, {DateTime? now}) {
  final left = until.difference(now ?? DateTime.now());
  if (left.inMinutes < 1) return 'now';
  if (left.inHours < 1) return '${left.inMinutes}m';
  if (left.inDays < 1) return '${left.inHours}h ${left.inMinutes % 60}m';
  return '${left.inDays}d ${left.inHours % 24}h';
}
