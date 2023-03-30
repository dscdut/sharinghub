import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';

abstract class CampaignMock {
  static Future<CampaignModel> setCampaign(
    SetCampaignDTO setCampaignParams,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    return CampaignModel(
      name: 'Giúp mọi người quay lại cuốc sống bình thường',
      organizationId: 1,
      organizationName: 'Công ty TNHH ABC',
      description:
          'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 1)),
      registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
      donationRequirement: 'My Event and Smart Food',
      otherInformation: 'My Event and Smart Food',
      image:
          'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
      coordinate: {},
      address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
    );
  }

  static Future<List<CampaignModel>> getCampaigns() async {
    await Future.delayed(const Duration(seconds: 3));

    return [
      CampaignModel(
        id: 0,
        organizationId: 1,
        organizationName: 'Công ty TNHH ABC',

        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        donationRequirement: 'My Event and Smart Food',
        otherInformation: 'My Event and Smart Food',
        image: 'https://pbs.twimg.com/media/EC6sf2iWwAUyeM_.jpg',
        coordinate: {},
        address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
        // feedback: FeedbackToCampaignDTO(
        //   images: [
        //     'https://pbs.twimg.com/media/EC6sf2iWwAUyeM_.jpg',
        //     'https://pbs.twimg.com/media/EC6sf2iWwAUyeM_.jpg',
        //     'https://pbs.twimg.com/media/EC6sf2iWwAUyeM_.jpg',
        //   ],
        //   locationRate: 5,
        //   traffic: 'Đông',
        //   weather: 'Nắng',
        //   sanitization: 'Tốt',
        //   residence: 'Có',
        //   authorityCooperation: 'Tốt',
        //   others: 'Không có',
        // ),
      ),
      CampaignModel(
        id: 1,
        organizationId: 1,
        organizationName: 'Công ty TNHH ABC',
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        donationRequirement: 'My Event and Smart Food',
        otherInformation: 'My Event and Smart Food',
        image:
            'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
        coordinate: {},
        address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
      ),
      CampaignModel(
        id: 2,
        organizationId: 1,
        organizationName: 'Công ty TNHH ABC',
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        donationRequirement: 'My Event and Smart Food',
        otherInformation: 'My Event and Smart Food',
        image: 'https://pbs.twimg.com/media/EC6sf2iWwAUyeM_.jpg',
        coordinate: {},
        address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
      ),
      CampaignModel(
        id: 3,
        organizationId: 1,
        organizationName: 'Công ty TNHH ABC',
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        donationRequirement: 'My Event and Smart Food',
        otherInformation: 'My Event and Smart Food',
        image:
            'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
        coordinate: {},
        address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
      ),
      CampaignModel(
        id: 4,
        organizationId: 1,
        organizationName: 'Công ty TNHH ABC',
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        donationRequirement: 'My Event and Smart Food',
        otherInformation: 'My Event and Smart Food',
        image:
            'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
        coordinate: {},
        address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
      )
    ];
  }
}
