class UserModel{
  String PhoneNumber;

  UserModel ({
    required this.PhoneNumber,
  });

//from Map
  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      PhoneNumber: map['PhoneNumber'] ?? '',
    );
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      "PhoneNumber" : PhoneNumber,
    };
    }
  }

