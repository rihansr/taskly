part of 'sections_bloc.dart';

enum Status { initial, loading, creating, updating, deleting, success, failure }

@Freezed(copyWith: true, equal: true)
class SectionsState with _$SectionsState {
  const factory SectionsState({
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(<SectionModel>[]) List<SectionModel> sections,
    @Default(SectionModel()) SectionModel section,
  }) = _SectionsState;
}
