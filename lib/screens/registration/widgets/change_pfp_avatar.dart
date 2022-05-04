import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:projex_app/enums/picker_user.dart';
import 'package:projex_app/enums/picking_mode.dart';
import 'package:projex_app/state/image_picking.dart';

class ChangePfpAvatar extends ConsumerWidget {
  const ChangePfpAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePicker = ref.watch(imagePickerProvier(PickerUse.signup));
    return GestureDetector(
      onTap: () {
        ref.read(imagePickerProvier(PickerUse.signup).notifier).pick(
          PickingMode.single,
          shouldCrop: true,
          cropStyle: CropStyle.circle,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [CropAspectRatioPreset.original],
        );
      },
      child: CircleAvatar(
        radius: 250.r,
        child: imagePicker.when(
          picked: (imgs) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    color: Colors.red,
                    splashColor: Colors.red,
                    onPressed: () {
                      ref
                          .read(imagePickerProvier(PickerUse.signup).notifier)
                          .remove(0);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Image.memory(imgs.first.byteData),
                  ),
                ),
              ],
            );
          },
          notPicked: () {
            return Icon(
              Icons.person,
              size: 250.r,
            );
          },
          error: () {
            return Icon(
              Icons.person,
              size: 250.r,
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
