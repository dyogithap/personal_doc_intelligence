class UserDocument {
  final String id;
  final String name;
  final DateTime expiryDate;
  final String docType; // e.g., "Passport", "Driver's License"

  UserDocument({
    required this.id,
    required this.name,
    required this.expiryDate,
    required this.docType,
  });

  // This helper tells the UI if the document is expired
  bool get isExpired => DateTime.now().isAfter(expiryDate);

  // This calculates how many days are left (useful for alerts!)
  int get daysUntilExpiry => expiryDate.difference(DateTime.now()).inDays;
}