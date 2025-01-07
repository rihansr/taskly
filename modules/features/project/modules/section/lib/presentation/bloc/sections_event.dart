part of 'sections_bloc.dart';

@freezed
class SectionsEvent with _$SectionsEvent {
  const factory SectionsEvent.allSections({
    required String projectId,
  }) = _AllSections;
  const factory SectionsEvent.addSection({
    required String projectId,
    required String name,
  }) = _AddSection;
  const factory SectionsEvent.sectionDetails({
    required String id,
  }) = _SectionDetails;
  const factory SectionsEvent.updateSection({
    required SectionModel section,
  }) = _UpdateSection;
  const factory SectionsEvent.deleteSection({
    required String id,
  }) = _DeleteSection;
  const factory SectionsEvent.reset() = _Reset;
}
