import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BibleProvider.dart';

/// A provider for the ESV bible translation. Requires an API key.
///
/// Activate an API key [here](https://my.crossway.org/account/register/).
class BibleAPI extends BibleProvider {
  BibleAPI()
      : super('bibleapi', false, {
          'cherokee',
          'kjv',
          'web',
          'clementine',
          'almeida',
          'rccv',
        });

  /// Queries the [bibleapi](https://bible-api.com/).
  @override
  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String>? parameters, String? key, String? version}) async {
    final params = {
      'verse_numbers': '${parameters!['verse_numbers'] ?? 'false'}',
      'translation': "${version ?? 'web'}",
    };
    final uri = Uri.https('bible-api.com', '/${query.reference}', params);
    final res = await http.get(uri);
    var json = jsonDecode(res.body);
    var versesRaw = json['verses'];
    var verses = <String, String?>{};
    versesRaw.forEach((x) => {
          verses['${x['book_name']} ${x['chapter']}:${x['verse']}'] = x['text'],
        });
    var reference = query.reference;
    var passage = json['text'].trim();
    var translation = json['translation_id'].toUpperCase();
    return PassageQuery.fromProvider(passage, reference, translation,
        verses: verses, extra: json);
  }
}
