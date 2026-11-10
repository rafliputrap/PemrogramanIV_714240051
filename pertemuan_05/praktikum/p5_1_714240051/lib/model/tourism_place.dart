class TourismPlace {
  String name;
  String location;
  String description;
  String openDays;
  String openTime;
  String ticketPrice;
  String imageAsset;
  List<String> imageUrls;

  TourismPlace({
    required this.name,
    required this.location,
    required this.description,
    required this.openDays,
    required this.openTime,
    required this.ticketPrice,
    required this.imageAsset,
    required this.imageUrls,
  });
}

var tourismPlaceList = [
  TourismPlace(
    name: 'Farm House Lembang',
    location: 'Lembang',
    description:
        'Berada di jalur utama Bandung-Lembang, Farm House menjadi objek wisata yang tidak pernah sepi pengunjung. Selain karena letaknya strategis, kawasan ini juga menghadirkan nuansa khas Eropa.',
    openDays: 'Open Everyday',
    openTime: '09:00 - 20:00',
    ticketPrice: 'Rp 25.000',
    imageAsset: 'images/farm-house.jpg',
    imageUrls: [
      'https://cdn.idntimes.com/content-images/post/20201106/19437160-453398458365585-5644189604204838912-n-f90373e1c6e186e88536f9a0c7ce38dc.jpg',
      'https://cdn.idntimes.com/content-images/post/20201106/34091980-2204188269801480-248274445720879104-n-b41315fc572fa82496d5e0a0d9b5c3b8.jpg',
      'https://cdn.idntimes.com/content-images/post/20201106/39488216-228473327819821-1612494975352788928-n-b41315fc572fa82496d5e0a0d9b5c3b8.jpg',
    ],
  ),
  TourismPlace(
    name: 'Observatorium Bosscha',
    location: 'Lembang',
    description:
        'Memiliki beberapa teleskop, antara lain, Refraktor Ganda Zeiss, Schmidt Bimasakti, Refraktor Bamberg, Cassegrain GOTO, dan Teleskop Surya. Refraktor Ganda Zeiss adalah jenis teleskop terbesar untuk meneropong bintang.',
    openDays: 'Open Tuesday - Saturday',
    openTime: '09:00 - 14:30',
    ticketPrice: 'Rp 20.000',
    imageAsset: 'images/bosscha.jpg',
    imageUrls: [
      'https://www.rancaupas.id/wp-content/uploads/2022/09/DSC05254-2-1024x683.jpg',
      'https://www.rancaupas.id/wp-content/uploads/2023/08/Ranca-Upas-Igloo-Camp-Ciwidey.jpg',
      'https://awsimages.detik.net.id/community/media/visual/2020/11/11/ranca-upas_169.jpeg?w=1200',
    ],
  ),
  TourismPlace(
    name: 'Jalan Asia Afrika',
    location: 'Kota Bandung',
    description:
        'Jalan Asia Afrika memegang peranan penting bagi sejarah Kota Bandung, bahkan Indonesia. Di jalan inilah Konferensi Asia-Afrika pertama kali diselenggarakan pada tahun 1955.',
    openDays: 'Open Everyday',
    openTime: '24 Hours',
    ticketPrice: 'Free',
    imageAsset: 'images/asia-afrika.jpg',
    imageUrls: [
      'https://cdn.idntimes.com/content-images/post/20201106/19437160-453398458365585-5644189604204838912-n-f90373e1c6e186e88536f9a0c7ce38dc.jpg',
      'https://cdn.idntimes.com/content-images/post/20201106/34091980-2204188269801480-248274445720879104-n-b41315fc572fa82496d5e0a0d9b5c3b8.jpg',
    ],
  ),
  TourismPlace(
    name: 'Kawah Putih',
    location: 'Ciwidey',
    description:
        'Kawah Putih adalah tempat wisata di Bandung yang paling terkenal. Berlokasi di Ciwidey, Jawa Barat, kurang lebih sekitar 50 KM arah selatan kota Bandung.',
    openDays: 'Open Everyday',
    openTime: '07:00 - 17:00',
    ticketPrice: 'Rp 15.000',
    imageAsset: 'images/kawah-putih.jpg',
    imageUrls: [
      'https://www.rancaupas.id/wp-content/uploads/2022/09/DSC05254-2-1024x683.jpg',
      'https://awsimages.detik.net.id/community/media/visual/2020/11/11/ranca-upas_169.jpeg?w=1200',
    ],
  ),
  TourismPlace(
    name: 'Ranca Upas',
    location: 'Ciwidey',
    description:
        'Ranca Upas Ciwidey adalah kawasan bumi perkemahan di bawah pengelolaan perhutani. Tempat ini berada di kawasan wisata Bandung Selatan, satu lokasi dengan kawah putih, kolam Cimanggu dan situ Patenggang.',
    openDays: 'Open Everyday',
    openTime: '09:00 - 20:00',
    ticketPrice: 'Rp 20.000',
    imageAsset: 'images/ranca-upas.jpg',
    imageUrls: [
      'https://www.rancaupas.id/wp-content/uploads/2022/09/DSC05254-2-1024x683.jpg',
      'https://www.rancaupas.id/wp-content/uploads/2023/08/Ranca-Upas-Igloo-Camp-Ciwidey.jpg',
      'https://awsimages.detik.net.id/community/media/visual/2020/11/11/ranca-upas_169.jpeg?w=1200',
    ],
  ),
];