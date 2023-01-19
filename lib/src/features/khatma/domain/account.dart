class Account {
  String? id;
  String? login;
  String? password;
  String? name;
  String? lastName;
  String? type;
  String? imageUrl;

  @override
  String toString() {
    return 'Account:{id: $id, login: $login, password: $password, name: $name, lastName: $lastName, type: $type, imageUrl: $imageUrl}';
  }
}

enum AccountType { private, pro, broker }
