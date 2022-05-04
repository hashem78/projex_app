import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/enums/status.dart';
import 'package:projex_app/models/message_model/message_model.dart';
import 'package:projex_app/models/notification_model/notification_model.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role_model.dart';
import 'package:projex_app/models/social_model/social_model.dart';
import 'package:projex_app/models/task_model/task_mode.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class PUser with _$PUser {
  const PUser._();
  Future<void> addSoicals({
    required List<PSocial> social,
  }) async {
    // TODO: user.addSocial()
  }
  Future<void> createGroup({
    required List<String> memberIds,
  }) async {
    // TODO: user.CreateGroup()
  }
  Future<void> addMembersToGroup({
    @Default("") required String groupId,
    required List<String> memberIds,
  }) async {
    // TODO: user.addMembersToGroup()
  }

  Future<void> sendProjectNotification({
    @Default("") required String projectId,
    required PNotification notification,
  }) async {
    // TODO: user.sendProjectNotification()
  }

  Future<void> sendGroupNotification({
    @Default("") required String projectId,
    @Default("") required String groupId,
    required PNotification notification,
  }) async {
    // TODO: user.sendGroupNotification()
  }

  Future<void> sendMessageInThread({
    @Default("") required String projectId,
    @Default("") required String threadId,
    required PMessage message,
  }) async {
    // TODO: user.sendMessageInThread()
  }

  Future<void> createTask({
    @Default("") required String projectId,
    required PTask task,
  }) async {
    // TODO: user.createTask()
  }

  Future<void> removeTask({
    @Default("") required String projectId,
    @Default("") required String taskId,
  }) async {
    // TODO; user.removeTask()
  }

  Future<void> setTaskStatus({
    @Default("") required String projectId,
    @Default("") required String taskId,
    required PStatus statuss,
  }) async {
    // TODO: user.setTaskStatus
  }

  Future<void> createProject({
    required PProject project,
  }) async {
    // TODO: user.createProject()
    map(
      student: (student) {
        // Students aren't allowed to create projects.
      },
      instructor: (instructor) {},
    );
  }

  Future<void> addStudentsToProject({
    @Default("") required String projectId,
    required List<String> studentIds,
  }) async {
    // TODO: user.addStudentsToProject()
    map(
      student: (student) {
        // Students aren't allowed to add students to a project.
      },
      instructor: (instructor) {},
    );
  }

  Future<void> assignRoles({
    @Default("") required String projectId,
    required Map<String, PRole> rolesMap,
  }) async {
    // TODO: user.assignRoles()
  }

  const factory PUser.student({
    @Default("") String id,
    @Default("") String name,
    @Default("") String email,
    @Default("") String studentNumber,
    @Default("") String phoneNumber,
    PProfilePicture? profilePicture,
    @Default([]) List<PSocial> socials,
    @Default([]) List<String> projectIds,
  }) = _PUserStudent;
  const factory PUser.instructor({
    @Default("") String id,
    @Default("") String name,
    @Default("") String email,
    @Default("") String phoneNumber,
    PProfilePicture? profilePicture,
    @Default([]) List<PSocial> socials,
    @Default([]) List<String> projectIds,
  }) = _PUserInstructor;
  factory PUser.fromJson(Map<String, dynamic> json) => _$PUserFromJson(json);
}
