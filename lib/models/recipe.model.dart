class Recipe {
  String? docId;
  String? type;
  String? title;
  String? image;
  String? describtion;
  num? calories;
  num? rate;
  num? total_time;
  num? serving;
  List<String>? users_ids;
  List<String>? ingredients;
  Map<String, String>? directions;

  Recipe();

  Recipe.fromJson(Map<String, dynamic> data, [String? id]) {
  docId = id;
  type = data['type'];
  title = data['title'];
  image = data['image'];
  describtion = data['describtion'];
  calories = data['calories'];
  rate = data['rate'];
  total_time = data['total_time'];
  serving = data['serving'];
  users_ids = data['users_ids'] != null? List<String>.from(data ['users_ids'].map((e) => e.toString())) : null;
  ingredients = data['ingredients'] != null? List<String>.from(data ['ingredients'].map((e) => e.toString())) : null;
  directions = data['directions'] != null? Map<String, String>.from(data ['directions']) : null;

  }

  Map<String, dynamic> toJson() {
  return {
    "type": type,
    "title": title,
    "image": image,
    "describtion": describtion,
    "calories": calories,
    "rate": rate,
    "total_time": total_time,
    "serving": serving,
    "users_ids": users_ids,
    "ingredients": ingredients,
    "directions": directions,
  };
  }
  }
