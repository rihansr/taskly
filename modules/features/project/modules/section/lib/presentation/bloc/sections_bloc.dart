import 'package:core/utils/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import '../../domain/models/section_model.dart';
import '../../domain/usecases/all_sections_usecase.dart';
import '../../domain/usecases/create_section_usecase.dart';
import '../../domain/usecases/delete_section_usecase.dart';
import '../../domain/usecases/single_section_usecase.dart';
import '../../domain/usecases/update_section_usecase.dart';
part 'sections_event.dart';
part 'sections_state.dart';
part 'sections_bloc.freezed.dart';

class SectionsBloc extends Bloc<SectionsEvent, SectionsState> {
  late AllSectionsUseCase _allSectionsUseCase;
  late SingleSectionUseCase _singleSectionUseCase;
  late CreateSectionUseCase _addSectionUseCase;
  late UpdateSectionUseCase _updateSectionUseCase;
  late DeleteSectionUseCase _deleteSectionUseCase;

  SectionsBloc(
    this._allSectionsUseCase,
    this._addSectionUseCase,
    this._singleSectionUseCase,
    this._updateSectionUseCase,
    this._deleteSectionUseCase,
  ) : super(const _SectionsState()) {
    on<SectionsEvent>((events, emit) async {
      await events.map(
        allSections: (event) async => await _allSections(event, emit),
        sectionDetails: (event) async => await _sectionDetails(event, emit),
        addSection: (event) async => await _addSection(event, emit),
        updateSection: (event) async => await _updateSection(event, emit),
        deleteSection: (event) async => await _deleteSection(event, emit),
      );
    });
  }

  SectionsBloc.sections(
    this._allSectionsUseCase,
  ) : super(const SectionsState()) {
    on<SectionsEvent>((events, emit) async {
      await events.mapOrNull(
        allSections: (event) async => await _allSections(event, emit),
      );
    });
  }

  SectionsBloc.single(
    this._addSectionUseCase,
    this._singleSectionUseCase,
    this._updateSectionUseCase,
    this._deleteSectionUseCase,
  ) : super(const _SectionsState()) {
    on<SectionsEvent>((events, emit) async {
      await events.mapOrNull(
        sectionDetails: (event) async => await _sectionDetails(event, emit),
        addSection: (event) async => await _addSection(event, emit),
        updateSection: (event) async => await _updateSection(event, emit),
        deleteSection: (event) async => await _deleteSection(event, emit),
      );
    });
  }

  _allSections(_AllSections event, Emitter<SectionsState> emitter) async {
    emitter(state.copyWith(status: Status.loading));
    final result = await _allSectionsUseCase.invoke(
      {
        'project_id': event.projectId,
      },
    );
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (sections) => emitter(
        state.copyWith(
          status: Status.success,
          sections: sections,
        ),
      ),
    );
  }

  _sectionDetails(_SectionDetails event, Emitter<SectionsState> emitter) async {
    emitter(state.copyWith(status: Status.loading));
    final result = await _singleSectionUseCase.invoke(event.id);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (section) => emitter(
        state.copyWith(
          status: Status.success,
          section: section,
        ),
      ),
    );
  }

  _addSection(_AddSection event, Emitter<SectionsState> emitter) async {
    emitter(state.copyWith(status: Status.creating));
    final result = await _addSectionUseCase.invoke(
      {
        'project_id': event.projectId,
        'name': event.name,
      },
    );
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (section) => emitter(
        state.copyWith(
          status: Status.success,
          section: section,
          sections: [...state.sections, section],
        ),
      ),
    );
  }

  _updateSection(_UpdateSection event, Emitter<SectionsState> emitter) async {
    emitter(state.copyWith(status: Status.updating));
    final result = await _updateSectionUseCase.invoke(event.section);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (section) => emitter(
        state.copyWith(
          status: Status.success,
          section: section,
          sections: state.sections
              .map((e) => e.id == section.id ? section : e)
              .toList(),
        ),
      ),
    );
  }

  _deleteSection(_DeleteSection event, Emitter<SectionsState> emitter) async {
    emitter(state.copyWith(status: Status.deleting));
    final result = await _deleteSectionUseCase.invoke(event.id);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (isSuccessful) => emitter(
        isSuccessful
            ? state.copyWith(
                status: Status.success,
                sections: state.sections
                    .where((element) => element.id != event.id)
                    .toList(),
              )
            : state.copyWith(status: Status.initial),
      ),
    );
  }
}
