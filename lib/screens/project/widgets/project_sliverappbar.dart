import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/editing.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSliverAppbar extends SliverOverlapAbsorber {
  ProjectSliverAppbar({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
            context,
          ),
          sliver: Consumer(
            builder: (context, ref, child) {
              final isEditing = ref.watch(editingProvider(EditReason.project));
              final project = ref.watch(projectProvider);
              return SliverAppBar(
                floating: true,
                snap: true,
                actions: [
                  IconButton(
                    icon: !isEditing
                        ? const Icon(Icons.edit)
                        : const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                    onPressed: () {
                      ref
                          .read(
                            editingProvider(EditReason.project).notifier,
                          )
                          .toggle();
                    },
                  )
                ],
                title: Text(project.name),
                bottom: child as PreferredSizeWidget,
              );
            },
            child: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.people)),
              ],
            ),
          ),
        );
}