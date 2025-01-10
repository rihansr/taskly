extension DateTimeExtension on DateTime{
  Duration get duration => DateTime.now().difference(this);
}