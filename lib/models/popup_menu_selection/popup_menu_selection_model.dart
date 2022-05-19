import 'package:freezed_annotation/freezed_annotation.dart';
part 'popup_menu_selection_model.freezed.dart';

@freezed
class PopupMenuSelection with _$PopupMenuSelection {
  const factory PopupMenuSelection.edit({
    @Default("Edit") String name,
  }) = _PopupMenuSelectionEdit;
  const factory PopupMenuSelection.settings({
    @Default("Settings") String name,
  }) = _PopupMenuSelectionSettings;

  static const values = <PopupMenuSelection>[
    PopupMenuSelection.edit(),
    PopupMenuSelection.settings(),
  ];
}
