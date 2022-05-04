import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'image_picking_state.freezed.dart';

class ImageWithAttributes {
  final String path;
  final int width;
  final int height;
  final Uint8List byteData;

  ImageWithAttributes({
    required this.path,
    required this.width,
    required this.height,
    required this.byteData,
  });
}

/// Represents the different states of the image picker
@freezed
class ImagePickingState with _$ImagePickingState {
  /// The state when the picker has picked images
  const factory ImagePickingState.picked(
    List<ImageWithAttributes> images,
  ) = _ImagePickingStatePicked;

  /// The state when the picker is empty
  const factory ImagePickingState.notPicked() = _ImagePickingStateNotPicked;

  /// Error state, usually used for validation
  const factory ImagePickingState.error() = _ImagePickingStateError;
}
