import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/auth/auth.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';

final defaultUser = User.fromJson(
  jsonDecode('''
{
  "userid": 0,
  "username": "debug",
  "firstname": "Debug",
  "lastname": "Mode",
  "theme": "Light",
  "lang": "en",
  "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
  "planid": 0,
  "colorblindness": "none",
  "displaytaskcount": 1,
  "capabilities": 12,
  "vintage": "5AHIT"
}'''),
);

List<User> get defaultUsers {
  final serde = Modular.get<LocalStorageSerializer<List<User>>>();

  return serde.deserialize(
    jsonDecode('''
{"List<User>":[
  {
    "userid": 0,
    "username": "debug",
    "firstname": "Debug",
    "lastname": "Mode",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "5AHIT"
  },
  {
    "userid": 42,
    "username": "YyqAjYfaWq",
    "firstname": "IRojInsAxk",
    "lastname": "ucYWikirmR",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "ymZjpceUYP"
  },
  {
    "userid": 61,
    "username": "NeIMeDPuiA",
    "firstname": "rXUhJXneOm",
    "lastname": "gMtCoJQJii",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "IOuQRgkqnq"
  },
  {
    "userid": 78,
    "username": "ojgfnNZYAu",
    "firstname": "LDpukveXVk",
    "lastname": "tlGblsrFUs",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "PwLrDnZcOH"
  },
  {
    "userid": 83,
    "username": "ulpKGrCxLL",
    "firstname": "qxVmYcwfci",
    "lastname": "DlMJNFNWhR",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "ETktsLiFSA"
  },
  {
    "userid": 68,
    "username": "FZmOvWDCdy",
    "firstname": "WHOoxyPeDp",
    "lastname": "nyihMcqyub",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "qfkuaRoWxV"
  },
  {
    "userid": 31,
    "username": "cQQgLCGKkD",
    "firstname": "CqzkExePIZ",
    "lastname": "LqhMGlFUfo",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "NPiXeqfHMf"
  },
  {
    "userid": 82,
    "username": "YcICSCdpDw",
    "firstname": "dwjXsfvWJX",
    "lastname": "tONVbEnNzi",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "yXVpPOiGNq"
  },
  {
    "userid": 22,
    "username": "ZMrdFFvVhf",
    "firstname": "UONzxNVJMg",
    "lastname": "mXvhTpFQYz",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "nDznCPWZUH"
  },
  {
    "userid": 8,
    "username": "MZWSkKabCn",
    "firstname": "CWSFpQxNxw",
    "lastname": "DFiqznAVSV",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "wucVeDWtWL"
  },
  {
    "userid": 20,
    "username": "UIVDEzBimD",
    "firstname": "eGBYQzvvcd",
    "lastname": "DYueTuIkGZ",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "RHRbPuLLjb"
  },
  {
    "userid": 17,
    "username": "TTJtRvVXZp",
    "firstname": "PCwNwYayeI",
    "lastname": "SwonYCWtrH",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "CyulfvLfKN"
  },
  {
    "userid": 66,
    "username": "FVcEuWfusx",
    "firstname": "nctmOvxqyu",
    "lastname": "MTkcjDCLQx",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "wNZAxBVcdz"
  },
  {
    "userid": 16,
    "username": "JuiYXVBGHy",
    "firstname": "UPvvMIMUXP",
    "lastname": "WNsMNyUkFa",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "HPnkCrFHTR"
  },
  {
    "userid": 91,
    "username": "PESTQbECwy",
    "firstname": "UZnIVNtcXO",
    "lastname": "WifDyiTZPr",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "eOTyaVDtkv"
  },
  {
    "userid": 76,
    "username": "QQbkPdHAZi",
    "firstname": "UCuZmrrepD",
    "lastname": "cFiCLytdIh",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "BHcdDtMFJF"
  },
  {
    "userid": 50,
    "username": "iFpZQkjqhE",
    "firstname": "DauIHrBZKr",
    "lastname": "uhPInJxBVi",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "MrkJOWkOnJ"
  },
  {
    "userid": 37,
    "username": "CVhoHgyPkd",
    "firstname": "ouHoVyUBUa",
    "lastname": "PFTUswllWE",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "YmaVXqavmv"
  },
  {
    "userid": 56,
    "username": "mzMcfaxPqd",
    "firstname": "joyaDYnIgl",
    "lastname": "NOpExYaelc",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "bJacnSNfnv"
  },
  {
    "userid": 42,
    "username": "hrNTtGXAIV",
    "firstname": "ycugXqoMjS",
    "lastname": "FjVamjPTmh",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "pwtjDzSJaF"
  },
  {
    "userid": 78,
    "username": "LodiNlsALj",
    "firstname": "fGyUdqUjtR",
    "lastname": "VwADwDoFQk",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "gYnWEpQeye"
  }
]}
'''),
  );
}

final defaultTokens = {
  const Token(
    webservice: Webservice.lb_planner_api,
    token: 'DpWjCjT5oaV7JFwQuwZgwMC53BcY2A',
  ),
  const Token(
    webservice: Webservice.moodle_mobile_app,
    token: 'JNR9LeuzJUOSlFJsmluTHMkmwvTGzh',
  ),
};
