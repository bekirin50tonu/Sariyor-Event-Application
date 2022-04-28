import 'dart:developer';

extension DateTimeExtension on DateTime {
  String getTimeDifferenceFromNow() {
    Duration difference = this.difference(DateTime.now());
    if (difference.inSeconds < 5) {
      return "Başlıyor..";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds} Saniye Kaldı.";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes} Ay Kaldı.";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} Saat Kaldı.";
    } else if (difference.isNegative) {
      return "Etkinlik Bitti";
    } else {
      return "${difference.inDays} Gün Kaldı.";
    }
  }

  String getTimePastFromNow() {
    Duration difference = DateTime.now().difference(this);
    log(difference.inMinutes.toString());
    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} Saniye Önce.";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} Dakika Önce.";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} Saat Önce.";
    } else {
      return "${difference.inDays} Gün Önce.";
    }
  }
}
