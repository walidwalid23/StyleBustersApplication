class NetworkErrorModel{
  final int statusCode;
  final String errorMessage;


  NetworkErrorModel({
    required this.statusCode,
    required this.errorMessage,

  });

  factory NetworkErrorModel.fromJson(Map<String,dynamic> json){
    return NetworkErrorModel(statusCode: json['statusCode'],
      errorMessage:json ['errorMessage'],

    );
  }

}