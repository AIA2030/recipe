class Ingredient {
  String? docId;
  String? name;
  String? image;
  List<String>? users_ids;


  Ingredient();


  Ingredient.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    name = data['name'];
    image = data['image'];
    users_ids = data['users_ids'] != null? List<String>.from(data ['users_ids'].map((e) => e.toString())) : null;

  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "users_ids": users_ids,

    };
  }
}

