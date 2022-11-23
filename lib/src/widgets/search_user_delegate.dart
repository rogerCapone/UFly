

import 'package:flights/src/models/search_user_model.dart';
import 'package:flights/src/services/database.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flights/src/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchUser extends SearchDelegate{
  
  
  @override
  List<Widget> buildActions(BuildContext context) {
   
   return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
   
    return (
      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        },
      )
    );
  }
  

  @override
  Widget buildResults(BuildContext context) {
    
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    

   if (query.isEmpty || query.length < 4){
     return Container();
   }

    final res = Provider.of<ProfileServices>(context, listen: false);

     return FutureBuilder(
     future: DataBase(uid: res.dbUser.uid).searchUser(query),
     builder: (BuildContext context, AsyncSnapshot<List<UsersData>> snapshot) {
      
      if(snapshot.hasData){

        final  users = snapshot.data;
       
       return ListView.builder(
         itemCount: users.length,
         itemBuilder: (BuildContext context, int index) {
         return GestureDetector(
           child: ListTile(
             leading: Avatar(
               photoUrl: users[index].img, 
               radius: 20,

             ),
             title: Text(users[index].nickName),
           ),
           onTap: () {
             
              Navigator.pushNamed(context, 'peopleProfile', arguments: users[index]);
              
           },
         );
        },
       );
       
       
       
       
       
       
       
       
       
        // return ListView(
        //   children: users.map((user) {
        //     return GestureDetector(
        //       child: ListTile(
        //         // leading: CircleAvatar(
        //         //   child: Image(
        //         //     image: NetworkImage('${user.img}'),
        //         //   ),
        //         // ),
        //         // title: Text(user.nickName),
        //       ),
        //       // onTap: () {
        //       //   Navigator.pushNamed(context, 'detalle', arguments: vuelo);
        //       // },
        //     );

        //   }).toList()

          
        // );
        
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    
    
    
     },
   );
  }

}
