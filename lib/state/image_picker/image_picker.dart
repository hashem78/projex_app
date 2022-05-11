import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projex_app/state/image_picker/image_picker_model.dart';

class ImagePickerNotifier extends StateNotifier<ImagePickerState> {
  ImagePickerNotifier() : super(const ImagePickerState());
  final picker = ImagePicker();
  Future<void> getLostData() async {
    if (Platform.isAndroid) {
      final response = await picker.retrieveLostData();
      if (response.isEmpty) {
        return;
      }

      if (response.files != null) {
        state = const ImagePickerState.success();
      } else if (response.file != null) {
        state = const ImagePickerState.success();
      } else {
        state = const ImagePickerState.error();
      }
    }
  }

  Future<List<XFile>> pick(
    ImageSource source, {
    CameraDevice cameraDevice = CameraDevice.front,
    double width = 120,
    double height = 120,
    bool multiple = false,
  }) async {
    final val = <XFile>[];
    try {
      if (!multiple) {
        final pickedFile = await picker.pickImage(
          source: source,
          maxWidth: width,
          maxHeight: height,
          imageQuality: 80,
          preferredCameraDevice: cameraDevice,
        );

        if (pickedFile != null) {
          val.add(pickedFile);
          state = const ImagePickerState.success();
        }
      } else {
        final pickedFiles = await picker.pickMultiImage(
          maxWidth: width,
          maxHeight: height,
          imageQuality: 80,
        );
        if (pickedFiles != null) {
          val.addAll(pickedFiles);
          state = const ImagePickerState.success();
        }
      }
    } catch (e) {
      await getLostData();
    }
    return val;
  }
}

final imagePickerProvider = StateNotifierProvider.autoDispose<ImagePickerNotifier, ImagePickerState>(
  (ref) {
    return ImagePickerNotifier();
  },
);
