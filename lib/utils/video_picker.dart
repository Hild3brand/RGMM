import 'package:image_picker/image_picker.dart';

pickVideo() async {
  final picker = await ImagePicker();
  XFile? videoFile;
  try {
    videoFile = await picker.pickVideo(source: ImageSource.gallery);
    return videoFile!.path;
  } catch (e) {
    print('Error: $e');
  }
  return picker;
}
