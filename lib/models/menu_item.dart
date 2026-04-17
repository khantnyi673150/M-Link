/// Menu item model for shop detail screen
class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
}

/// Sample menu items - replace with real data from API
const List<MenuItem> sampleMenuItems = [
  MenuItem(
    id: 'sample_1',
    name: 'Cappuccino',
    description: 'Rich espresso with steamed milk',
    price: 4.50,
  ),
  MenuItem(
    id: 'sample_2',
    name: 'Croissant',
    description: 'Fresh-baked butter croissant',
    price: 3.00,
  ),
  MenuItem(
    id: 'sample_3',
    name: 'Chicken Sandwich',
    description: 'Grilled chicken with fresh vegetables',
    price: 8.50,
  ),
  MenuItem(
    id: 'sample_4',
    name: 'Caesar Salad',
    description: 'Crisp romaine with parmesan and croutons',
    price: 7.00,
  ),
  MenuItem(
    id: 'sample_5',
    name: 'Smoothie Bowl',
    description: 'Acai blend topped with fresh fruits and granola',
    price: 6.50,
  ),
];
