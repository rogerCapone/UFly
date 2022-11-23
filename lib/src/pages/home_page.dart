import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flights/src/login_pages/platform_alert_dialog.dart';
import 'package:flights/src/pages/notifications/notifications_page.dart';
import 'package:flights/src/pages/profile_page.dart';
import 'package:flights/src/pages/search_page.dart';
import 'package:flights/src/services/auth_service.dart';
import 'package:flights/src/widgets/flip_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {



 Future<void> _signOut(BuildContext context) async {
  try{
    final auth = Provider.of<AuthBase>(context, listen: false);
  await auth.signOut();
  } catch (e) {
    print(e.toString());
  }
}

  Future<void> _confirmSignOut(BuildContext context) async {

    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      cancelActionText: 'Cancel',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
    ).show(context);
    if(didRequestSignOut == true) {
      _signOut(context);
    }
  }

  
  
 
  


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new NavegacionModel(),
      
      child: Scaffold(
        
        resizeToAvoidBottomPadding: false,
        body: _Paginas(signOut: _confirmSignOut),
        bottomNavigationBar: _CurvedNavegacion(),
      ),
    );
  }
}

class _CurvedNavegacion extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {

     final navegacionModel = Provider.of<NavegacionModel>(context);
     
    return CurvedNavigationBar(
      color: Colors.blueAccent,
     backgroundColor: Colors.black.withOpacity(0.4),
      items: <Widget>[
        Icon(Icons.flight, size: 25, color: Colors.white),
        Icon(Icons.search, size: 25, color: Colors.white),
        Icon(Icons.notifications, size: 25, color: Colors.white),
        Icon(Icons.person_outline, size: 25,color: Colors.white)
      ],
      index: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
    );
  }
}


class _Paginas extends StatelessWidget {

  final Function signOut;

_Paginas({@required this.signOut});
 
  @override
  Widget build(BuildContext context) {

     final navegacionModel = Provider.of<NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[

        PaginaReservas(),
         
        SearchPage(),
        
        NotificationsPage(),
        
        ProfilePage(signOut: signOut,)
      ],
    );
  }
}



class NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;
  

  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 450), curve: Curves.fastLinearToSlowEaseIn);
    notifyListeners();
  
  }

  PageController get pageController => this._pageController;


}