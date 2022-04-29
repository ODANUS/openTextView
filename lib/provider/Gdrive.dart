import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:http/http.dart' as http;

// ./gradlew signingReport
// keytool -list -v -keystore <path>/key.jks -alias key -storepass *** -keypass ****
class Gdrive {
  static drive.DriveApi? driveApi;

  static Map<String, String> authHeaders = {};

  // static
  static Future<bool> gdriveSignIn() async {
    final googleSignIn = signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveAppdataScope]);
    final signIn.GoogleSignInAccount? account = await googleSignIn.signIn();
    var hasScope = false;
    try {
      hasScope = await googleSignIn.requestScopes([drive.DriveApi.driveAppdataScope]);
    } catch (e) {
      await googleSignIn.signOut();
      return false;
    }
    if (!hasScope) {
      await googleSignIn.signOut();
      return false;
    }
    authHeaders = await account!.authHeaders;
    driveApi = drive.DriveApi(GoogleAuthClient(authHeaders));
    return true;
  }

  static Future<List<drive.File>> getAppDataList() async {
    if (driveApi != null) {
      var list = await driveApi!.files.list(spaces: 'appDataFolder');
      return list.files!;
    }
    return [];
  }

  static Future<drive.File?> createFile({required String name, required String data}) async {
    if (driveApi != null) {
      return _create(name: name, data: data);
    }
    return null;
  }

  static Future<drive.File> _create({required String name, required String data}) {
    List<int> uploadData = utf8.encode(data);
    final Stream<List<int>> mediaStream = Future.value(uploadData).asStream().asBroadcastStream();
    var media = new drive.Media(mediaStream, uploadData.length);
    var driveFile = new drive.File();
    driveFile.name = name;
    driveFile.parents = ["appDataFolder"];

    return driveApi!.files.create(driveFile, uploadMedia: media);
  }

  static Future removeAppdata(String id) async {
    if (driveApi != null) {
      await driveApi!.files.delete(id);
    }
  }

  static Future<String> readAppData(String id) async {
    if (driveApi != null) {
      Completer<String> c = Completer<String>();
      var file = await driveApi!.files.get(id, downloadOptions: drive.DownloadOptions.fullMedia);
      var media = file as drive.Media;
      List<int> rtn = [];
      media.stream.listen((data) {
        rtn.addAll(data);
      }, onDone: () {
        c.complete(utf8.decode(rtn));
      });
      return c.future;
    }
    return "";
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = new http.Client();

  GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}
