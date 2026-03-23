class AuthInitResponse {
  final String journeyId;
  final String tokenType;
  final int expiresIn;

  AuthInitResponse({
    required this.journeyId,
    required this.tokenType,
    required this.expiresIn,
  });

  factory AuthInitResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return AuthInitResponse(
      journeyId: data['journeyId'],
      tokenType: data['tokenType'],
      expiresIn: data['expiresIn'],
    );
  }
}























// class QrResponse {
//   final String qrId;
//   final String qrImage;

//   QrResponse({required this.qrId, required this.qrImage});

//   factory QrResponse.fromJson(Map<String, dynamic> json) {
//     final data = json['data'] ?? json;

//     return QrResponse(
//       qrId: data['qrId'] ?? "",
//       qrImage: data['deeplink'] ?? "",
//     );
//   }
// }

// class SessionResponse {
//   final String status;

//   SessionResponse({required this.status});

//   factory SessionResponse.fromJson(Map<String, dynamic> json) {
//   final data = json['data'] ?? json;

//   return SessionResponse(
//     status: data['sessionStatus'] ?? "",
//   );
// }
// }