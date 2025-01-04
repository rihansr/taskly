import '../../domain/models/section_model.dart';

abstract class SectionsApi {
  Future<List<SectionModel>> getAllProjectSections(
      Map<String, dynamic> queryParams);
  Future<SectionModel> getSectionById(String id);
  Future<SectionModel> createNewSection(Map<String, dynamic> data);
  Future<SectionModel> updateSection(SectionModel section);
  Future<bool> deleteSection(String id);
}
