import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/screens/profile/widgets/profile_card_details.dart';

class ProfileCard extends ConsumerWidget {
  final PUser user;
  const ProfileCard({
    Key? key,
    required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 0.1.sw),
                  Expanded(
                    child: ProfileScreenCardDetails(
                      user: user,
                    ),
                  ),
                  SizedBox(width: 0.1.sw),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
