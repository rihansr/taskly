final serverEnv = _ServerEnv.value;

class _ServerEnv {
  static _ServerEnv get value => _ServerEnv._();
  _ServerEnv._();

  // Project endpoints
  final projects = "projects";
  

  // Section Endpoints
  final sections = "sections";

  // Task Endpoints
  final tasks = "tasks";

  // Comment Endpoints
  final comments = "comments";

  // Label Endpoints
  final labels = "labels";
}