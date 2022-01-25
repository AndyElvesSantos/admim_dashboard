
  import 'package:hasura_connect/hasura_connect.dart';

HasuraConnect hasuraConnect = HasuraConnect(
    Constants.urlBanco,
    headers: {
      "x-hasura-admin-secret": Constants.senhaBanco,
    }
  );



abstract class Constants {
  static const String urlBanco = "https://polite-tortoise-57.hasura.app/v1/graphql";
  static const String senhaBanco = "Sou79aRVx9tsVHKUr3WZOH27MJJVMT38IYliwiPZO5l4bKyVYF0LMM3RrGvpmsRr";
}