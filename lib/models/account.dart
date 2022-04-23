class Account {
  int id;
  String name, login, password;

  Account({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
  });

  Map<String, Object?> toJson() => {
        'id': id,
        'nome': name,
        'login': login,
        'senha': password,
      };
}
