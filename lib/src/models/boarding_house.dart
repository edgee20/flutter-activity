/// BoardingHouse Model
///
/// Represents a boarding house / transient stay property in the Liu platform
class BoardingHouse {
  final String id;
  final String name;
  final String address;
  final double pricePerNight;
  final List<String> amenities;
  final String contact;
  final String imageUrl;

  const BoardingHouse({
    required this.id,
    required this.name,
    required this.address,
    required this.pricePerNight,
    required this.amenities,
    required this.contact,
    required this.imageUrl,
  });

  /// Mock data for development - 100 items
  static List<BoardingHouse> getMockData() {
    return [
      const BoardingHouse(
        id: 'bh_001',
        name: 'Sunset Breeze Transient',
        address: 'Mactan Island, Lapu-Lapu City, Cebu',
        pricePerNight: 850.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Shared Kitchen',
          'Parking',
          'CCTV',
        ],
        contact: '+63 912 345 6789',
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      ),
      const BoardingHouse(
        id: 'bh_002',
        name: 'Tropical Haven Boarding House',
        address: 'Bonifacio Street, Davao City',
        pricePerNight: 1200.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Laundry Area',
          'CCTV',
          'Furnished Room',
        ],
        contact: '+63 923 456 7890',
        imageUrl:
            'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
      ),
      const BoardingHouse(
        id: 'bh_003',
        name: 'Beachside Paradise Rooms',
        address: 'White Beach, Station 2, Boracay',
        pricePerNight: 950.0,
        amenities: ['WiFi', 'Air Conditioning', 'Private CR', 'Balcony'],
        contact: '+63 934 567 8901',
        imageUrl:
            'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
      ),
      const BoardingHouse(
        id: 'bh_004',
        name: 'Fiesta House Transient',
        address: 'Sinulog Avenue, Cebu City',
        pricePerNight: 750.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Study Area', 'Laundry Area'],
        contact: '+63 945 678 9012',
        imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
      ),
      const BoardingHouse(
        id: 'bh_005',
        name: 'Palm Grove Residences',
        address: 'J.P. Laurel Avenue, Davao City',
        pricePerNight: 1500.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'CCTV',
          'Furnished Room',
          'Private CR',
        ],
        contact: '+63 956 789 0123',
        imageUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
      ),
      const BoardingHouse(
        id: 'bh_006',
        name: 'Coral Bay Lodging',
        address: 'Alona Beach, Panglao, Bohol',
        pricePerNight: 680.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 967 890 1234',
        imageUrl:
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
      ),
      const BoardingHouse(
        id: 'bh_007',
        name: 'Mango Tree Guest House',
        address: 'Osmena Boulevard, Cebu City',
        pricePerNight: 890.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Shared Kitchen',
          'Laundry Area',
          'Study Area',
        ],
        contact: '+63 978 901 2345',
        imageUrl:
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9',
      ),
      const BoardingHouse(
        id: 'bh_008',
        name: 'Island Breeze Transient',
        address: 'General Luna, Siargao Island',
        pricePerNight: 1100.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Furnished Room'],
        contact: '+63 989 012 3456',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
      ),
      const BoardingHouse(
        id: 'bh_009',
        name: 'Hibiscus Garden Rooms',
        address: 'Session Road, Baguio City',
        pricePerNight: 920.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'CCTV'],
        contact: '+63 990 123 4567',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
      ),
      const BoardingHouse(
        id: 'bh_010',
        name: 'Sampaguita Inn',
        address: 'Rizal Avenue, Puerto Princesa, Palawan',
        pricePerNight: 800.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Private CR',
          'Laundry Area',
          'Study Area',
        ],
        contact: '+63 901 234 5678',
        imageUrl:
            'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3',
      ),
      const BoardingHouse(
        id: 'bh_011',
        name: 'Azure Sky Dormitory',
        address: 'Matina District, Davao City',
        pricePerNight: 450.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Study Area', 'CCTV'],
        contact: '+63 917 234 5678',
        imageUrl:
            'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde',
      ),
      const BoardingHouse(
        id: 'bh_012',
        name: 'Coastal Haven Boarding',
        address: 'Mactan Highway, Lapu-Lapu City',
        pricePerNight: 780.0,
        amenities: ['WiFi', 'Air Conditioning', 'Parking', 'Furnished Room'],
        contact: '+63 928 345 6789',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687644-c7171b42498b',
      ),
      const BoardingHouse(
        id: 'bh_013',
        name: 'Golden Sunrise Residences',
        address: 'Cabancalan, Mandaue City, Cebu',
        pricePerNight: 650.0,
        amenities: ['WiFi', 'Laundry Area', 'CCTV', 'Private CR'],
        contact: '+63 939 456 7890',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154526-990dced4db0d',
      ),
      const BoardingHouse(
        id: 'bh_014',
        name: 'Emerald Hills Lodging',
        address: 'Capitol Hills, Quezon City',
        pricePerNight: 1350.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'CCTV',
          'Furnished Room',
        ],
        contact: '+63 940 567 8901',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d',
      ),
      const BoardingHouse(
        id: 'bh_015',
        name: 'Paradise View Apartments',
        address: 'Bajada District, Davao City',
        pricePerNight: 980.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Laundry Area',
        ],
        contact: '+63 951 678 9012',
        imageUrl:
            'https://images.unsplash.com/photo-1600566752355-35792bedcfea',
      ),
      const BoardingHouse(
        id: 'bh_016',
        name: 'Coconut Grove Inn',
        address: 'Mabolo, Cebu City',
        pricePerNight: 720.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Study Area', 'CCTV'],
        contact: '+63 962 789 0123',
        imageUrl:
            'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea',
      ),
      const BoardingHouse(
        id: 'bh_017',
        name: 'Ocean Breeze Transient',
        address: 'Panglao Island, Bohol',
        pricePerNight: 1150.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 973 890 1234',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
      ),
      const BoardingHouse(
        id: 'bh_018',
        name: 'Bamboo Garden Residences',
        address: 'Maa Road, Davao City',
        pricePerNight: 550.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Laundry Area', 'Parking'],
        contact: '+63 984 901 2345',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154363-67eb9e2e2099',
      ),
      const BoardingHouse(
        id: 'bh_019',
        name: 'Starlight Boarding House',
        address: 'IT Park, Cebu City',
        pricePerNight: 1280.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Study Area',
          'CCTV',
          'Furnished Room',
        ],
        contact: '+63 995 012 3456',
        imageUrl:
            'https://images.unsplash.com/photo-1600573472550-8090b5e0745e',
      ),
      const BoardingHouse(
        id: 'bh_020',
        name: 'Riverside Haven Lodging',
        address: 'Carmen, Cagayan de Oro',
        pricePerNight: 620.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'Private CR'],
        contact: '+63 906 123 4567',
        imageUrl:
            'https://images.unsplash.com/photo-1600566752355-35792bedcfea',
      ),
      const BoardingHouse(
        id: 'bh_021',
        name: 'Tropical Palms Dormitory',
        address: 'UP Diliman, Quezon City',
        pricePerNight: 480.0,
        amenities: ['WiFi', 'Study Area', 'Laundry Area', 'CCTV'],
        contact: '+63 917 234 5679',
        imageUrl:
            'https://images.unsplash.com/photo-1600585152220-90363fe7e115',
      ),
      const BoardingHouse(
        id: 'bh_022',
        name: 'Sunrise Bay Apartments',
        address: 'Cordova, Mactan Island, Cebu',
        pricePerNight: 890.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Parking',
          'Furnished Room',
        ],
        contact: '+63 928 345 6780',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154084-4e5fe7c39198',
      ),
      const BoardingHouse(
        id: 'bh_023',
        name: 'Moonlight Residences',
        address: 'Buhangin, Davao City',
        pricePerNight: 710.0,
        amenities: ['WiFi', 'Shared Kitchen', 'CCTV', 'Private CR'],
        contact: '+63 939 456 7891',
        imageUrl:
            'https://images.unsplash.com/photo-1600047509358-9dc75507daeb',
      ),
      const BoardingHouse(
        id: 'bh_024',
        name: 'Garden Vista Boarding',
        address: 'Lahug, Cebu City',
        pricePerNight: 950.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'Laundry Area',
          'Study Area',
        ],
        contact: '+63 940 567 8902',
        imageUrl:
            'https://images.unsplash.com/photo-1600563438938-a9a27216b4f5',
      ),
      const BoardingHouse(
        id: 'bh_025',
        name: 'Seashell Transient House',
        address: 'Mambajao, Camiguin',
        pricePerNight: 820.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 951 678 9013',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d',
      ),
      const BoardingHouse(
        id: 'bh_026',
        name: 'Pinewood Lodging',
        address: 'Teachers Camp, Baguio City',
        pricePerNight: 680.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'Study Area'],
        contact: '+63 962 789 0124',
        imageUrl:
            'https://images.unsplash.com/photo-1600566752229-250ed79470e1',
      ),
      const BoardingHouse(
        id: 'bh_027',
        name: 'Blue Horizon Dormitory',
        address: 'Silliman Avenue, Dumaguete City',
        pricePerNight: 520.0,
        amenities: ['WiFi', 'Study Area', 'Laundry Area', 'CCTV'],
        contact: '+63 973 890 1235',
        imageUrl:
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9',
      ),
      const BoardingHouse(
        id: 'bh_028',
        name: 'Sunset Hills Residences',
        address: 'Talamban, Cebu City',
        pricePerNight: 780.0,
        amenities: ['WiFi', 'Air Conditioning', 'Parking', 'Furnished Room'],
        contact: '+63 984 901 2346',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
      ),
      const BoardingHouse(
        id: 'bh_029',
        name: 'Coral Reef Apartments',
        address: 'Coron Town, Palawan',
        pricePerNight: 1050.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Laundry Area',
        ],
        contact: '+63 995 012 3457',
        imageUrl:
            'https://images.unsplash.com/photo-1600573472550-8090b5e0745e',
      ),
      const BoardingHouse(
        id: 'bh_030',
        name: 'Mountain View Boarding',
        address: 'Mines View, Baguio City',
        pricePerNight: 850.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'CCTV'],
        contact: '+63 906 123 4568',
        imageUrl:
            'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3',
      ),
      const BoardingHouse(
        id: 'bh_031',
        name: 'Lagoon Side Inn',
        address: 'Tagbilaran City, Bohol',
        pricePerNight: 730.0,
        amenities: ['WiFi', 'Air Conditioning', 'Private CR', 'Parking'],
        contact: '+63 917 234 5680',
        imageUrl:
            'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde',
      ),
      const BoardingHouse(
        id: 'bh_032',
        name: 'Citylight Transient',
        address: 'Ayala Center, Makati City',
        pricePerNight: 1650.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'CCTV',
          'Furnished Room',
          'Study Area',
        ],
        contact: '+63 928 345 6781',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687644-c7171b42498b',
      ),
      const BoardingHouse(
        id: 'bh_033',
        name: 'Breezy Palms Lodging',
        address: 'Talomo District, Davao City',
        pricePerNight: 590.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Laundry Area', 'CCTV'],
        contact: '+63 939 456 7892',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154526-990dced4db0d',
      ),
      const BoardingHouse(
        id: 'bh_034',
        name: 'Horizon Bay Apartments',
        address: 'Subic Bay, Zambales',
        pricePerNight: 1180.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'Balcony',
          'Private CR',
        ],
        contact: '+63 940 567 8903',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d',
      ),
      const BoardingHouse(
        id: 'bh_035',
        name: 'Starfish Boarding House',
        address: 'El Nido, Palawan',
        pricePerNight: 920.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 951 678 9014',
        imageUrl:
            'https://images.unsplash.com/photo-1600566752355-35792bedcfea',
      ),
      const BoardingHouse(
        id: 'bh_036',
        name: 'Greenfield Residences',
        address: 'Panacan, Davao City',
        pricePerNight: 670.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'Study Area'],
        contact: '+63 962 789 0125',
        imageUrl:
            'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea',
      ),
      const BoardingHouse(
        id: 'bh_037',
        name: 'Sunny Coast Inn',
        address: 'San Juan, La Union',
        pricePerNight: 880.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Laundry Area'],
        contact: '+63 973 890 1236',
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      ),
      const BoardingHouse(
        id: 'bh_038',
        name: 'Orchid Garden Dormitory',
        address: 'University Belt, Manila',
        pricePerNight: 460.0,
        amenities: ['WiFi', 'Study Area', 'CCTV', 'Laundry Area'],
        contact: '+63 984 901 2347',
        imageUrl:
            'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
      ),
      const BoardingHouse(
        id: 'bh_039',
        name: 'Pearl Harbor Lodging',
        address: 'Mandurriao, Iloilo City',
        pricePerNight: 750.0,
        amenities: ['WiFi', 'Air Conditioning', 'Private CR', 'Parking'],
        contact: '+63 995 012 3458',
        imageUrl:
            'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
      ),
      const BoardingHouse(
        id: 'bh_040',
        name: 'Cascade Heights Boarding',
        address: 'Tomas Morato, Quezon City',
        pricePerNight: 1320.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Furnished Room',
          'CCTV',
          'Parking',
        ],
        contact: '+63 906 123 4569',
        imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
      ),
      const BoardingHouse(
        id: 'bh_041',
        name: 'Firefly Transient House',
        address: 'Poblacion, Makati City',
        pricePerNight: 1450.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Furnished Room'],
        contact: '+63 917 345 6789',
        imageUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
      ),
      const BoardingHouse(
        id: 'bh_042',
        name: 'Pineapple Grove Inn',
        address: 'Malaybalay City, Bukidnon',
        pricePerNight: 580.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'Private CR'],
        contact: '+63 928 456 7890',
        imageUrl:
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
      ),
      const BoardingHouse(
        id: 'bh_043',
        name: 'Sapphire Bay Residences',
        address: 'Mactan Newtown, Lapu-Lapu',
        pricePerNight: 1090.0,
        amenities: ['WiFi', 'Air Conditioning', 'Parking', 'Balcony', 'CCTV'],
        contact: '+63 939 567 8901',
        imageUrl:
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9',
      ),
      const BoardingHouse(
        id: 'bh_044',
        name: 'Willow Tree Apartments',
        address: 'Burnham Park, Baguio City',
        pricePerNight: 810.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Study Area', 'Laundry Area'],
        contact: '+63 940 678 9012',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
      ),
      const BoardingHouse(
        id: 'bh_045',
        name: 'Anchor Bay Lodging',
        address: 'Olongapo City, Zambales',
        pricePerNight: 720.0,
        amenities: ['WiFi', 'Air Conditioning', 'Private CR', 'Parking'],
        contact: '+63 951 789 0123',
        imageUrl:
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9',
      ),
      const BoardingHouse(
        id: 'bh_046',
        name: 'Rainbow Ridge Boarding',
        address: 'Toril, Davao City',
        pricePerNight: 630.0,
        amenities: ['WiFi', 'Shared Kitchen', 'CCTV', 'Laundry Area'],
        contact: '+63 962 890 1234',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
      ),
      const BoardingHouse(
        id: 'bh_047',
        name: 'Lotus Bloom Dormitory',
        address: 'Espana Boulevard, Manila',
        pricePerNight: 490.0,
        amenities: ['WiFi', 'Study Area', 'CCTV', 'Shared Kitchen'],
        contact: '+63 973 901 2345',
        imageUrl:
            'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3',
      ),
      const BoardingHouse(
        id: 'bh_048',
        name: 'Crescent Moon Inn',
        address: 'Tagaytay City, Cavite',
        pricePerNight: 950.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Parking',
          'Private CR',
        ],
        contact: '+63 984 012 3456',
        imageUrl:
            'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde',
      ),
      const BoardingHouse(
        id: 'bh_049',
        name: 'Magnolia Heights Residences',
        address: 'New Manila, Quezon City',
        pricePerNight: 1280.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Furnished Room',
          'Parking',
          'CCTV',
        ],
        contact: '+63 995 123 4567',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687644-c7171b42498b',
      ),
      const BoardingHouse(
        id: 'bh_050',
        name: 'Turtle Bay Transient',
        address: 'Bantayan Island, Cebu',
        pricePerNight: 870.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 906 234 5678',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154526-990dced4db0d',
      ),
      const BoardingHouse(
        id: 'bh_051',
        name: 'Sunflower Fields Boarding',
        address: 'Agdao, Davao City',
        pricePerNight: 560.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'Study Area'],
        contact: '+63 917 345 6790',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d',
      ),
      const BoardingHouse(
        id: 'bh_052',
        name: 'Diamond Crest Apartments',
        address: 'Banilad, Cebu City',
        pricePerNight: 1120.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'Furnished Room',
          'Balcony',
        ],
        contact: '+63 928 456 7891',
        imageUrl:
            'https://images.unsplash.com/photo-1600566752355-35792bedcfea',
      ),
      const BoardingHouse(
        id: 'bh_053',
        name: 'Cherry Blossom Inn',
        address: 'La Trinidad, Benguet',
        pricePerNight: 690.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'CCTV'],
        contact: '+63 939 567 8902',
        imageUrl:
            'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea',
      ),
      const BoardingHouse(
        id: 'bh_054',
        name: 'Wave Rider Lodging',
        address: 'Cloud 9, Siargao',
        pricePerNight: 1050.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Laundry Area',
        ],
        contact: '+63 940 678 9013',
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      ),
      const BoardingHouse(
        id: 'bh_055',
        name: 'Citrus Grove Residences',
        address: 'Calinan, Davao City',
        pricePerNight: 610.0,
        amenities: ['WiFi', 'Shared Kitchen', 'CCTV', 'Parking'],
        contact: '+63 951 789 0124',
        imageUrl:
            'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
      ),
      const BoardingHouse(
        id: 'bh_056',
        name: 'Emerald Coast Boarding',
        address: 'Nasugbu, Batangas',
        pricePerNight: 920.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 962 890 1235',
        imageUrl:
            'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
      ),
      const BoardingHouse(
        id: 'bh_057',
        name: 'Jasmine Garden Dormitory',
        address: 'Taft Avenue, Manila',
        pricePerNight: 480.0,
        amenities: ['WiFi', 'Study Area', 'Laundry Area', 'CCTV'],
        contact: '+63 973 901 2346',
        imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
      ),
      const BoardingHouse(
        id: 'bh_058',
        name: 'Amber Sunset Transient',
        address: 'Boracay Station 3',
        pricePerNight: 1180.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Furnished Room',
        ],
        contact: '+63 984 012 3457',
        imageUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
      ),
      const BoardingHouse(
        id: 'bh_059',
        name: 'Lakeside Haven Inn',
        address: 'Taal Vista, Tagaytay',
        pricePerNight: 1050.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'Balcony',
          'Private CR',
        ],
        contact: '+63 995 123 4568',
        imageUrl:
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
      ),
      const BoardingHouse(
        id: 'bh_060',
        name: 'Tropical Sunrise Apartments',
        address: 'Mabini, Batangas',
        pricePerNight: 840.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Laundry Area'],
        contact: '+63 906 234 5679',
        imageUrl:
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9',
      ),
      const BoardingHouse(
        id: 'bh_061',
        name: 'Ivy Leaf Boarding House',
        address: 'Marikina Heights',
        pricePerNight: 750.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Study Area', 'CCTV'],
        contact: '+63 917 345 6791',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
      ),
      const BoardingHouse(
        id: 'bh_062',
        name: 'Moonbeam Residences',
        address: 'Ecoland, Davao City',
        pricePerNight: 980.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'Furnished Room',
          'Private CR',
        ],
        contact: '+63 928 456 7892',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
      ),
      const BoardingHouse(
        id: 'bh_063',
        name: 'Pacific Breeze Lodging',
        address: 'Tibiao, Antique',
        pricePerNight: 680.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 939 567 8903',
        imageUrl: 'https images.unsplash.com/photo-1600566753190-17f0baa2a6c3',
      ),
      const BoardingHouse(
        id: 'bh_064',
        name: 'Rosewood Inn',
        address: 'Session Road, Baguio',
        pricePerNight: 820.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'Study Area'],
        contact: '+63 940 678 9014',
        imageUrl:
            'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde',
      ),
      const BoardingHouse(
        id: 'bh_065',
        name: 'Seagrass Bay Apartments',
        address: 'Samal Island, Davao',
        pricePerNight: 930.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Laundry Area',
        ],
        contact: '+63 951 789 0125',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687644-c7171b42498b',
      ),
      const BoardingHouse(
        id: 'bh_066',
        name: 'Golden Palm Dormitory',
        address: 'Katipunan Avenue, Quezon City',
        pricePerNight: 520.0,
        amenities: ['WiFi', 'Study Area', 'Laundry Area', 'CCTV'],
        contact: '+63 962 890 1236',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154526-990dced4db0d',
      ),
      const BoardingHouse(
        id: 'bh_067',
        name: 'Silverfish Transient',
        address: 'General Santos City',
        pricePerNight: 740.0,
        amenities: ['WiFi', 'Air Conditioning', 'Private CR', 'Parking'],
        contact: '+63 973 901 2347',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d',
      ),
      const BoardingHouse(
        id: 'bh_068',
        name: 'Clover Field Boarding',
        address: 'Tacloban City, Leyte',
        pricePerNight: 650.0,
        amenities: ['WiFi', 'Shared Kitchen', 'CCTV', 'Laundry Area'],
        contact: '+63 984 012 3458',
        imageUrl:
            'https://images.unsplash.com/photo-1600566752355-35792bedcfea',
      ),
      const BoardingHouse(
        id: 'bh_069',
        name: 'Aurora Heights Inn',
        address: 'Cubao, Quezon City',
        pricePerNight: 890.0,
        amenities: ['WiFi', 'Air Conditioning', 'Parking', 'Furnished Room'],
        contact: '+63 995 123 4569',
        imageUrl:
            'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea',
      ),
      const BoardingHouse(
        id: 'bh_070',
        name: 'Dolphin Cove Residences',
        address: 'Oslob, Cebu',
        pricePerNight: 980.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 906 234 5680',
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      ),
      const BoardingHouse(
        id: 'bh_071',
        name: 'Maple Tree Lodging',
        address: 'Bonifacio Global City, Taguig',
        pricePerNight: 1580.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'CCTV',
          'Furnished Room',
          'Study Area',
        ],
        contact: '+63 917 345 6792',
        imageUrl:
            'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
      ),
      const BoardingHouse(
        id: 'bh_072',
        name: 'Twilight Bay Apartments',
        address: 'Morong, Bataan',
        pricePerNight: 710.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 928 456 7893',
        imageUrl:
            'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
      ),
      const BoardingHouse(
        id: 'bh_073',
        name: 'Lavender Fields Boarding',
        address: 'UP Village, Quezon City',
        pricePerNight: 880.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Study Area', 'Parking'],
        contact: '+63 939 567 8904',
        imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
      ),
      const BoardingHouse(
        id: 'bh_074',
        name: 'Sunset Cove Inn',
        address: 'San Fernando, Pampanga',
        pricePerNight: 790.0,
        amenities: ['WiFi', 'Air Conditioning', 'Private CR', 'Laundry Area'],
        contact: '+63 940 678 9015',
        imageUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
      ),
      const BoardingHouse(
        id: 'bh_075',
        name: 'Crystal Waters Transient',
        address: 'Caramoan, Camarines Sur',
        pricePerNight: 860.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 951 789 0126',
        imageUrl:
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
      ),
      const BoardingHouse(
        id: 'bh_076',
        name: 'Palm Oasis Dormitory',
        address: 'FEU Manila',
        pricePerNight: 470.0,
        amenities: ['WiFi', 'Study Area', 'CCTV', 'Shared Kitchen'],
        contact: '+63 962 890 1237',
        imageUrl:
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9',
      ),
      const BoardingHouse(
        id: 'bh_077',
        name: 'Jade Mountain Residences',
        address: 'Busay, Cebu City',
        pricePerNight: 1020.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'Balcony',
          'Furnished Room',
        ],
        contact: '+63 973 901 2348',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
      ),
      const BoardingHouse(
        id: 'bh_078',
        name: 'Flamingo Bay Lodging',
        address: 'Malay, Aklan',
        pricePerNight: 1140.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Laundry Area',
        ],
        contact: '+63 984 012 3459',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
      ),
      const BoardingHouse(
        id: 'bh_079',
        name: 'Mist Valley Boarding',
        address: 'Camp John Hay, Baguio',
        pricePerNight: 950.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'Study Area', 'CCTV'],
        contact: '+63 995 123 4570',
        imageUrl:
            'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3',
      ),
      const BoardingHouse(
        id: 'bh_080',
        name: 'Sandcastle Inn',
        address: 'Pagudpud, Ilocos Norte',
        pricePerNight: 820.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 906 234 5681',
        imageUrl:
            'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde',
      ),
      const BoardingHouse(
        id: 'bh_081',
        name: 'Bamboo Valley Apartments',
        address: 'Tagum City, Davao del Norte',
        pricePerNight: 620.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'CCTV'],
        contact: '+63 917 345 6793',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687644-c7171b42498b',
      ),
      const BoardingHouse(
        id: 'bh_082',
        name: 'Crescent Bay Transient',
        address: 'Anilao, Batangas',
        pricePerNight: 890.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Laundry Area',
        ],
        contact: '+63 928 456 7894',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154526-990dced4db0d',
      ),
      const BoardingHouse(
        id: 'bh_083',
        name: 'Violet Garden Residences',
        address: 'Teachers Village, Quezon City',
        pricePerNight: 1150.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'Furnished Room',
          'Study Area',
        ],
        contact: '+63 939 567 8905',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d',
      ),
      const BoardingHouse(
        id: 'bh_084',
        name: 'Serenity Hills Boarding',
        address: 'Antipolo City, Rizal',
        pricePerNight: 780.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'Balcony'],
        contact: '+63 940 678 9016',
        imageUrl:
            'https://images.unsplash.com/photo-1600566752355-35792bedcfea',
      ),
      const BoardingHouse(
        id: 'bh_085',
        name: 'Hibiscus Cove Inn',
        address: 'Puerto Galera, Oriental Mindoro',
        pricePerNight: 1020.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 951 789 0127',
        imageUrl:
            'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea',
      ),
      const BoardingHouse(
        id: 'bh_086',
        name: 'Skyline View Dormitory',
        address: 'Araneta Center, Quezon City',
        pricePerNight: 550.0,
        amenities: ['WiFi', 'Study Area', 'CCTV', 'Laundry Area'],
        contact: '+63 962 890 1238',
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      ),
      const BoardingHouse(
        id: 'bh_087',
        name: 'Moonlit Shore Lodging',
        address: 'Camiguin Island',
        pricePerNight: 870.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Laundry Area',
        ],
        contact: '+63 973 901 2349',
        imageUrl:
            'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
      ),
      const BoardingHouse(
        id: 'bh_088',
        name: 'Sunrise Peak Apartments',
        address: 'Angeles City, Pampanga',
        pricePerNight: 920.0,
        amenities: ['WiFi', 'Air Conditioning', 'Parking', 'Furnished Room'],
        contact: '+63 984 012 3460',
        imageUrl:
            'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
      ),
      const BoardingHouse(
        id: 'bh_089',
        name: 'Coconut Bay Boarding',
        address: 'Baloy Beach, La Union',
        pricePerNight: 850.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 995 123 4571',
        imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
      ),
      const BoardingHouse(
        id: 'bh_090',
        name: 'Tropical Mist Inn',
        address: 'Los Banos, Laguna',
        pricePerNight: 690.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'Study Area'],
        contact: '+63 906 234 5682',
        imageUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
      ),
      const BoardingHouse(
        id: 'bh_091',
        name: 'Crimson Tide Transient',
        address: 'Moalboal, Cebu',
        pricePerNight: 960.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Laundry Area',
        ],
        contact: '+63 917 345 6794',
        imageUrl:
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
      ),
      const BoardingHouse(
        id: 'bh_092',
        name: 'Meadow View Residences',
        address: 'Nuvali, Santa Rosa, Laguna',
        pricePerNight: 1240.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Parking',
          'Furnished Room',
          'CCTV',
        ],
        contact: '+63 928 456 7895',
        imageUrl:
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9',
      ),
      const BoardingHouse(
        id: 'bh_093',
        name: 'Bluewave Dormitory',
        address: 'Recto Avenue, Manila',
        pricePerNight: 430.0,
        amenities: ['WiFi', 'Study Area', 'CCTV', 'Shared Kitchen'],
        contact: '+63 939 567 8906',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
      ),
      const BoardingHouse(
        id: 'bh_094',
        name: 'Paradise Reef Lodging',
        address: 'Apo Island, Negros Oriental',
        pricePerNight: 990.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 940 678 9017',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
      ),
      const BoardingHouse(
        id: 'bh_095',
        name: 'Cedar Grove Boarding',
        address: 'Brent School Area, Baguio',
        pricePerNight: 820.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'Study Area'],
        contact: '+63 951 789 0128',
        imageUrl:
            'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3',
      ),
      const BoardingHouse(
        id: 'bh_096',
        name: 'Starfish Cove Apartments',
        address: 'Hundred Islands, Pangasinan',
        pricePerNight: 880.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Laundry Area',
        ],
        contact: '+63 962 890 1239',
        imageUrl:
            'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde',
      ),
      const BoardingHouse(
        id: 'bh_097',
        name: 'Windmill Heights Inn',
        address: 'Pililla Wind Farm, Rizal',
        pricePerNight: 730.0,
        amenities: ['WiFi', 'Shared Kitchen', 'Parking', 'CCTV'],
        contact: '+63 973 901 2350',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687644-c7171b42498b',
      ),
      const BoardingHouse(
        id: 'bh_098',
        name: 'Harmony Bay Transient',
        address: 'Donsol, Sorsogon',
        pricePerNight: 810.0,
        amenities: ['WiFi', 'Air Conditioning', 'Balcony', 'Private CR'],
        contact: '+63 984 012 3461',
        imageUrl:
            'https://images.unsplash.com/photo-1600585154526-990dced4db0d',
      ),
      const BoardingHouse(
        id: 'bh_099',
        name: 'Silver Sands Residences',
        address: 'Malapascua Island, Cebu',
        pricePerNight: 1080.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Private CR',
          'Laundry Area',
        ],
        contact: '+63 995 123 4572',
        imageUrl:
            'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d',
      ),
      const BoardingHouse(
        id: 'bh_100',
        name: 'Tropical Dreams Boarding',
        address: 'Siargao Cloud 9',
        pricePerNight: 1190.0,
        amenities: [
          'WiFi',
          'Air Conditioning',
          'Balcony',
          'Furnished Room',
          'Private CR',
        ],
        contact: '+63 906 234 5683',
        imageUrl:
            'https://images.unsplash.com/photo-1600566752355-35792bedcfea',
      ),
    ];
  }
}
