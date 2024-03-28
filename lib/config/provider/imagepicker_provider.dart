import 'package:image_picker/image_picker.dart';

class PickerUtils {
  PickerUtils._();

  static Future<XFile?> pickImageFromCemera() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }
}
