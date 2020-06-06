
import 'dart:convert';

import 'dart:io';

String formatPhoneLabel(String phone){
  String newPhone = "";
  for(int i = 0 ; i < phone.length; i++){
    if(i == 3 || i == 5 || i == 8){
      newPhone += " ";
    }
    newPhone += phone[i];
  }
  return newPhone;
}
String getFileBase64(File image) {
  if(image != null) {
    List<int> bytes = image.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }
  return null;
}
