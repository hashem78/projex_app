import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projex_app/enums/picker_user.dart';
import 'package:projex_app/enums/picking_mode.dart';
import 'dart:ui' as ui;

import 'package:projex_app/models/image_picking_state/image_picking_state.dart';

/// Notifier for the image picking provider.
///
/// Handles the complex state requirements for picking single and multiple
/// and cropping them the images are loaded from local storage.
///
class ImagePickingNotifier extends StateNotifier<ImagePickingState> {
  ImagePickingNotifier() : super(const ImagePickingState.notPicked());
  // ImagePicker instance
  static final _picker = ImagePicker();
  // ImageCropper instance
  static final _cropper = ImageCropper();

  /// Crops a single image using package:image_cropper
  /// [path] is he path the the image to be cropped [aspectRation]
  /// The aspectio with which to crop an image
  /// See package:image_cropper for documentation for cropping related fields

  static Future<CroppedFile?> cropImage({
    required String path,
    CropAspectRatio? aspectRatio,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    required CropStyle cropStyle,
  }) async {
    return await _cropper.cropImage(
      sourcePath: path,
      aspectRatioPresets: aspectRatioPresets ??
          const [
            CropAspectRatioPreset.ratio3x2,
          ],
      aspectRatio: aspectRatio,
      cropStyle: cropStyle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: Colors.blue,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
  }

  /// Gets the width and height of an image
  Future<List<int>> getWidthHeight(Uint8List bytes) async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    return [descriptor.width, descriptor.height];
  }

  /// Pick single or multiple image with or without cropping.
  ///
  /// [mode] PickingMode.single for single image picking and PickingMode.multi
  /// for multiple image picking mode
  /// [source] gallery or cammera, [shouldCrop] whether to use cropping or not
  Future<void> pick(
    PickingMode mode, {
    ImageSource source = ImageSource.gallery,
    bool shouldCrop = false,
    CropAspectRatio? aspectRatio,
    CropStyle cropStyle = CropStyle.rectangle,
    List<CropAspectRatioPreset>? aspectRatioPresets,
  }) async {
    if (mode == PickingMode.single) {
      final img = await _picker.pickImage(source: source);
      if (img != null) {
        if (shouldCrop) {
          await _handleCroppingSingleImage(
            img,
            aspectRatio,
            cropStyle,
            aspectRatioPresets,
          );
        } else {
          await _handleSingleImage(img);
        }
      }
    } else {
      final imgs = await _picker.pickMultiImage();
      if (imgs != null) {
        if (shouldCrop) {
          await _handleCroppingMultiImage(
            imgs,
            aspectRatio,
            cropStyle,
            aspectRatioPresets,
          );
        } else {
          await _handleMultiImage(imgs);
        }
      }
    }
  }

  Future<void> _handleMultiImage(List<XFile> imgs) async {
    final images = <ImageWithAttributes>[];
    for (final img in imgs) {
      final bytes = await img.readAsBytes();
      final wh = await getWidthHeight(bytes);
      images.add(
        ImageWithAttributes(
          path: img.path,
          width: wh[0],
          height: wh[1],
          byteData: bytes,
        ),
      );
    }

    state = state.when(picked: (val) {
      return ImagePickingState.picked(
        [...val, ...images],
      );
    }, notPicked: () {
      return ImagePickingState.picked(images);
    }, error: () {
      return ImagePickingState.picked(images);
    });
  }

  Future<void> _handleCroppingMultiImage(
    List<XFile> imgs,
    CropAspectRatio? aspectRatio,
    CropStyle cropStyle,
    List<CropAspectRatioPreset>? aspectRatioPresets,
  ) async {
    final croppedImages = <ImageWithAttributes>[];

    for (final img in imgs) {
      final croppedImg = await cropImage(
        path: img.path,
        aspectRatio: aspectRatio,
        cropStyle: cropStyle,
        aspectRatioPresets: aspectRatioPresets,
      );

      if (croppedImg != null) {
        final bytes = await croppedImg.readAsBytes();
        final wh = await getWidthHeight(bytes);
        croppedImages.add(
          ImageWithAttributes(
              path: img.path, width: wh[0], height: wh[1], byteData: bytes),
        );
      }
    }

    state = state.when(
      picked: (val) {
        return ImagePickingState.picked([...val, ...croppedImages]);
      },
      notPicked: () {
        return ImagePickingState.picked(croppedImages);
      },
      error: () {
        return ImagePickingState.picked(croppedImages);
      },
    );
  }

  Future<void> _handleSingleImage(XFile img) async {
    final bytes = await img.readAsBytes();
    final wh = await getWidthHeight(bytes);
    state = ImagePickingState.picked(
      [
        ImageWithAttributes(
          path: img.path,
          width: wh[0],
          height: wh[1],
          byteData: bytes,
        ),
      ],
    );
  }

  Future<void> _handleCroppingSingleImage(
    XFile img,
    CropAspectRatio? aspectRatio,
    CropStyle cropStyle,
    List<CropAspectRatioPreset>? aspectRatioPresets,
  ) async {
    final croppedImg = await cropImage(
      path: img.path,
      aspectRatio: aspectRatio,
      cropStyle: cropStyle,
      aspectRatioPresets: aspectRatioPresets,
    );
    if (croppedImg != null) {
      final bytes = await croppedImg.readAsBytes();
      final wh = await getWidthHeight(bytes);

      state = ImagePickingState.picked(
        [
          ImageWithAttributes(
            path: croppedImg.path,
            width: wh[0],
            height: wh[1],
            byteData: bytes,
          ),
        ],
      );
    }
  }

  void remove(int index) {
    state = state.whenOrNull(
      picked: (images) {
        if (images.length == 1) {
          return const ImagePickingState.notPicked();
        } else {
          images.removeAt(index);
          return ImagePickingState.picked(images);
        }
      },
      notPicked: () => const ImagePickingState.notPicked(),
    )!;
  }

  /// For validating in forms
  bool validate() {
    return state.when(
      picked: (_) => true,
      notPicked: () {
        state = const ImagePickingState.error();
        return false;
      },
      error: () {
        state = const ImagePickingState.error();
        return false;
      },
    );
  }
}

/// Provides image picking with optional cropping, with multi and single modes
///
/// To use this, simply simply the provider with the appropraite PickerUse
/// and use the pick method.
///
/// Usage example:
///
/// Pick an image for signup
///
/// ``` dart
///   ref.read(imagePickerProvier(PickerUse.signup).notifier).pick(
///   PickingMode.single,
///   shouldCrop: true,
///   cropStyle: CropStyle.circle,
///   aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
///   aspectRatioPresets: [CropAspectRatioPreset.original],
/// );
/// ```
/// Read/watch the state of a picker
/// ``` dart
/// final state = ref.watch(imagePickerProvider(PickerUser.signup));
/// state.when(
///   picked: (imgs) {
///     ...
///   }
///   notPicker: (imgs) {
///     ...
///   }
///   error: () {
///     ...
///   }
/// );
/// ```
final imagePickerProvier = StateNotifierProvider.family<ImagePickingNotifier,
    ImagePickingState, PickerUse>(
  (ref, _) {
    return ImagePickingNotifier();
  },
);
