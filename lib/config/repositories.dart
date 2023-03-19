import 'package:get_it/get_it.dart';
import 'package:yahoo_finance_flutter/data/repositories/finance_repository.dart';

class Repositories {
  static void register() {
    GetIt.I.registerSingleton<FinanceRepository>(FinanceRepository());
  }
}
