class Pokemon {
  final String id;
  final String name;
  final String description;
  final String type;
  final num    power;
  final String imageUrl;

  const Pokemon({
    this.id = '',
    required this.name,
    required this.description,
    required this.type,
    required this.power,
    required this.imageUrl,
  });
}