class Food {
  final String id;
  final String name;
  final String category;
  final String image;
  final bool diabetics;
  final bool cholesterol;
  final bool bloodpressure;
  final double cal_per_gram;
  final double protein;
  final double fat;
  final double fiber;
  final double carbs;
  bool selected = false;

  Food({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.diabetics,
    required this.cholesterol,
    required this.bloodpressure,
    required this.cal_per_gram,
    required this.protein,
    required this.fat,
    required this.fiber,
    required this.carbs,
  });

  setSelected(){
    selected = true;
  }

}
