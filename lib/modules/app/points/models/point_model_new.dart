import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class PointsResponse {
  final bool error;
  final int totalPoints;
  final String conversionText;
  final Map<String, List<LoyaltyPointEntry>> history;
  final String message;

  PointsResponse({
    required this.error,
    required this.totalPoints,
    required this.conversionText,
    required this.history,
    required this.message,
  });

  factory PointsResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, List<LoyaltyPointEntry>> historyMap = {};

    // Process history data if available
    final data = json['data'];
    if (data != null && data['history'] is Map<String, dynamic>) {
      final historyData = data['history'] as Map<String, dynamic>;
      historyData.forEach((key, value) {
        if (value is List) {
          historyMap[key] = value
              .map((item) => LoyaltyPointEntry.fromJson(item))
              .toList();
        }
      });
    }

    return PointsResponse(
      error: json['error'] ?? false,
      totalPoints: data != null ? data['total_points'] ?? 0 : 0,
      conversionText: data != null ? data['conversion_text'] ?? '' : '',
      history: historyMap,
      message: json['message'] ?? '',
    );
  }
}
class LoyaltyPointEntry extends Equatable {
  final String action;
  final int points;
  final String? description;
  final String date;
  final String? transfer_customer_name;

  const LoyaltyPointEntry({
    required this.action,
    required this.points,
    this.description,
    this.transfer_customer_name,
    required this.date,
  });

  factory LoyaltyPointEntry.fromJson(Map<String, dynamic> json) => LoyaltyPointEntry(
    action: validateString(json['action']),
    points: validateInt(json['points']),
    description: validateString(json['description']),
    date: validateString(json['date']),
    transfer_customer_name: validateString(json['transfer_customer_name']),
  );

  Map<String, dynamic> toJson() => {
    'action': action,
    'points': points,
    'description': description,
    'date': date,
    'transfer_customer_name': transfer_customer_name,
  };

  @override
  List<Object?> get props => [action, points, description, date, transfer_customer_name];
}
Map<String, List<LoyaltyPointEntry>> demoLoyaltyPointData = {
  "today": [
    LoyaltyPointEntry(
      action: "earn",
      points: 20,
      description: "Purchase at Coffee Shop",
      date: "12 August / 2:42 PM",
    ),
    LoyaltyPointEntry(
      action: "earn",
      points: 10,
      description: "App sign-in bonus",
      date: "12 August / 2:31 PM",
    ),
  ],
  "yesterday": [
    LoyaltyPointEntry(
      action: "redeem",
      points: 50,
      description: "Free coffee redemption",
      date: "11 August / 3:15 PM",
    ),
    LoyaltyPointEntry(
      action: "earn",
      points: 35,
      description: "Order #45678",
      date: "11 August / 10:22 AM",
    ),
  ],
  "this_week": [
    LoyaltyPointEntry(
      action: "earn",
      points: 15,
      description: "Friend referral",
      date: "09 August / 5:30 PM",
    ),
    LoyaltyPointEntry(
      action: "redeem",
      points: 30,
      description: "Discount coupon",
      date: "08 August / 1:45 PM",
    ),
  ],
  "last_month": [
    LoyaltyPointEntry(
      action: "earn",
      points: 100,
      description: "Birthday bonus",
      date: "25 July / 9:10 AM",
    ),
    LoyaltyPointEntry(
      action: "redeem",
      points: 150,
      description: "Premium item redemption",
      date: "15 July / 4:20 PM",
    ),
  ],
};
