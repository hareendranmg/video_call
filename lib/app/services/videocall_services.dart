import 'package:get/get.dart';

class VideocallServices extends GetConnect {
  static final VideocallServices _VideocallServices =
      VideocallServices._internal();
  factory VideocallServices() => _VideocallServices;
  VideocallServices._internal();

  Future<String?> getToken({
    required String channelName,
    required int uid,
  }) async {
    try {
      final apiRes = await get(
          'https://ahims.kerala.gov.in/ahims/webservices/office/generate_token.php',
          query: {
            'channel': channelName,
            'uid': '$uid',
          });

      if (!apiRes.isOk) {
        return null;
      }

      if (!(apiRes.body['success'] as bool)) {
        return null;
      }

      return apiRes.body['tokenWithUid'] as String;
    } catch (e) {
      return null;
    }
  }
}
