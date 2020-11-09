import 'package:flutter_dio/data/model/response/document_count.dart';
import 'package:flutter_dio/data/repository/repository.dart';
import 'package:flutter_dio/data/result.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeViewModel extends Model {
  Repository _repository = Repository();

  loadUserInfo() async {
    return await _repository.loadUserInfo();
  }

  Result<DocumentCount> _documentCountResult = Result();

  Result<DocumentCount> get documentCountResult => _documentCountResult;

  documentCount() async {
    _documentCountResult = Result.loading();
    notifyListeners();

    _documentCountResult = await _repository.documentCount();
    notifyListeners();
  }
}
