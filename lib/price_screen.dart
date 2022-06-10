import 'package:bitcoin_app/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as hhtp;
import 'dart:convert';

import 'currency.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Map<String, String> coinValues = {};

  /// set the default currency
  String selectedCurrency = 'USD';
  bool isWaiting = false;
  String value;
  @override
  void initState() {
    super.initState();
    getCurrenciesData();
  }

  getCurrenciesData() async {
    isWaiting = true;
    try {
      dynamic data = await CoinData().getCurrencies(selectedCurrency);
      isWaiting = false;
      setState(() {
        /// a map containing the values/rates
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getCurrenciesData();
        });
      },
    );
  }

  List<DropdownMenuItem> dropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      //for every currency in the list we create a new dropdownmenu item
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      // add to the list of menu item
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currecy in currenciesList) {
      pickerItems.add(Text(currecy,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.white)));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CardButton(
            cryptoCurrency: 'BTC',
            selectedCurrency: selectedCurrency,

            /// this is a ternary opertor, it checks if is waiting is true, it displays a ? but if its false
            /// meaning all operations are done  it prints the value of BTC(key) in the coinValues map.
            value: isWaiting ? '?' : coinValues['BTC'],
          ),
          CardButton(
            cryptoCurrency: 'ETH',
            selectedCurrency: selectedCurrency,
            value: isWaiting ? '?' : coinValues['ETH'],
          ),
          CardButton(
            cryptoCurrency: 'LTC',
            selectedCurrency: selectedCurrency,
            value: isWaiting ? '?' : coinValues['LTC'],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              dropdownColor: Colors.lightBlueAccent,
              value: selectedCurrency,
              items: dropDown(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value;

                  /// call this function each time the value in the drop down changes.
                  getCurrenciesData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
