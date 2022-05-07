import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/state/project_provider.dart';

class PProjectBuilder extends ConsumerWidget {
  final String pid;
  final Widget Function(BuildContext context, PProject prject) builder;

  final Widget Function(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  )? errorBuilder;

  final Widget Function(BuildContext context)? loadingBuilder;
  const PProjectBuilder({
    Key? key,
    required this.pid,
    required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider(pid));
    return project.when(
      data: (project) {
        return builder.call(context, project);
      },
      error: (_, __) => errorBuilder?.call(context, _, __) ?? const SizedBox(),
      loading: () => loadingBuilder?.call(context) ?? const SizedBox(),
    );
  }
}
