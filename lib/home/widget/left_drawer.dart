import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/home/screens/menu.dart';
import 'package:project/user_profile/screens/profile.dart';
import 'package:project/main/screens/login.dart';
import 'package:project/main/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserProfileWidget extends StatelessWidget {
  String username;

  UserProfileWidget({required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        const Padding(
          padding: EdgeInsets.all(30),
            child: CircleAvatar(
              radius: 38,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/550x/6e/c3/13/6ec313d108678bd6e33d5e6935c3099f.jpg'),
            ),
          ),

        Text(
          username,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero)
      ),
      backgroundColor: const Color(0xFF2C343F),
      child: ListView(
        children: [
          if (usernameGlobal != null) //USER IS LOGGED IN
            Theme(
              data:  Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(color: Colors.transparent),
              ),
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/a_ap-mob-cozy-tapes-vol-2-too-cozy-Cover-Art.jpg'), 
                    fit: BoxFit.cover,
                    opacity: 0.15,
                    ),
                ),
                padding: const EdgeInsets.all(0),
                child: UserProfileWidget(
                    username: usernameGlobal!), // Use ! to assert non-null
              )
            )
            
          else //USER NOT LOGGED IN
            Theme(
              data:  Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(color: Colors.transparent),
              ),
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/dark_library.jpg'), 
                    fit: BoxFit.cover,
                    opacity: 0.2,
                    ),
                ),
                child: Image.asset(
                  'assets/logolong.png', // Replace with the path to your logo image
                  height: 80, // Adjust the height as needed
                ),
              ),
            ),

          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            title: 
            const Padding ( 
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          if (usernameGlobal != null)
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const Padding ( 
              padding: EdgeInsets.only(left: 10),
              child: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                // Route ke Profile
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfilePage()),
                );
              },
            ),
          if (usernameGlobal != null)
            ListTile(
              leading: const Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              title: const Text(
                'Bookmarks',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
              },
            ),
          if (usernameGlobal != null)
            ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              title: const Text(
                'Likes',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
              },
            ),
          if (usernameGlobal != null)
            ListTile(
              title: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                  onPressed: () async {
                    final response = await request
                        .logout("https://readnrate.adaptable.app/auth/logout/");
                    String message = response["message"];
                    usernameGlobal = null;
                    if (response['status']) {
                      String uname = response["username"];
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("See you next time, $uname."),
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$message"),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400], 
                    elevation: 1,
                  ),
                  child: Text(
                    'Logout',
                    style: GoogleFonts.almarai(
                      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                    ),
                  )
                ),
              ),
            ),
          if (usernameGlobal == null)
            ListTile(
              leading: const Icon(
                Icons.login,
                color: Colors.white,
              ),
              title: const Padding ( 
              padding: EdgeInsets.only(left: 10),
              child:  Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          if (usernameGlobal == null)
            ListTile(
              leading: const Icon(
                Icons.person_add,
                color: Colors.white,
              ),
              title: const Padding ( 
              padding: EdgeInsets.only(left: 10),
              child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
            ),
        ],
      ),
    );
  }
}
