import 'dart:convert';

// 직렬화 : 객체를 JSON 형태의 문자열로 변환할 때
//        객체 -> Map -> String
//        jsonEncode
//        객체에 toJson 메서드 구현
// 역직렬화 : JSON형태의 문자열를 객체로 변환할 때
//          String -> Map -> 객체로 바꿔준다
//          String -> Map : jsonDecode 함수
//          Map -> 객체 : 객체에 fromJson named 생성자를 구현해서 사용!

void main() {
  // Pet

  String easyJson = """
{
	"name": "오상구",
	"age": 7,
	"isMale" : true
}
""";

  // 1. String -> Map 형태로 바꾼다
  Map<String, dynamic> easyMap = jsonDecode(easyJson);

  // 3. Map -> class 객체로 바꾼다

  Pet pet = Pet.fromJson(easyMap);
  print(pet.toJson());

  // PerDetail
  // Contact
  String hardJson = """
{
	"name": "오상구",
	"age": 7,
	"isMale" : true,
	"favorite_foods" : ["삼겹살", "연어", "고구마"],
	"contact": {
		"mobile": "010-0000-0000",
		"email": null
	}
}
""";

  // 1. jsonString -> Map 형태로 바꾼다
  Map<String, dynamic> hardMap = jsonDecode(hardJson);
  // 3. class를 정의했으니 객체로 만든다
  PetDetail petDetail = PetDetail.fromJson(hardMap);
  print(petDetail.toJson());
}

// 2. 객체로 바꾸기 위해서 class를 정의한다

class PetDetail {
  String name;
  int age;
  bool isMale;
  List<String> favoriteFoods;
  Contact contact;

  PetDetail({
    required this.name,
    required this.age,
    required this.isMale,
    required this.favoriteFoods,
    required this.contact,
  });

  // fromJson named생성자 만들기
  PetDetail.fromJson(Map<String, dynamic> map)
    : this(
        name: map['name'],
        age: map['age'],
        isMale: map['isMale'],
        favoriteFoods: List<String>.from(map['favorite_foods']),
        contact: Contact.fromJson(map['contact']),
      );

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'isMale': isMale,
      'favorite_foods': favoriteFoods,
      'contact': contact.toJson(),
    };
  }
}

class Contact {
  String mobile;
  String? email;

  Contact({required this.mobile, required this.email});

  // Contact.formJson 네임드 생성자 만들기
  Contact.fromJson(Map<String, dynamic> map)
    : this(mobile: map['mobile'], email: map['email']);
  // toJson 메서드 만들기
  Map<String, dynamic> toJson() {
    return {'mobile': mobile, 'email': email};
  }
}

// 2. class 를 정의 한다.
class Pet {
  String name;
  int age;
  bool isMale;

  Pet({required this.name, required this.age, required this.isMale});

  // fromJson named생성자 만들기
  Pet.fromJson(Map<String, dynamic> map)
    : this(name: map['name'], age: map['age'], isMale: map['isMale']);

  //
  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age, 'isMale': isMale};
  }
}
