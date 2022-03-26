class Account {
  int id;
  String name, login, password;
  bool online;

  Account({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    this.online = true,
  });
}
