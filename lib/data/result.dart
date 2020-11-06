import 'package:flutter_dio/constant/network_constant.dart';

class Result<T> {
  ApiStatus status;
  T data;
  String message;
  ApiError apiError;

  Result({ApiStatus status, T data, ApiError apiError}) {
    this.status = status;
    this.data = data;
    this.apiError = apiError;
  }

  static Result<T> loading<T>() {
    return Result<T>(status: ApiStatus.LOADING, data: null);
  }

  static Result success<T>(T data) {
    return Result<T>(status: ApiStatus.COMPLETED, data: data);
  }

  static Result<T> error<T>(
      {int errCode, String errMsg, String errBdy, T data}) {
    ApiError apiError = ApiError(
        statusCode: errCode,
        errorMessage: errMsg,
        errorBody: errBdy == null ? "" : errBdy);
    return Result<T>(status: ApiStatus.ERROR, apiError: apiError, data: data);
  }

  static Result<T> returnResponse<T>(dynamic response, T data) {
    int resultCode = response['result_code'];
    if (resultCode == NetworkConstant.SUCCESS) {
      return Result.success(data);
    } else {
      return Result.error(
          errCode: resultCode,
          errMsg: response['error_msg'],
          errBdy: response['resultData'],
          data: null);
    }
  }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

class ApiError {
  int statusCode;
  String errorMessage;
  String errorBody;

  ApiError({this.statusCode, this.errorMessage, this.errorBody});
}

enum ApiStatus { LOADING, COMPLETED, ERROR }
