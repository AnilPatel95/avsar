class UserModel {
  String? responseStatus;
  String? responseMessage;
  Data? data;

  UserModel({this.responseStatus, this.responseMessage, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseStatus'] = this.responseStatus;
    data['responseMessage'] = this.responseMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? refreshToken;
  bool? isSuccess;
  dynamic? reason;
  int? userId;

  Data(
      {this.token,
        this.refreshToken,
        this.isSuccess,
        this.reason,
        this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    isSuccess = json['isSuccess'];
    reason = json['reason'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    data['isSuccess'] = this.isSuccess;
    data['reason'] = this.reason;
    data['userId'] = this.userId;
    return data;
  }
}
