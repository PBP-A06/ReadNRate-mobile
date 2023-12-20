import 'package:flutter/material.dart';

import 'package:project/readlist/models/readlist.dart';
import 'package:project/readlist/screens/readlist_detail.dart';

import 'package:google_fonts/google_fonts.dart';


class ReadlistCard extends StatelessWidget {
  final Readlist readlist;

  const ReadlistCard(this.readlist, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(40),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                "${readlist.fields.name}",
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Likes: ${readlist.fields.likes}",
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                "${readlist.fields.description}",
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade500),
                  ),
                  // nanti redirect to details page di modul readlist
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReadlistDetailPage(readlistId: readlist.pk)),
                    );
                  },
                  child: Text(
                    "See Details",
                    style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
