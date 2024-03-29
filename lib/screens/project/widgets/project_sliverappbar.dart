import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/popup_menu_selection/popup_menu_selection_model.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSliverAppbar extends SliverOverlapAbsorber {
  ProjectSliverAppbar({
    Key? key,
    required BuildContext context,
    required TabController tabController,
  }) : super(
          key: key,
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
            context,
          ),
          sliver: Consumer(
            builder: (context, ref, child) {
              final translations = ref.watch(translationProvider).translations;

              return SliverAppBar(
                floating: true,
                snap: true,
                actions: [
                  PopupMenuButton<PopupMenuSelection>(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context) {
                      return PopupMenuSelection.values.map(
                        (e) {
                          return e.when(
                            settings: (name) {
                              return PopupMenuItem<PopupMenuSelection>(
                                onTap: () {
                                  final projectId = ref.read(selectedProjectProvider);
                                  context.push('/project/$projectId/settings');
                                },
                                value: e,
                                child: Text(translations[name]),
                              );
                            },
                          );
                        },
                      ).toList();
                    },
                  ),
                ],
                title: const ProjectAppBarTitile(),
                bottom: TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(
                      text: translations.projectPage.projectTabBarTasksTitle,
                      icon: const Icon(Icons.task),
                    ),
                    Tab(
                      text: translations.projectPage.projectTabBarMembersTitle,
                      icon: const Icon(Icons.person),
                    ),
                    Tab(
                      text: translations.projectPage.projectTabBarGroupsTitle,
                      icon: const Icon(Icons.group),
                    ),
                  ],
                ),
              );
            },
          ),
        );
}

class ProjectAppBarTitile extends ConsumerStatefulWidget {
  const ProjectAppBarTitile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ProjectAppBarTitile> createState() => _ProjectAppBarTitileState();
}

class _ProjectAppBarTitileState extends ConsumerState<ProjectAppBarTitile> {
  @override
  Widget build(BuildContext context) {
    final project = ref.watch(projectProvider);

    return InkWell(
      onTap: () async {
        final project = ref.read(projectProvider);
        await Clipboard.setData(ClipboardData(text: project.id));
        if (!mounted) return;
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          const SnackBar(content: Text('Invite Code copied to clipboard')),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(project.name),
          Text(
            '#${project.id}',
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
