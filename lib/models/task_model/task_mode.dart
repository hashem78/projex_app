import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/enums/status.dart';
import 'package:projex_app/models/feedback_model/feedback_model.dart';
part 'task_mode.freezed.dart';
part 'task_mode.g.dart';

@freezed
class PTask with _$PTask {
  const PTask._();

  Future<void> addFeedBack({
    required Feedback feedback,
  }) async {
    // TODO: task.addFeedBack()
  }

  Future<double> calculateProgressEstimation() async {
    // TODO: task.calculateProgressEstimation()
    return 0;
  }

  Future<void> addAssignees({
    required List<String> assigneeIds,
  }) async {
    // TODO: task.addAssignees()
  }
  const factory PTask({
    required String taskId,
    required String subTasksCollectionId,
    required String projectId,
    required String creatorId,
    @Default([]) List<String> assignedToIds,
    required String title,
    required String description,
    @Default([]) List<PFeedBack>? feedback,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime dueDate,
    required PStatus status,
    required int rating,
  }) = _PTask;
  factory PTask.fromJson(Map<String, dynamic> json) => _$PTaskFromJson(json);
}
