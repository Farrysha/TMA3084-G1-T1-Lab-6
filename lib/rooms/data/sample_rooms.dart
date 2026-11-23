import '../models/room_item.dart';

/// Suites shown on the room list. A new list is created per page state
/// so expansion stays local to that visit.
List<RoomItem> createSampleRooms() {
  return <RoomItem>[
    RoomItem(
      name: 'King Room',
      details:
          'A quiet suite with a large bed, breakfast included, and a sea view.',
      bedInfo: '1 King Bed',
      price: 'RM 320',
      imageUrl:
          'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=600&q=60',
    ),
    RoomItem(
      name: 'Double Bed Room',
      details: 'Two beds, a city view, and a balcony for longer stays.',
      bedInfo: '2 Single Beds',
      price: 'RM 240',
      imageUrl:
          'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=60',
    ),
    RoomItem(
      name: 'Family Room',
      details: 'Two bedrooms, a living room, and a small kitchen.',
      bedInfo: '2 Queen Beds + Sofa Bed',
      price: 'RM 480',
      imageUrl:
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=60',
    ),
  ];
}
