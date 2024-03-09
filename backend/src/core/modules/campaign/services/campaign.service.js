import { getTransaction } from 'core/database';
import { logger } from 'core/utils';
import { InternalServerException, NotFoundException, DuplicateException, BadRequestException } from 'packages/httpException';
import { Optional } from 'core/utils';
import { MESSAGE } from './message.enum';
import { CampaignRepository } from '../campaign.repository';
import { UserCampaignRepository } from '../../user_campaign/user_campaign.repository';
import { Status } from '../../../common/enum';
import { UserRepository } from '../../../modules/user/user.repository';
import { FileSystemService, MediaService } from 'core/modules/document';

class Service {
    constructor() {
        this.repository = CampaignRepository;
        this.userRepository = UserRepository
        this.userCampaignRepository = UserCampaignRepository
        this.FileSystemService = FileSystemService;
        this.MediaService = MediaService;
    }

    async findOneById(id) {
        try {
            return this.repository.findOneById(id);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }

    }

    async findAllByOrgId(organization_id) {
        try {
            return this.repository.findAllByOrgId(organization_id);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findOneByOrgIdAndCampaignId(organization_id, campaign_id) {
        try {
            return this.repository.findOneByOrgIdAndCampaignId(
                organization_id,
                campaign_id,
            );
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async deleteFile(file) {
        try {
            if (file) {
                await this.FileSystemService.deleteFile(file);
            }
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async createOne(createCampaignDto, organization_id, file) {
        // check if start date is before end date
        if (
            new Date(createCampaignDto.start_date)
            > new Date(createCampaignDto.end_date)
        ) {
            throw new BadRequestException(
                'Start date must be before end date',
            );
        }

        // check if start date and end date is before today
        if (
            new Date(createCampaignDto.start_date) < new Date()
            || new Date(createCampaignDto.end_date) < new Date()
        ) {
            throw new BadRequestException(
                'Start date and end date must be after today',
            );
        }

        try {
            const campaignModel = {
                name: createCampaignDto.name,
                specific_address: createCampaignDto.specific_address,
                description: createCampaignDto.description,
                start_date: createCampaignDto.start_date,
                end_date: createCampaignDto.end_date,
                register_link: createCampaignDto.register_link,
                donation_requirement: createCampaignDto.donation_requirement,
                ward: createCampaignDto.location.ward,
                district: createCampaignDto.location.district,
                city: createCampaignDto.location.city,
                address: `${createCampaignDto.location.ward}, ${createCampaignDto.location.district}, ${createCampaignDto.location.city}`,
                organization_id,
                coordinate: {
                    lat: parseFloat(createCampaignDto.coordinate.lat),
                    lng: parseFloat(createCampaignDto.coordinate.lng),
                }
            };

            const createdCampaign = await this.repository.insert(campaignModel);

            if (file) {
                await this.updateOne(organization_id, createdCampaign[0].id, campaignModel, file);
            }

            return {
                message: MESSAGE.CREATE_CAMPAIGN_SUCCESS,
                id: createdCampaign[0].id,
            };
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async updateOne(organization_id, campaign_id, createCampaignDto, file) {
        const trx = await getTransaction();

        // check if campaign exist
        const campaign = await this.findOneByOrgIdAndCampaignId(
            organization_id,
            campaign_id,
        );

        if (!campaign) {
            throw new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND);
        }

        // check if start date is before end date
        if (
            new Date(createCampaignDto.start_date) >
            new Date(createCampaignDto.end_date)
        ) {
            throw new InternalServerException(
                'Start date must be before end date',
            );
        }

        // check if start date and end date is before today
        if (
            new Date(createCampaignDto.start_date) < new Date() ||
            new Date(createCampaignDto.end_date) < new Date()
        ) {
            throw new BadRequestException(
                'Start date and end date must be after today',
            );
        }

        try {
            const url = file ? (await this.MediaService.uploadOne(file, `organizations/${organization_id}/campaigns/${campaign_id}`, 'image', true)).url : null;

            const updatedCampaign = await this.repository.updateOne(
                campaign_id,
                {
                    name: createCampaignDto.name,
                    specific_address: createCampaignDto.specific_address,
                    description: createCampaignDto.description,
                    start_date: createCampaignDto.start_date,
                    end_date: createCampaignDto.end_date,
                    register_link: createCampaignDto.register_link,
                    donation_requirement: createCampaignDto.donation_requirement,
                    ward: createCampaignDto.location.ward,
                    district: createCampaignDto.location.district,
                    city: createCampaignDto.location.city,
                    address: `${createCampaignDto.location.ward}, ${createCampaignDto.location.district}, ${createCampaignDto.location.city}`,
                    image: url,
                    coordinate: {
                        lat: parseFloat(createCampaignDto.coordinate.lat),
                        lng: parseFloat(createCampaignDto.coordinate.lng),
                    }
                },
                trx,
            );

            trx.commit();
            return {
                message: MESSAGE.UPDATE_CAMPAIGN_SUCCESS,
                id: updatedCampaign[0],
            };
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async deleteOne(organization_id, campaign_id) {
        const trx = await getTransaction();

        // check if campaign exist
        const campaign = await this.findOneByOrgIdAndCampaignId(
            organization_id,
            campaign_id,
        );

        if (!campaign) {
            throw new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND);
        }

        try {
            await this.repository.hardDeleteOne(
                campaign_id,
                trx,
            );
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }

        trx.commit();

        return {
            message: MESSAGE.DELETE_CAMPAIGN_SUCCESS,
        }
    }

    async searchByName(name) {
        try {
            return this.repository.searchByName(name);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async searchByCoordinate(lng, lat) {
        try {
            return this.repository.searchByCoordinate(lng, lat);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findAllCampaigns() {
        try {
            return this.repository.findAllCampaigns();
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async registerVolunteer(campaign_id, user_id) {
        const trx = await getTransaction();

        const campaign = await this.findOneById(campaign_id);
        // check if campaign exist
        if (!campaign) {
            throw new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND_BY_CLIENT);
        }

        // check if campaign_id is already registered by user_id
        Optional.of(await this.userCampaignRepository.findOneByCampaignIdAndVolunteerId(
            campaign_id,
            user_id,
        ))
            .throwIfPresent(new DuplicateException(MESSAGE.VOLUNTEER_ALREADY_REGISTERED));

        // check if current date is before start date
        if (new Date() > new Date(campaign.startDate)) {
            throw new BadRequestException(MESSAGE.CAMPAIGN_TIME_INAPPROPRIATE);
        }

        try {
            await this.userCampaignRepository.registerVolunteer(
                campaign_id,
                user_id,
                trx,
            );
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }

        trx.commit();
        return {
            message: MESSAGE.REGISTER_VOLUNTEER_SUCCESS,
        };
    }

    async getAllVolunteersByOrgIdAndCampaignId(organization_id, campaign_id, status) {
        // check if campaign exist
        Optional.of(await this.findOneByOrgIdAndCampaignId(organization_id, campaign_id))
            .throwIfNotPresent(new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND));

        let data;
        try {
            data = await this.userCampaignRepository.getAllVolunteersByCampaignId(campaign_id, status);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }

        return data;
    }

    async updateVolunteerStatus(organization_id, campaign_id, user_id, updateUserStatusDto) {
        // check if campaign exist
        Optional.of(await this.findOneByOrgIdAndCampaignId(organization_id, campaign_id))
            .throwIfNotPresent(new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND));

        const volunteer = await this.userCampaignRepository.findOneByCampaignIdAndVolunteerId(
            campaign_id,
            user_id,
        );

        // check if user_id is registered in campaign_id
        Optional.of(volunteer)
            .throwIfNotPresent(new NotFoundException(MESSAGE.VOLUNTEER_NOT_FOUND));

        const trx = await getTransaction();

        let updatedVolunteer;
        try {
            await this.userCampaignRepository.updateVolunteerStatus(
                campaign_id,
                user_id,
                updateUserStatusDto,
                trx,
            );

            updatedVolunteer = await this.userCampaignRepository.findOneByCampaignIdAndVolunteerId(
                campaign_id,
                user_id,
            );
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }

        trx.commit();
        return {
            message: MESSAGE.UPDATE_VOLUNTEER_STATUS_SUCCESS,
            user: updatedVolunteer,
        };
    }

    async setPendingVolunteersStatusToRejected(organization_id, campaign_id) {
        // check if campaign exist
        Optional.of(await this.findOneByOrgIdAndCampaignId(organization_id, campaign_id))
            .throwIfNotPresent(new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND));

        const user_ids = await this.userCampaignRepository.getAllVolunteersByCampaignId(campaign_id, Status.PENDING).pluck('id');

        const trx = await getTransaction();

        try {
            await Promise.all(user_ids.map(async (user_id) => {
                await this.userCampaignRepository.updateVolunteerStatus(
                    campaign_id,
                    user_id,
                    { status: Status.REJECTED },
                    trx,
                );
            }));

        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }

        trx.commit();
        return {
            message: MESSAGE.SET_PENDING_VOLUNTEERS_STATUS_TO_REJECTED_SUCCESS,
            organizationId: organization_id,
            campaignId: campaign_id,
        }
    }

    async getAllCoordinates() {
        try {
            return this.repository.getAllCoordinates();
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    removeNameConstraint() {
        try {
            return this.repository.removeNameConstraint();
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }
};

export const CampaignService = new Service();
