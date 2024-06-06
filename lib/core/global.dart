import 'package:goose/data/repos/database_repo.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';

final formatCurrency = NumberFormat.simpleCurrency(locale: "ru");
final getIt = GetIt.instance;

Future<void> setup() async{
  getIt.registerLazySingleton<DataBaseRepo>(() => DataBaseRepo());
}
