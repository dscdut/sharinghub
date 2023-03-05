import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/datasources/user.mock.dart';

abstract class CampaignMock {
  static CampaignModel setCampaign(SetCampaignDTO setCampaignParams) {
    return CampaignModel(
      organization: UserMock.getOrganization(),
      name: 'Giúp mọi người quay lại cuốc sống bình thường',
      description:
          'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 1)),
      formLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
      artifactTypes: 'My Event and Smart Food',
      otherInformation: 'My Event and Smart Food',
      imageURL:
          'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
      geometry: {},
      address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
    );
  }

  static List<CampaignModel> getCampains() {
    return [
      CampaignModel(
        id: 0,
        organization: UserMock.getOrganization(),
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        formLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        artifactTypes: 'My Event and Smart Food',
        otherInformation: 'My Event and Smart Food',
        imageURL: 'https://pbs.twimg.com/media/EC6sf2iWwAUyeM_.jpg',
        geometry: {},
        address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
      ),
      CampaignModel(
        id: 1,
        organization: UserMock.getOrganization(),
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        formLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        artifactTypes: 'My Event and Smart Food',
        otherInformation: 'My Event and Smart Food',
        imageURL:
            'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
        geometry: {},
        address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
      ),
      CampaignModel(
        id: 2,
        organization: UserMock.getOrganization(),
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        formLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        artifactTypes: 'My Event and Smart Food',
        otherInformation: 'My Event and Smart Food',
        imageURL: 'https://pbs.twimg.com/media/EC6sf2iWwAUyeM_.jpg',
        geometry: {},
        address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
      ),
      CampaignModel(
        id: 3,
        organization: UserMock.getOrganization(),
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        formLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        artifactTypes: 'My Event and Smart Food',
        otherInformation: 'My Event and Smart Food',
        imageURL:
            'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
        geometry: {},
        address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
      ),
      CampaignModel(
        id: 4,
        organization: UserMock.getOrganization(),
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        formLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        artifactTypes: 'My Event and Smart Food',
        otherInformation: 'My Event and Smart Food',
        imageURL:
            'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
        geometry: {},
        address: 'Hải Châu 1, Hải Châu, Đà Nẵng',
      )
    ];
  }
}
