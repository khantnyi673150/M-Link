import 'shop_model.dart';

/// Mock shop data with real Unsplash images
/// Categories: Food, Coffee, Stationary, Services, Fashion, Tech, Health, Entertainment
const List<Shop> mockShops = [
  // ── FOOD ────────────────────────────────────────────────────────
  Shop(
    id: 'shop_001',
    name: 'Campus Cafe',
    category: 'Food',
    description:
        'Fresh coffee, pastries, and light meals perfect for students. '
        'Free WiFi available and cozy seating for long study sessions.',
    rating: 4.7,
    imageUrls: [
      'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800&q=80',
      'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&q=80',
      'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800&q=80',
    ],
    priceRange: '\$5 – \$15',
    location: '123 University Ave, Building A',
    phone: '+1 (555) 123-4567',
  ),
  Shop(
    id: 'shop_002',
    name: 'Thai Street Kitchen',
    category: 'Food',
    description:
        'Authentic Thai cuisine with student-friendly portions and prices. '
        'Try our signature Pad Thai and Tom Yum soup made fresh daily.',
    rating: 4.5,
    imageUrls: [
      'https://images.unsplash.com/photo-1562565652-a0d8f0c59eb4?w=800&q=80',
      'https://images.unsplash.com/photo-1533622597524-a1215e26c0a2?w=800&q=80',
      'https://images.unsplash.com/photo-1548943487-a2e4e43b4853?w=800&q=80',
    ],
    priceRange: '\$8 – \$20',
    location: '456 Main Street, Food Court Level 2',
    phone: '+1 (555) 234-5678',
  ),
  Shop(
    id: 'shop_003',
    name: 'Pizza Paradise',
    category: 'Food',
    description:
        'New York style pizza by the slice or whole pie. Late night delivery available for those study sessions.',
    rating: 4.8,
    imageUrls: [
      'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&q=80',
      'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800&q=80',
      'https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?w=800&q=80',
    ],
    priceRange: '\$6 – \$18',
    location: '321 Campus Drive, Near Library',
    phone: '+1 (555) 987-6543',
  ),

  // ── COFFEE ──────────────────────────────────────────────────────
  Shop(
    id: 'shop_004',
    name: 'Bean There Coffee',
    category: 'Coffee',
    description:
        'Specialty coffee roasted in-house. Offering espresso, pour-over, and cold brew. '
        'Student discount available with ID.',
    rating: 4.9,
    imageUrls: [
      'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800&q=80',
      'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=800&q=80',
      'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800&q=80',
    ],
    priceRange: '\$3 – \$8',
    location: 'Student Center, Ground Floor',
    phone: '+1 (555) 111-2222',
  ),
  Shop(
    id: 'shop_005',
    name: 'Morning Brew',
    category: 'Coffee',
    description:
        'Quick coffee and breakfast sandwiches. Perfect for early morning classes.',
    rating: 4.4,
    imageUrls: [
      'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800&q=80',
      'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&q=80',
      'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=800&q=80',
    ],
    priceRange: '\$2 – \$7',
    location: 'Engineering Building Lobby',
    phone: '+1 (555) 222-3333',
  ),

  // ── STATIONARY ──────────────────────────────────────────────────
  Shop(
    id: 'shop_006',
    name: 'Campus Books & Supplies',
    category: 'Stationary',
    description:
        'All your academic needs: textbooks, notebooks, pens, calculators, and more. '
        'Textbook buyback program available.',
    rating: 4.3,
    imageUrls: [
      'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=800&q=80',
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=800&q=80',
      'https://images.unsplash.com/photo-1456735190827-d1262f71b8a3?w=800&q=80',
    ],
    priceRange: '\$2 – \$200',
    location: 'Main Campus Bookstore',
    phone: '+1 (555) 333-4444',
  ),
  Shop(
    id: 'shop_007',
    name: 'Print & Copy Center',
    category: 'Stationary',
    description:
        'Printing, binding, laminating, and photocopying services. Same-day thesis printing available.',
    rating: 4.6,
    imageUrls: [
      'https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?w=800&q=80',
      'https://images.unsplash.com/photo-1586281380349-632531db7ed4?w=800&q=80',
      'https://images.unsplash.com/photo-1586281380117-5a60ae2050cc?w=800&q=80',
    ],
    priceRange: '\$0.10 – \$50',
    location: 'Library Basement',
    phone: '+1 (555) 444-5555',
  ),

  // ── REPAIRS / SERVICES ──────────────────────────────────────────
  Shop(
    id: 'shop_008',
    name: 'TechFix Repairs',
    category: 'Repairs',
    description:
        'Fast and affordable electronics repair for laptops, phones, and tablets. '
        'Most screen replacements and battery swaps completed same day.',
    rating: 4.6,
    imageUrls: [
      'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=800&q=80',
      'https://images.unsplash.com/photo-1581092580497-e0d23cbdffd8?w=800&q=80',
      'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80',
    ],
    priceRange: '\$10 – \$80',
    location: '789 Student Hub, Room 14',
    phone: '+1 (555) 345-6789',
  ),
  Shop(
    id: 'shop_009',
    name: 'QuickFix Mobile',
    category: 'Repairs',
    description:
        'Smartphone and tablet repair specialists. Screen protectors, cases, and accessories available.',
    rating: 4.5,
    imageUrls: [
      'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=800&q=80',
      'https://images.unsplash.com/photo-1556656793-08538906a9f8?w=800&q=80',
      'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=800&q=80',
    ],
    priceRange: '\$15 – \$100',
    location: 'Tech Mall, Booth 5',
    phone: '+1 (555) 555-6666',
  ),

  // ── FASHION ─────────────────────────────────────────────────────
  Shop(
    id: 'shop_010',
    name: 'Campus Threads',
    category: 'Fashion',
    description:
        'Trendy clothing and accessories for students. University merchandise and custom printing available.',
    rating: 4.2,
    imageUrls: [
      'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=800&q=80',
      'https://images.unsplash.com/photo-1445205170230-053b83016050?w=800&q=80',
      'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800&q=80',
    ],
    priceRange: '\$10 – \$80',
    location: 'Campus Mall, 2nd Floor',
    phone: '+1 (555) 666-7777',
  ),
  Shop(
    id: 'shop_011',
    name: 'Sneaker Zone',
    category: 'Fashion',
    description:
        'Latest sneakers and athletic wear. Student athlete discounts available.',
    rating: 4.7,
    imageUrls: [
      'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=800&q=80',
      'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=800&q=80',
      'https://images.unsplash.com/photo-1556906781-9a412961c28c?w=800&q=80',
    ],
    priceRange: '\$30 – \$150',
    location: 'Sports Complex Entrance',
    phone: '+1 (555) 777-8888',
  ),

  // ── TECH ────────────────────────────────────────────────────────
  Shop(
    id: 'shop_012',
    name: 'Gadget Hub',
    category: 'Tech',
    description:
        'Latest tech gadgets, accessories, and smart devices. Educational discounts on laptops and tablets.',
    rating: 4.8,
    imageUrls: [
      'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=800&q=80',
      'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=800&q=80',
      'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=800&q=80',
    ],
    priceRange: '\$20 – \$2000',
    location: 'Tech District, Store 12',
    phone: '+1 (555) 888-9999',
  ),

  // ── HEALTH ──────────────────────────────────────────────────────
  Shop(
    id: 'shop_013',
    name: 'Campus Pharmacy',
    category: 'Health',
    description:
        'Full-service pharmacy with student health insurance accepted. Over-the-counter medications and wellness products.',
    rating: 4.5,
    imageUrls: [
      'https://images.unsplash.com/photo-1576602976047-174e57a47881?w=800&q=80',
      'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=800&q=80',
      'https://images.unsplash.com/photo-1631549916768-4119b2e5f926?w=800&q=80',
    ],
    priceRange: '\$5 – \$50',
    location: 'Health Services Building',
    phone: '+1 (555) 999-0000',
  ),
  Shop(
    id: 'shop_014',
    name: 'FitLife Gym',
    category: 'Health',
    description:
        'Student fitness center with modern equipment. Group classes and personal training available.',
    rating: 4.6,
    imageUrls: [
      'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800&q=80',
      'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=800&q=80',
      'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800&q=80',
    ],
    priceRange: '\$20 – \$60/month',
    location: 'Recreation Center, Level 2',
    phone: '+1 (555) 000-1111',
  ),

  // ── ENTERTAINMENT ───────────────────────────────────────────────
  Shop(
    id: 'shop_015',
    name: 'Game Zone Arcade',
    category: 'Entertainment',
    description:
        'Retro and modern arcade games, board game cafe, and gaming tournaments. Student hangout spot.',
    rating: 4.8,
    imageUrls: [
      'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=800&q=80',
      'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=800&q=80',
      'https://images.unsplash.com/photo-1556438758-8d49568ce18e?w=800&q=80',
    ],
    priceRange: '\$5 – \$25',
    location: 'Student Union, 3rd Floor',
    phone: '+1 (555) 111-2223',
  ),
  Shop(
    id: 'shop_016',
    name: 'Campus Cinema',
    category: 'Entertainment',
    description:
        'Student-discount movie theater showing latest releases. Special midnight screenings on weekends.',
    rating: 4.7,
    imageUrls: [
      'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800&q=80',
      'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=800&q=80',
      'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=800&q=80',
    ],
    priceRange: '\$5 – \$12',
    location: 'Arts & Culture Center',
    phone: '+1 (555) 222-3334',
  ),
];
