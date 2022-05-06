// class Character

class Character {
  late String name;
  late String imgUrl;
  late int id;

  // constructor
  Character(this.name, this.imgUrl, this.id);

  // fromJson method - convert json to character
  Character.fromJson(Map<String, dynamic> json) {
    Character(
      name = json['name'],
      imgUrl = json['img'],
      id = json['char_id'],
    );
  }
}
