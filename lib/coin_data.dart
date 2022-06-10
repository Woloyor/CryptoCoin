import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = '4195ED6B-DE6E-431A-BCBE-59867AEE434F';

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
  Future<dynamic> getCurrencies(String currencySelected) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String url =
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$currencySelected?apikey=$apiKey';

      /// http.Response response = await http.get(Uri.parse(url));
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        /// interprets a given string as JSON
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];

        /// key value pair , key(crypto symbol) and value(lastPrice)
        /// the values of each cryto will be stored in a map(cryptoPrices)
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    return cryptoPrices;
  }
}
