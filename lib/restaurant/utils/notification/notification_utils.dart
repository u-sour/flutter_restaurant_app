enum NotificationType { invoice, chefMonitor, stockAlert }

extension NotificationTypeExtension on NotificationType {
  String get toValue {
    switch (this) {
      case NotificationType.invoice:
        return 'Invoice';
      case NotificationType.chefMonitor:
        return 'CM';
      default:
        return 'SA';
    }
  }

  String get toTitle {
    switch (this) {
      case NotificationType.invoice:
        return 'Invoice';
      case NotificationType.chefMonitor:
        return 'Chef Monitor';
      default:
        return 'Stock Alert';
    }
  }
}
