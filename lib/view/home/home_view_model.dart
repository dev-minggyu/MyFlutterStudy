import 'package:flutter_dio/data/repository/repository.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeViewModel extends Model {
  Repository _repository = Repository();

  loadUserInfo() async {
    return await _repository.loadUserInfo();
  }
}
