

import 'package:flights/src/models/avatar_reference.dart';
import 'package:flights/src/services/firebase_storage_service/firebase_storage.dart';
import 'package:flights/src/services/firebase_storage_service/firestore_service.dart';
import 'package:flights/src/services/firebase_storage_service/image_picker_service.dart';
import 'package:flights/src/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



class BuildUserImg extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final database = Provider.of<FirestoreService>(context);
   
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(),
      builder: (context, snapshot) {
        final avatarReference = snapshot.data;
        return Avatar(
          photoUrl: avatarReference?.imgUrl,
          radius: 50,
          borderColor: Colors.blueAccent,
          borderWidth: 2.0,
          onPressed: () => chooseAvatar(context)
           
        );
      }
    );
  }
}



  Future<void> chooseAvatar(BuildContext context) async {
    try{

      //1.Get Image From Picker
      final imagePicker = Provider.of<ImagePickerService>(context, listen: false);
      final file = await imagePicker.pickImage(source: ImageSource.gallery); //possibilitat de canviar per la camera
      if(file != null){
      //2. Upload to Storage
      
      final storage =  Provider.of<FirebaseStorageService>(context, listen: false);
      final imgUrl = await storage.uploadAvatar(file: file);
      //3. Save to Firestore Cloud
      final database  = Provider.of<FirestoreService>(context, listen: false);
      await database.setAvatarReference(AvatarReference(imgUrl)
        );
      //remove local file
      await file.delete();
      }



    }catch(e){
      print(e.toString());
    }
  }



