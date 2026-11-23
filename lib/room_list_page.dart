import 'package:flutter/material.dart';

class RoomItem {
  String name;
  String details;
  String bedInfo;
  String imageUrl;
  bool isExpanded;
  RoomItem({
    required this.name,
    required this.details,
    required this.bedInfo,
    required this.imageUrl,
    this.isExpanded = false,
  });
}

class RoomListPage extends StatefulWidget {
  const RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  List<RoomItem> rooms = [
    RoomItem(
      name: "King Room",
      details: "Large bed, free breakfast, sea view",
      bedInfo: "1 King Bed",
      imageUrl: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
    ),
    RoomItem(
      name: "Double Bed Room",
      details: "Two beds, city view, balcony",
      bedInfo: "2 Single Beds",
      imageUrl: "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2",
    ),
    RoomItem(
      name: "Family Room",
      details: "Two bedrooms, living room, kitchen",
      bedInfo: "2 Queen Beds + Sofa Bed",
      imageUrl: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Your Room",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: rooms.map((room) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ExpansionTile(
              initiallyExpanded: room.isExpanded,
              onExpansionChanged: (expanded) {
                setState(() {
                  room.isExpanded = expanded;
                });
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  room.imageUrl,
                  width: 120,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                room.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              subtitle: Text(
                room.details,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.blue[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bed Information: ${room.bedInfo}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(room.details),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D47A1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${room.name} Reserved Successfully!",
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Select",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
