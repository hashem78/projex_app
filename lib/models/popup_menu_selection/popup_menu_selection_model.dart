import 'package:freezed_annotation/freezed_annotation.dart';
part 'popup_menu_selection_model.freezed.dart';

@freezed
class PopupMenuSelection with _$PopupMenuSelection {
  const factory PopupMenuSelection.settings({
    @Default("projectPage.projectMenuSettingsItemText") String name,
  }) = _PopupMenuSelectionSettings;

  static const values = <PopupMenuSelection>[
    PopupMenuSelection.settings(),
  ];
}
