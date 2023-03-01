import 'package:mobile/data/models/address.model.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/datasources/user.mock.dart';

abstract class CampaignMock {
  static CampaignModel setCampaign(CampaignModel params) {
    return CampaignModel(
      organizationId: UserMock.getUserInfo(),
      name: 'Giúp mọi người quay lại cuốc sống bình thường',
      description:
          'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      address: AddressModel(
        province: 'Da Nang',
        district: 'Lien Chieu',
        ward: 'Hoa Khanh Bac',
        specificAddress: '193 Nguyen Luong Bang',
      ),
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 1)),
      registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
      haveArtifactDonate: true,
      artifactRequirement: 'My Event and Smart Food',
      otherInfo: 'My Event and Smart Food',
      imageURL:
          'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
    );
  }

  static List<CampaignModel> getCampains() {
    return [
      CampaignModel(
        organizationId: UserMock.getUserInfo(),
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        address: AddressModel(
          province: 'Da Nang',
          district: 'Lien Chieu',
          ward: 'Hoa Khanh Bac',
          specificAddress: '193 Nguyen Luong Bang',
        ),
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        haveArtifactDonate: true,
        artifactRequirement: 'My Event and Smart Food',
        otherInfo: 'My Event and Smart Food',
        imageURL: 'https://pbs.twimg.com/media/EC6sf2iWwAUyeM_.jpg',
      ),
      CampaignModel(
        organizationId: UserMock.getUserInfo(),
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        address: AddressModel(
          province: 'Da Nang',
          district: 'Lien Chieu',
          ward: 'Hoa Khanh Bac',
          specificAddress: '193 Nguyen Luong Bang',
        ),
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        haveArtifactDonate: true,
        artifactRequirement: 'My Event and Smart Food',
        otherInfo: 'My Event and Smart Food',
        imageURL:
            'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
      ),
      CampaignModel(
        organizationId: UserMock.getUserInfo(),
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        address: AddressModel(
          province: 'Da Nang',
          district: 'Lien Chieu',
          ward: 'Hoa Khanh Bac',
          specificAddress: '193 Nguyen Luong Bang',
        ),
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        haveArtifactDonate: true,
        artifactRequirement: 'My Event and Smart Food',
        otherInfo: 'My Event and Smart Food',
        imageURL: 'https://pbs.twimg.com/media/EC6sf2iWwAUyeM_.jpg',
      ),
      CampaignModel(
        organizationId: UserMock.getUserInfo(),
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        address: AddressModel(
          province: 'Da Nang',
          district: 'Lien Chieu',
          ward: 'Hoa Khanh Bac',
          specificAddress: '193 Nguyen Luong Bang',
        ),
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        haveArtifactDonate: true,
        artifactRequirement: 'My Event and Smart Food',
        otherInfo: 'My Event and Smart Food',
        imageURL:
            'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
      ),
      CampaignModel(
        organizationId: UserMock.getUserInfo(),
        name: 'Giúp mọi người quay lại cuốc sống bình thường',
        description:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        address: AddressModel(
          province: 'Da Nang',
          district: 'Lien Chieu',
          ward: 'Hoa Khanh Bac',
          specificAddress: '193 Nguyen Luong Bang',
        ),
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        registerLink: 'https://forms.gle/S1M2A3R4T5F6O7O8D9',
        haveArtifactDonate: true,
        artifactRequirement: 'My Event and Smart Food',
        otherInfo: 'My Event and Smart Food',
        imageURL:
            'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
      )
    ];
  }
}
