import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_card_details.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_image.dart';
import 'package:projex_app/state/auth.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pfp = ref.watch(authProvider).profilePicture;

    return SliverToBoxAdapter(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showBottomSheet(
                    context: context,
                    builder: (_) => const PickOrViewProfileImageSheet(),
                  );
                },
                child: ProfileImage(
                  profilePicture: pfp,
                  size: 200.r,
                ),
              ),
              0.1.sw.horizontalSpace,
              const Expanded(
                child: ProfileScreenCardDetails(),
              ),
              0.1.sw.horizontalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class PickOrViewProfileImageSheet extends ConsumerWidget {
  const PickOrViewProfileImageSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ListTile(
          leading: Icon(Icons.image),
          title: Text('View Profile Picture'),
        ),
        ListTile(
          leading: const Icon(Icons.browse_gallery),
          title: const Text('Pick Profile Picture'),
          onTap: () async {
            final authedUser = ref.watch(authProvider);
            final result = await FilePicker.platform.pickFiles(withData: true, type: FileType.image);
            if (result == null) return;
            final file = result.files.first;
            final image = await decodeImageFromList(file.bytes!);

            final remoteFile =
                await FirebaseStorage.instance.ref('/users/${authedUser.id}/${file.name}').putData(file.bytes!);
            final fileLink = await remoteFile.ref.getDownloadURL();

            await authedUser.updateProfilePicture(
              PProfilePicture(
                link: fileLink,
                height: image.height,
                width: image.width,
              ),
            );
          },
        ),
      ],
    );
  }
}
