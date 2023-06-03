import { BcryptService } from 'core/modules/auth';
import { getTransaction } from 'core/database';
import { UserRoleRepository } from 'core/modules/role/userRole.repository';
import { Optional } from '../../../utils';
import { NotFoundException, DuplicateException, BadRequestException } from '../../../../packages/httpException';
import { UserRepository } from '../user.repository';
import { MESSAGE } from './message.enum';
import { CampaignRepository } from '../../../modules/campaign/campaign.repository';
import { DonationRecordRepository } from 'core/modules/donation/donation-record.repository';
class Service {
    constructor() {
        this.repository = UserRepository;
        this.userRoleRepository = UserRoleRepository;
        this.campaignRepository = CampaignRepository;
        this.bcryptService = BcryptService;
        this.donationRecordRepository = DonationRecordRepository;
    }

    async createOne(createUserDto) {
        const trx = await getTransaction();
        Optional.of(await this.repository.findByEmail(createUserDto.email)).throwIfPresent(new DuplicateException('Email is being used'));

        if (createUserDto.password !== createUserDto.confirm_password) {
            throw new BadRequestException('Password does not match');
        }
        createUserDto.password = this.bcryptService.hash(createUserDto.password);

        let createdUser;
        try {
            delete createUserDto.confirm_password;
            createdUser = await this.repository.insert(createUserDto, trx);
            const ROLE_USER_ID = 3;
            await this.userRoleRepository.createUserRole(createdUser[0].id, ROLE_USER_ID, trx);
        } catch (error) {
            await trx.rollback();
            this.logger.error(error.message);
            return null;
        }
        trx.commit();
        return createdUser[0];
    }

    async findById(id) {
        const data = Optional.of(await this.repository.findById(id))
            .throwIfNotPresent(new NotFoundException())
            .get();

        const pendingVoluntaryCampaigns = await this.campaignRepository.findPendingVoluntaryCampaignsByUserId(id);

        const pendingDonativeCampaigns = await this.campaignRepository.findPendingDonativeCampaignsByUserId(id);

        const ongoingVoluntaryCampaignsByUserId = await this.campaignRepository.findParticipatedOngoingVoluntaryCampaignsByUserId(id);
        
        const ongoingDonativeCampaignsByUserId = await this.campaignRepository.findParticipatedOngoingDonativeCampaignsByUserId(id);

        const endedVoluntaryCampaignByUserId = await this.campaignRepository.findParticipatedEndedVoluntaryCampaignsByUserId(id);
        
        const endedDonativeCampaignByUserId = await this.campaignRepository.findParticipatedEndedDonativeCampaignsByUserId(id);

        const totalPendingCampaigns = pendingVoluntaryCampaigns.length + pendingDonativeCampaigns.length;

        const totalOngoingCampaigns = ongoingVoluntaryCampaignsByUserId.length + ongoingDonativeCampaignsByUserId.length;

        const totalFeedbacks = endedVoluntaryCampaignByUserId.filter(campaign => campaign.rate != null).length + endedDonativeCampaignByUserId.filter(campaign => campaign.rate != null).length;
        
        return {
            data,
            totalPendingCampaigns,
            totalOngoingCampaigns,
            totalFeedbacks
        };
    }

    async upsertOne(UpdateUserDto, id) {
        const trx = await getTransaction();
        const user = await this.repository.findById(id);
        if (!user) {
            throw new NotFoundException();
        }

        let data;
        try {
            data = await this.repository.updateUser(id, UpdateUserDto, trx);
        } catch (error) {
            await trx.rollback();
            this.logger.error(error.message);
            return null;
        }

        trx.commit();
        return {
            message: MESSAGE.UPDATE_USER_SUCCESS,
            user: data[0],
        };
    }

    async findVoluntaryCampaignsByUserId(id) {
        const data = await this.campaignRepository.findVoluntaryCampaignsByUserId(id);
        return data;
    }

    async findAllUserNoOrg() {
        return {
            data: {
                user: await this.repository.findAllUserNoOrg()
            }
        }
    }

    async findAllDonationsByUserId(id) {
        const data = await this.donationRecordRepository.findAllDonationsByUserId(id);
        return data;
    }
}

export const UserService = new Service();