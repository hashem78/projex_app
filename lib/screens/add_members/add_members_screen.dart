import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:projex_app/screens/add_members/widgets/add_member_text_field.dart';
import 'package:projex_app/screens/add_members/widgets/add_members_button.dart';
import 'package:projex_app/screens/add_members/widgets/add_members_title.dart';
import 'package:projex_app/screens/add_members/widgets/members_to_be_added_list.dart';

final addMemberKey = GlobalKey<FormBuilderState>();

class AddMembersScreen extends StatelessWidget {
  const AddMembersScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FormBuilder(
            key: addMemberKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                AddMemberScreenTitle(),
                AddMemberEmailField(),
                MembersToBeAddedList(),
                AddMembersButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
