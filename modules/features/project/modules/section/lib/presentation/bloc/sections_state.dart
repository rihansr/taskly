part of 'sections_bloc.dart';

@Freezed(copyWith: true, equal: true)
class SectionsState with _$SectionsState {
  const factory SectionsState({
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(<SectionModel>[]) List<SectionModel> sections,
    @Default(SectionModel()) SectionModel section,
  }) = _SectionsState;
}
