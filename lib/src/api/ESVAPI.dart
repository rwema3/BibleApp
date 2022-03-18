import 'package:bible/src/model/PassageQuery.dart';
import 'package:reference_parser/reference_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BibleProvider.dart';

/// A provider for the ESV bible translation. Requires an API key.
///
/// Activate an API key [here](https://my.crossway.org/account/register/).
class ESVAPI extends BibleProvider {
  ESVAPI() : super('esvapi', true, {'esv'});

  /// Queries the [esvapi](https://api.esv.org/).
  @override
  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String>? parameters, String? key, String? version}) async {
    final params = {
      'q': query.reference,
      'include-passage-references':
          '${parameters!['include-passage-references'] ?? 'false'}',
      'include-verse-numbers':
          '${parameters['include-verse-numbers'] ?? 'false'}',
      'include-first-verse-numbers':
          '${parameters['include-first-verse-numbers'] ?? 'false'}',
      'include-footnotes': '${parameters['include-footnotes'] ?? 'false'}',
      'include-footnote-body':
          '${parameters['include-footnote-body'] ?? 'false'}',
      'include-headings': '${parameters['include-headings'] ?? 'false'}',
      'include-short-copyright':
          '${parameters['include-short-copyright'] ?? 'false'}',
      'include-copyright': '${parameters['include-copyright'] ?? 'false'}',
      'include-passage-horizontal-lines':
          '${parameters['include-passage-horizontal-lines'] ?? 'false'}',
      'include-selahs': '${parameters['include-selahs'] ?? 'true'}',
      'horizontal-line-length':
          '${parameters[' horizontal-line-length'] ?? '55'}',
      'indent-using': '${parameters['indent-using'] ?? 'space'}',
      'indent-paragraphs': '${parameters['indent-paragraphs'] ?? '2'}',
      'indent-poetry': '${parameters['indent-poetry'] ?? 'true'}',
      'indent-poetry-lines': '${parameters['indent-poetry-lines'] ?? '4'}',
      'indent-declares': '${parameters['indent-declares'] ?? '40'}',
      'indent-psalm-doxology': '${parameters['indent-psalm-doxology'] ?? '30'}',
      'line-length': '${parameters['line-length'] ?? '0'}'
    };
    final uri = Uri.https('api.esv.org', '/v3/passage/text/', params);
    final res = await http.get(uri, headers: {
      'Authorization': 'Token ${key}',
    });
    var json = jsonDecode(res.body);
    var passage = json['passages'].join(' ').trim();
    return PassageQuery.fromProvider(passage, json['canonical'], 'ESV',
        extra: json);
  }
}
