import 'dart:convert';
import 'dart:typed_data';

class JwtDecoder {
  static Map<String, dynamic> getPayload(String jwt) {
    final parts = jwt.split('.');
    if (parts.length != 3) {
      throw new Exception('Invalid token');
    }

    String payload = parts[1];
    Uint8List payloadBytes = base64.decode(base64.normalize(payload));
    String payloadJson = utf8.decode(payloadBytes);
    Map payloadMap = jsonDecode(payloadJson);
    if (payloadMap is! Map<String, dynamic>) {
      throw new Exception('Invalid payload');
    }

    return payloadMap;
  }
}
