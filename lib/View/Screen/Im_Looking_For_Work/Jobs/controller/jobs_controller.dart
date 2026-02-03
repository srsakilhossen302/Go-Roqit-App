import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';

class JobsController extends GetxController {
  var jobList = <JobModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadJobs();
  }

  void loadJobs() {
    // Mock data matching the design
    jobList.addAll([
      JobModel(
        id: '1',
        title: 'Senior Hair Stylist',
        companyName: 'Glow Beauty Salon',
        location: 'Kensington, London',
        jobType: 'Full-time',
        salary: '£28,000 - £35,000/Hour',
        logoUrl:
            'https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80',
        postedTime: '2 day ago',
        workingHours: 'Tuesday - Saturday',
        workSystem: 'On-site',
        skills: [
          'Level 3 Diploma',
          '5+ years of',
          'Knowledge of current',
          'Advanced color and',
          'Excellent customer service',
        ],
        companyDescription:
            "We're looking for an experienced stylist to join our growing team in a luxury salon environment. You'll work with high-end clients and have access to ongoing training.\n\nProfessional salon environment with a focus on quality service and team development. We value our staff and provide ongoing training and career growth opportunities.",
        businessPhotos: [
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
          'https://images.unsplash.com/photo-1595476106812-c4058d8c289f?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
          'https://images.unsplash.com/photo-1595476106812-c4058d8c289f?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
        ],
        requirements: [
          'Level 3 Diploma in Hairdressing or equivalent',
          '5+ years of professional experience',
          'Advanced color and cutting skills',
          'Excellent customer service abilities',
          'Knowledge of current trends and techniques',
        ],
        benefits: [
          'Commission on retail',
          'Staff discount',
          'Training opportunities',
          'Pension scheme',
        ],
      ),
      JobModel(
        id: '2',
        title: 'Junior Hair Stylist',
        companyName: 'Urban Cuts',
        location: 'Camden, London',
        jobType: 'Full-time',
        salary: '£22,000 - £26,000/Year',
        logoUrl:
            'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?auto=format&fit=crop&w=200&q=80',
        postedTime: '1 day ago',
        workingHours: 'Monday - Friday',
        workSystem: 'On-site',
        skills: [
          'NVQ Level 2',
          'Basic cutting skills',
          'Blow-dry techniques',
          'Customer handling',
        ],
        companyDescription:
            'A friendly salon looking for a passionate junior stylist eager to grow.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: [
          'NVQ Level 2 or equivalent',
          '1–2 years experience',
          'Good communication skills',
        ],
        benefits: ['Staff discount', 'Training support'],
      ),

      JobModel(
        id: '3',
        title: 'Barber',
        companyName: 'Kings Barber Shop',
        location: 'Manchester, UK',
        jobType: 'Full-time',
        salary: '£25,000 - £30,000/Year',
        logoUrl:
            'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=200&q=80',
        postedTime: '3 days ago',
        workingHours: 'Monday - Saturday',
        workSystem: 'On-site',
        skills: ['Fade cutting', 'Beard styling', 'Clippers expertise'],
        companyDescription: 'Modern barbershop serving a loyal client base.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['2+ years barber experience', 'Strong styling skills'],
        benefits: ['Commission', 'Flexible shifts'],
      ),

      JobModel(
        id: '4',
        title: 'Hair Color Specialist',
        companyName: 'Luxe Hair Studio',
        location: 'Chelsea, London',
        jobType: 'Part-time',
        salary: '£30 - £45/Hour',
        logoUrl:
            'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=200&q=80',
        postedTime: '5 days ago',
        workingHours: 'Flexible',
        workSystem: 'On-site',
        skills: ['Balayage', 'Ombre', 'Color correction'],
        companyDescription:
            'High-end salon focusing on premium color services.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Color certification', '3+ years experience'],
        benefits: ['High hourly rate', 'Luxury clients'],
      ),

      JobModel(
        id: '5',
        title: 'Salon Manager',
        companyName: 'Elite Beauty Lounge',
        location: 'Birmingham, UK',
        jobType: 'Full-time',
        salary: '£35,000 - £45,000/Year',
        logoUrl:
            'https://images.unsplash.com/photo-1559599101-f09722fb4948?auto=format&fit=crop&w=200&q=80',
        postedTime: '1 week ago',
        workingHours: 'Tuesday - Saturday',
        workSystem: 'On-site',
        skills: ['Team management', 'Client relations', 'Scheduling'],
        companyDescription:
            'Seeking an experienced manager to lead a busy salon.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1559599101-f09722fb4948?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Management experience', 'Salon background'],
        benefits: ['Bonus', 'Paid leave'],
      ),

      JobModel(
        id: '6',
        title: 'Nail Technician',
        companyName: 'Polish & Glow',
        location: 'Leeds, UK',
        jobType: 'Full-time',
        salary: '£20,000 - £25,000/Year',
        logoUrl:
            'https://images.unsplash.com/photo-1600948836101-f9ffda59d250?auto=format&fit=crop&w=200&q=80',
        postedTime: '2 days ago',
        workingHours: 'Monday - Friday',
        workSystem: 'On-site',
        skills: ['Manicure', 'Pedicure', 'Gel nails'],
        companyDescription: 'Trendy nail salon with a young client base.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1600948836101-f9ffda59d250?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Certification required'],
        benefits: ['Tips', 'Staff discount'],
      ),

      JobModel(
        id: '7',
        title: 'Makeup Artist',
        companyName: 'Glam Studio',
        location: 'London, UK',
        jobType: 'Freelance',
        salary: '£200 - £400/Day',
        logoUrl:
            'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=200&q=80',
        postedTime: '4 days ago',
        workingHours: 'Event-based',
        workSystem: 'On-site',
        skills: ['Bridal makeup', 'Photoshoot makeup'],
        companyDescription:
            'Creative studio working on weddings and fashion shoots.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Portfolio required'],
        benefits: ['High daily pay'],
      ),

      JobModel(
        id: '8',
        title: 'Spa Therapist',
        companyName: 'Calm Retreat Spa',
        location: 'Bath, UK',
        jobType: 'Full-time',
        salary: '£24,000 - £28,000/Year',
        logoUrl:
            'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&w=200&q=80',
        postedTime: '6 days ago',
        workingHours: 'Rotational',
        workSystem: 'On-site',
        skills: ['Massage therapy', 'Facials'],
        companyDescription: 'Luxury spa focused on relaxation and wellness.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Therapy certification'],
        benefits: ['Free treatments'],
      ),

      JobModel(
        id: '9',
        title: 'Receptionist (Salon)',
        companyName: 'Style Hub',
        location: 'Oxford, UK',
        jobType: 'Part-time',
        salary: '£11 - £13/Hour',
        logoUrl:
            'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=200&q=80',
        postedTime: 'Today',
        workingHours: 'Flexible',
        workSystem: 'On-site',
        skills: ['Customer service', 'Booking management'],
        companyDescription: 'Front desk role in a busy salon.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Good communication'],
        benefits: ['Flexible hours'],
      ),

      JobModel(
        id: '10',
        title: 'Beauty Therapist',
        companyName: 'Pure Beauty Clinic',
        location: 'Reading, UK',
        jobType: 'Full-time',
        salary: '£26,000 - £32,000/Year',
        logoUrl:
            'https://images.unsplash.com/photo-1600948836451-3cfa7b5d24dd?auto=format&fit=crop&w=200&q=80',
        postedTime: '3 days ago',
        workingHours: 'Monday - Saturday',
        workSystem: 'On-site',
        skills: ['Skin treatments', 'Laser basics'],
        companyDescription: 'Clinic offering advanced beauty treatments.',
        businessPhotos: [
          'https://images.unsplash.com/photo-1600948836451-3cfa7b5d24dd?auto=format&fit=crop&w=400&q=80',
        ],
        requirements: ['Relevant certification', '2+ years experience'],
        benefits: ['Career growth'],
      ),
    ]);
  }
}
