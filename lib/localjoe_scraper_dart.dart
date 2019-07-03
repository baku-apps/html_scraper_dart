import 'dart:convert'; // Contains the JSON encoder

import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart'; // Contains DOM related classes for extracting data from elements

import 'dart:io';

Future initiate() async {
  // Use html parser
  var localJoeHtml = await File("localjoe_aanbod.html").readAsString();
  var document = parse(localJoeHtml);
  List<Element> properties = document.querySelectorAll('.list-object');
  List<Map<String, dynamic>> propertiesList = [];
  
  for (var property in properties) {

    var propertyNodes =  property.children;

    var detailsUrl = propertyNodes[0].querySelector('a').attributes['href'];
    var id = detailsUrl.split("/").last;
    var photoUrl = propertyNodes[0].querySelector('a > img').attributes['src'];

    var address = propertyNodes[1].querySelector('.list-object-address').text;
    var price = propertyNodes[1].querySelector('.list-object-price').text;
    var city = propertyNodes[1].querySelector('.list-object-zip-code').text;

    propertiesList.add({
      'id': id,
      'photoUrl': photoUrl,
      'address': address,
      'city': city,
      'price': price
    });
  }

  var jsonString = json.encode(propertiesList);
  await File("localjoe.json").writeAsString(jsonString);
  print("Parsing done!");
}


