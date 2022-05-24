import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:projex_app/models/feedback_model/feedback_model.dart';
import 'package:projex_app/models/task_status/task_status.dart';
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
    @Default('') String id,
    @Default('') String creatorId,
    @Default([]) List<String> assignedToIds,
    @Default('') String title,
    @Default('') String description,
    @Default([]) List<PFeedBack> feedback,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dueDate,
    @Default(PTaskStatus.incomplete()) PTaskStatus status,
    int? rating,
  }) = _PTask;
  factory PTask.fromJson(Map<String, dynamic> json) => _$PTaskFromJson(json);
}
