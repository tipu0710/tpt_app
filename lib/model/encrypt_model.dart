class EncryptModel {
  String data;
  bool hasError;
  List<Map<String, dynamic>> errors;

  EncryptModel({this.data, this.hasError, this.errors});

  EncryptModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'];
    hasError = json['HasError'];
    if (json['Errors'] != null) {
      errors = new List<Map<String, dynamic>>();
      json['Errors'].forEach((v) { errors.add(v); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Data'] = this.data;
    data['HasError'] = this.hasError;
    if (this.errors != null) {
      data['Errors'] = this.errors.map((v) => v).toList();
    }
    return data;
  }
}
