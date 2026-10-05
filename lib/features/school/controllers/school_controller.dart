import 'package:get/get.dart';
import 'package:nutrisafe_student/features/school/data/models/school_models.dart';
import 'package:nutrisafe_student/features/school/data/school_repository.dart';

class SchoolController extends GetxController {
  SchoolController(this._repository);

  final SchoolRepository _repository;
  final isLoading = false.obs;
  final profile = Rxn<SchoolProfileModel>();
  final allergies = <SchoolAllergyModel>[].obs;
  final students = <SchoolStudentModel>[].obs;
  final allergyMenu = <String, dynamic>{}.obs;
  final sppgInfo = <String, dynamic>{}.obs;

  Future<void> loadAll(String token) async {
    if (token.isEmpty || isLoading.value) return;
    isLoading.value = true;
    try {
      final results = await Future.wait<dynamic>([
        _repository.getProfile(token),
        _repository.getAllergies(token),
        _repository.getAllergyMenu(token),
        _repository.getSppgInfo(token),
        _repository.getStudents(token),
      ]);
      profile.value = results[0] as SchoolProfileModel;
      allergies.assignAll(results[1] as List<SchoolAllergyModel>);
      allergyMenu.assignAll(results[2] as Map<String, dynamic>);
      sppgInfo.assignAll(results[3] as Map<String, dynamic>);
      students.assignAll(results[4] as List<SchoolStudentModel>);
    } catch (_) {
      // Demo screens retain their local dummy data when the API is unavailable.
    } finally {
      isLoading.value = false;
    }
  }

  Future<SchoolAllergyModel> addAllergy(
    String token,
    SchoolAllergyModel allergy,
  ) async {
    final created = await _repository.createAllergy(token, allergy);
    allergies.insert(0, created);
    return created;
  }

  Future<SchoolProfileModel> saveProfile(
    String token,
    Map<String, dynamic> changes,
  ) async {
    final updated = await _repository.updateProfile(token, changes);
    profile.value = updated;
    return updated;
  }

  Future<SchoolStudentModel> addStudent(
    String token,
    SchoolStudentModel student,
  ) async {
    final created = await _repository.createStudent(token, student);
    students.add(created);
    return created;
  }

  Future<void> editStudent(String token, SchoolStudentModel student) async {
    final updated = await _repository.updateStudent(token, student);
    final index = students.indexWhere((item) => item.id == updated.id);
    if (index >= 0) students[index] = updated;
  }

  Future<void> removeStudent(String token, int id) async {
    await _repository.deleteStudent(token, id);
    students.removeWhere((item) => item.id == id);
  }
}
