import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projex_app/state/locale.dart';

class ChangePfpAvatar extends ConsumerWidget {
  const ChangePfpAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations =
        ref.watch(translationProvider).translations.registration;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.3.sw),
      child: FormBuilderImagePicker(
        preferredCameraDevice: CameraDevice.front,
        name: 'photo',
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        maxImages: 1,
        validator: FormBuilderValidators.required(
          errorText: translations.errorRequiredTextInputField,
        ),
      ),
    );
  }
}
