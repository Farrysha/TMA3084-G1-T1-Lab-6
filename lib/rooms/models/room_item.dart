/// One bookable suite shown on the room list.
class RoomItem {
  RoomItem({
    required this.name,
    required this.details,
    required this.bedInfo,
    required this.price,
    required this.imageUrl,
    this.isExpanded = false,
  });

  final String name;
  final String details;
  final String bedInfo;
  final String price;
  final String imageUrl;
  bool isExpanded;
}
