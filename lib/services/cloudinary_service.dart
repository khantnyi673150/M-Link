import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class CloudinaryUploadException implements Exception {
  final String message;

  const CloudinaryUploadException(this.message);

  @override
  String toString() => message;
}

/// Upload helper for unsigned Cloudinary image uploads.
class CloudinaryService {
  CloudinaryService._();

  // Values can be overridden with --dart-define in any environment.
  static const String _cloudName = String.fromEnvironment(
    'CLOUDINARY_CLOUD_NAME',
    defaultValue: 'dcckywnkm',
  );
  static const String _uploadPreset = String.fromEnvironment(
    'CLOUDINARY_UPLOAD_PRESET',
    defaultValue: 'mlink_image',
  );

  static Future<String> uploadShopImage({
    required Uint8List imageBytes,
    required String merchantId,
  }) async {
    if (_cloudName.isEmpty || _uploadPreset.isEmpty) {
      throw const CloudinaryUploadException(
        'Cloudinary is not configured. Set CLOUDINARY_CLOUD_NAME and CLOUDINARY_UPLOAD_PRESET.',
      );
    }

    final uri = Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/upload');
    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = _uploadPreset
      ..fields['folder'] = 'm_link/shops/$merchantId'
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          imageBytes,
          filename: 'shop_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      );

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode < 200 || response.statusCode >= 300) {
      var details = '';
      try {
        final decoded = jsonDecode(body) as Map<String, dynamic>;
        final errorObj = decoded['error'];
        if (errorObj is Map<String, dynamic>) {
          details = (errorObj['message']?.toString() ?? '').trim();
        }
      } catch (_) {
        details = '';
      }

      final suffix = details.isEmpty ? '' : ' $details';
      throw CloudinaryUploadException(
        'Image upload failed (${response.statusCode}).$suffix',
      );
    }

    final decoded = jsonDecode(body) as Map<String, dynamic>;
    final url = decoded['secure_url']?.toString() ?? '';
    if (url.isEmpty) {
      throw const CloudinaryUploadException('Image upload completed but no URL was returned.');
    }

    return url;
  }
}
