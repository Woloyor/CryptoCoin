import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = '4195ED6B-DE6E-431A-BCBE-59867AEE434F';
String url = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$apiKey';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'UAH',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  CoinData({this.value, this.currency});

  final String value;
  final String currency;

  Future<dynamic> getRate() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      /// interprets a given string as JSON
      var decodedData = jsonDecode(response.body);
      var rate = decodedData['rate'];
      return rate;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }

  getCoinData() {
    // String url =
    //     'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$apiKey';
    http.get(url).then((response) {
      print(response.body);
    });
    return getCoinData();
  }
}
