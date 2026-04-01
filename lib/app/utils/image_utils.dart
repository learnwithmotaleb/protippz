import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/utils/app_constants.dart';

String resolveImageUrl(String? image) {
  if (image == null || image.isEmpty) {
    return AppConstants.profileImage;
  }

  // Replace backslashes with forward slashes and encode spaces
  String parsedImage = image.replaceAll('\\', '/').replaceAll(' ', '%20');

  if (parsedImage.startsWith('http')) {
    return parsedImage;
  }

  // Prevent double slashes when concatenating
  if (parsedImage.startsWith('/')) {
    parsedImage = parsedImage.substring(1);
  }

  return '${ApiUrl.baseUrl}/$parsedImage';
}