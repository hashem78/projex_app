import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/editing.dart';

class ProjectSliverAppbar extends SliverOverlapAbsorber {
  ProjectSliverAppbar({
    Key? key,
    required BuildContext context,
    required String projectName,
  }) : super(
          key: key,
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
            context,
          ),
          sliver: SliverAppBar(
            floating: true,
            snap: true,
            actions: [
              Consumer(
                builder: (context, ref, child) {
                  final isEditing = ref.watch(allowEditingProjectProvider);
                  return IconButton(
                    icon: !isEditing
                        ? const Icon(Icons.edit)
                        : const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                    onPressed: () {
                      ref.read(allowEditingProjectProvider.notifier).toggle();
                    },
                  );
                },
              )
            ],
            title: Text(projectName),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.people)),
              ],
            ),
          ),
        );
}
