import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lol/normal/debug.dart';
import 'package:path_provider/path_provider.dart';

class FileIO
{
  static Future<String> readText(String dir_) async{
    try{
      final dir = await getApplicationDocumentsDirectory();
      File file = File(dir.path + dir_);
      if(file.exists() == false)
        writeText(dir_,"");
      return await File(dir.path + dir_).readAsString();
    }catch(e){
      Debug.logError("FileIO : readText : $e");
      return "";
    }
  }

  static Future<bool> writeText(String dir_ , String text_) async{
    try{
      final dir = await getApplicationDocumentsDirectory();
      File(dir.path + dir_).writeAsString(text_);
      return true;
    }catch(e){
      print("FileIO : writeText : $e");
      return false;
    }
  }

  static Future<bool> isFileExist(String dir_)async{
    final dir = await getApplicationDocumentsDirectory();
    var syncPath = await dir.path + dir_;
    return await File(syncPath).exists();
  }

  static Future<bool> isDirectoryExist(String dir_)async{
    final dir = await getApplicationDocumentsDirectory();
    var syncPath = await dir.path + dir_;
    return await Directory(syncPath).exists();
  }

  static Future<bool> makeDirectory(String dir_)async{
    try{
      final dir = await getApplicationDocumentsDirectory();
      var syncPath = await dir.path + dir_;
      await isDirectoryExist(dir_).then((value){
        if(value == false){
          Directory(syncPath).create();
          Debug.log("FileIO : makeDirectory : Directory Exist");
        }
        else{
          Debug.log("FileIO : makeDirectory : Directory not Exist");
        }
      });
      return true;
    }catch(e){
      print("FileIO : makeDirectory : ${e}");
      return false;
    }

  }
}