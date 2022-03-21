import '../../models/account.dart';

class AccountRepository {
  static List<Account> accounts = accountsOffline + accountsOnline;

  static List<Account> accountsOffline = [
    Account(
      name: 'Biscoint',
      login: 'matheusgalvao',
      password: 'hashlash',
      online: false,
    ),
    Account(
      name: 'Coinbase',
      login: 'matheusgalvao@email.com',
      password: 'goodam',
      online: false,
    ),
    Account(
      name: 'Binance',
      login: 'matheusgalvao@gmail.com',
      password: 'facesss',
      online: false,
    ),
  ];

  static List<Account> accountsOnline = [
    Account(
      name: 'Instagram',
      login: 'matheusgalvao',
      password: 'hashlash',
      online: true,
    ),
    Account(
      name: 'Facebook',
      login: 'matheusgalvao@email.com',
      password: 'goodam',
      online: true,
    ),
    Account(
      name: 'Google',
      login: 'matheusgalvao@gmail.com',
      password: 'facesss',
      online: true,
    ),
    Account(
      name: 'Moodle',
      login: 'matheusgalvao@utfpr.com',
      password: 'sortasas',
      online: true,
    ),
    Account(
      name: 'Twitter',
      login: 'galvao',
      password: 'fdsafdafddas',
      online: true,
    ),
  ];
}
