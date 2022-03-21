class Account {
  String name, login, password;

  bool online;

  Account({
    required this.name,
    required this.login,
    required this.password,
    this.online = true,
  });
}
