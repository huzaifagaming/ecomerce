import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  final String email = 'example@example.com';
  final String phone = '+1234567890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Me'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Section
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://example.com/profile.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              'Your Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Flutter Developer',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 16),

            // Contact Information
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(phone),
              onTap: () => _launchPhone(phone),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(email),
              onTap: () => _launchEmail(email),
            ),

            // Social Media Links (example for LinkedIn)
            ListTile(
              leading: Icon(Icons.link),
              title: Text('LinkedIn Profile'),
              onTap: () => _launchURL('https://linkedin.com/in/your-profile'),
            ),

            // Message Form (simplified)
            TextField(
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),

            // Send Button
            ElevatedButton(
              onPressed: () {
                // Handle send message action
              },
              child: Text('Send Message'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.green.shade500,
        onPressed: (){
          String url =
              "https://wa.me/+923045873730/?text=Hello";
          launch(url);
        },child:FaIcon(FontAwesomeIcons.whatsapp,color: Colors.white,),
      ),
    );
  }

  // Helper methods for launching actions
  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
