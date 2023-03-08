abstract class Success{
  final String successMessage;

  const Success({required this.successMessage});
}


class ServerSuccess extends Success{
  ServerSuccess({required super.successMessage});

}

class LocalDBSuccess extends Success{
  LocalDBSuccess({required super.successMessage});

}

class UploadingPostSuccess extends Success{
  UploadingPostSuccess({required super.successMessage, required this.uploaderImage,required this.uploaderUsername,
    required this.postID});
  String uploaderUsername;
  String uploaderImage;
  String postID;


}
