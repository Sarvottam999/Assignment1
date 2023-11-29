// user model 

 class UserModel {

  final String? id;
  final String name;
  final String email;
  final String password;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  toJson() {
    return {
       'FullName': name,
       'Email': email,
       'Password': password,
    };
  }

   
 }
