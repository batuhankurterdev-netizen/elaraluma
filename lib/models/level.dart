class Level {
  final int id;
  final String name;
  final String description;
  final String type;
  bool completed;
  bool locked;

  Level({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.completed = false,
    this.locked = false,
  });
}
