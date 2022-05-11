import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
part 'image_picker_model.freezed.dart';

@freezed
class ImagePickerState with _$ImagePickerState {
  const factory ImagePickerState() = _ImagePickerState;
  const factory ImagePickerState.success() = _ImagePickerStateSucess;
  const factory ImagePickerState.error() = _ImagePickerStateError;
}
