class RegisterModel {
  String? responseStatus;
  String? responseMessage;
  int? data;

  RegisterModel({this.responseStatus, this.responseMessage, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['responseStatus'] = responseStatus;
    data['responseMessage'] = responseMessage;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}