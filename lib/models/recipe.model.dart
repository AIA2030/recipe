class Recipe {
  String? docId;
  String? title;
  String? image;

  Recipe();

  Recipe.fromJson(Map<String, dynamic> data, [String? id]) {
  docId = id;
  title = data['title'];
  image = data['image'];
  }

  Map<String, dynamic> toJson() {
  return {
  "title": title,
  "image": image,
  };
  }
  }
