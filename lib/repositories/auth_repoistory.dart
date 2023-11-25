import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/models/error_model.dart';
import 'package:google_docs_clone/models/user_model.dart';
import 'package:google_docs_clone/utils/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

import 'local_storage_repository.dart';

final authRepositoryProvider = Provider(
    (ref) => AuthRepository(googleSignIn: GoogleSignIn(), client: Client(), localStorageRepository: LocalStorageRepository()));

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStorageRepository _localStorageRepository;

  AuthRepository({required GoogleSignIn googleSignIn, required Client client, required LocalStorageRepository localStorageRepository})
      : _googleSignIn = googleSignIn,
        _client = client, _localStorageRepository = localStorageRepository;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel errorModel =
        ErrorModel(error: "Some unexpected error is happen", data: null);
    try {
      final user = await _googleSignIn.signIn();

      if (user != null) {
        UserModel userModel = UserModel(
            email: user.email,
            name: user.displayName!,
            profilPic: user.photoUrl!,
            uid: "",
            token: "");

        var res = await _client.post(Uri.parse('$host/api/signup'),
            body: userModel.toJson(),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
            });

        switch (res.statusCode) {
          case 200:
            final newUser = userModel.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
            );
            errorModel = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }

    return errorModel;
  }
}
