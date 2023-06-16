export 'package:exif/image_picker_service/image_picker_service.dart'
    if (dart.library.html) 'package:exif/image_picker_service/image_picker_service_for_web.dart'
    if (dart.library.io) 'package:exif/image_picker_service/image_picker_service_for_mobile.dart';
