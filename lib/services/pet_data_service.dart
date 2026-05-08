import '../core/constants/app_assets.dart';
import '../core/constants/app_routes.dart';
import '../models/category_item_model.dart';
import '../models/doctor_model.dart';
import '../models/service_model.dart';

class PetDataService {
  const PetDataService._();

  static const List<CategoryItemModel> categories = [
    CategoryItemModel(
      title: 'Veterinary',
      image: AppAssets.vetDoctor,
      route: AppRoutes.veterinary,
    ),
    CategoryItemModel(
      title: 'Grooming',
      image: AppAssets.grooming,
      route: AppRoutes.grooming,
    ),
    CategoryItemModel(
      title: 'Pet Store',
      image: AppAssets.shopPets,
      route: AppRoutes.shop,
    ),
    CategoryItemModel(
      title: 'Training',
      image: AppAssets.trainingDog,
      route: AppRoutes.training,
    ),
  ];

  static const List<ServiceModel> veterinaryServices = [
    ServiceModel(
      title: 'Vaccinations',
      subtitle: '12 000 ₸',
      image: AppAssets.vetDoctor,
      price: 12000,
    ),
    ServiceModel(
      title: 'Operations',
      subtitle: '85 000 ₸',
      image: AppAssets.doctorVernon,
      price: 85000,
    ),
    ServiceModel(
      title: 'Behaviorals',
      subtitle: '18 000 ₸',
      image: AppAssets.trainingDog,
      price: 18000,
    ),
    ServiceModel(
      title: 'Dentistry',
      subtitle: '25 000 ₸',
      image: AppAssets.doctorAnna,
      price: 25000,
    ),
  ];

  static const List<DoctorModel> doctors = [
    DoctorModel(
      name: 'Dr. Anna Jhonason',
      specialty: 'Veterinary Behavioral',
      image: AppAssets.doctorAnna,
      rating: 4.8,
      distance: '1 km',
      price: '25 000 ₸',
      experience: '11 years',
    ),
    DoctorModel(
      name: 'Dr. Vernon Chwe',
      specialty: 'Veterinary Surgery',
      image: AppAssets.doctorVernon,
      rating: 4.9,
      distance: '1.5 km',
      price: '28 000 ₸',
      experience: '9 years',
    ),
    DoctorModel(
      name: 'Dr. Maria Nai',
      specialty: 'Veterinary Dentist',
      image: AppAssets.doctorMaria,
      rating: 4.9,
      distance: '2.5 km',
      price: '23 000 ₸',
      experience: '8 years',
    ),
  ];

  static const List<ServiceModel> groomingServices = [
    ServiceModel(
      title: 'Bathing & Drying',
      subtitle: '9 000 ₸',
      image: AppAssets.bath,
      price: 9000,
    ),
    ServiceModel(
      title: 'Hair Triming',
      subtitle: '14 000 ₸',
      image: AppAssets.hair,
      price: 14000,
    ),
    ServiceModel(
      title: 'Nail Trimming',
      subtitle: '5 000 ₸',
      image: AppAssets.nail,
      price: 5000,
    ),
    ServiceModel(
      title: 'Ear Cleaning',
      subtitle: '4 500 ₸',
      image: AppAssets.ear,
      price: 4500,
    ),
    ServiceModel(
      title: 'Dental Brushing',
      subtitle: '7 500 ₸',
      image: AppAssets.grooming,
      price: 7500,
    ),
    ServiceModel(
      title: 'Spa Treatment',
      subtitle: '18 000 ₸',
      image: AppAssets.shopPets,
      price: 18000,
    ),
  ];

  static const List<ServiceModel> shopItems = [
    ServiceModel(title: 'Pets', image: AppAssets.shopPets),
    ServiceModel(title: 'Foods', image: AppAssets.food),
    ServiceModel(title: 'Healthy', image: AppAssets.healthy),
    ServiceModel(title: 'Toys', image: AppAssets.toys),
    ServiceModel(title: 'Accessories', image: AppAssets.accessories),
    ServiceModel(title: 'Clothes', image: AppAssets.clothes),
  ];

  static const List<ServiceModel> courses = [
    ServiceModel(
      title: 'Obedience Courses',
      subtitle: 'By Jhon Smith',
      image: AppAssets.course1,
    ),
    ServiceModel(
      title: 'Specialty Classes & Workshops',
      subtitle: 'By Duke Fuzzington',
      image: AppAssets.course2,
    ),
    ServiceModel(
      title: 'Puppy Kindergarten and Playgroups',
      subtitle: 'By Sir Fluffington',
      image: AppAssets.course3,
    ),
    ServiceModel(
      title: 'Canine Good Citizen Test',
      subtitle: 'By Baron Fuzzypaws',
      image: AppAssets.course4,
    ),
    ServiceModel(
      title: 'Theraphy Dogs',
      subtitle: 'By Duke Fuzzington',
      image: AppAssets.trainingDog,
    ),
  ];
}
