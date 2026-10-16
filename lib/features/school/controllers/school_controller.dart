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
  final classes = <SchoolClassModel>[].obs;
  final teachers = <SchoolTeacherModel>[].obs;
  final reports = <Map<String, dynamic>>[].obs;
  final allergyMenu = <String, dynamic>{}.obs;
  final sppgInfo = <String, dynamic>{}.obs;
  final pendingDelivery = <String, dynamic>{}.obs;
  final errorMessage = RxnString();

  Future<void> loadAll(String token) async {
    if (token.isEmpty || isLoading.value) return;
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final results = await Future.wait<dynamic>([
        _attempt(() => _repository.getProfile(token)),
        _attempt(() => _repository.getAllergies(token)),
        _attempt(() => _repository.getAllergyMenu(token)),
        _attempt(() => _repository.getSppgInfo(token)),
        _attempt(() => _repository.getStudents(token)),
        _attempt(() => _repository.getClasses(token)),
        _attempt(() => _repository.getTeachers(token)),
        _attempt(() => _repository.getReports(token)),
        _attempt(() => _repository.getPendingDelivery(token)),
      ]);
      if (results[0] case final SchoolProfileModel value) profile.value = value;
      if (results[1] case final List<SchoolAllergyModel> value) {
        allergies.assignAll(value);
      }
      if (results[2] case final Map<String, dynamic> value) {
        allergyMenu.assignAll(value);
      }
      if (results[3] case final Map<String, dynamic> value) {
        sppgInfo.assignAll(value);
      }
      if (results[4] case final List<SchoolStudentModel> value) {
        students.assignAll(value);
      }
      if (results[5] case final List<SchoolClassModel> value) {
        classes.assignAll(value);
      }
      if (results[6] case final List<SchoolTeacherModel> value) {
        teachers.assignAll(value);
      }
      if (results[7] case final List<Map<String, dynamic>> value) {
        reports.assignAll(value);
      }
      if (results[8] case final Map<String, dynamic> value) {
        pendingDelivery.assignAll(value);
      }
      if (results.every((item) => item == null)) {
        errorMessage.value = 'Data sekolah tidak dapat dimuat.';
      }
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<T?> _attempt<T>(Future<T> Function() request) async {
    try {
      return await request();
    } catch (_) {
      return null;
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
