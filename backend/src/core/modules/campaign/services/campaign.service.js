import { getTransaction } from 'core/database';
import { logger } from 'core/utils';
import { InternalServerException, NotFoundException, DuplicateException } from 'packages/httpException';
import { Optional } from 'core/utils';
import { MESSAGE } from './message.enum';
import { CampaignRepository } from '../campaign.repository';
import { UserCampaignRepository } from '../../user_campaign/user_campaign.repository';
import { Status } from '../../../common/enum';

class Service {
    constructor() {
        this.repository = CampaignRepository;
        this.userCampaignRepository = UserCampaignRepository
    }

    async findOneById(id) {
        let campaign;
        try {
            campaign = await this.repository.findOneById(id);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }

        return campaign;
    }

    async findAllByOrgId(organization_id) {
        let campaigns;
        try {
            campaigns = await this.repository.findAllByOrgId(organization_id);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }

        return campaigns;
    }

    async findOneByOrgIdAndCampaignId(organization_id, campaign_id) {
        let campaign;
        try {
            campaign = await this.repository.findOneByOrgIdAndCampaignId(
                organization_id,
                campaign_id,
            );
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }

        return campaign;
    }

    async createOne(createCampaignDto, organization_id) {
        const trx = await getTransaction();

        // check if start date is before end date
        if (
            new Date(createCampaignDto.start_date)
            > new Date(createCampaignDto.end_date)
        ) {
            throw new InternalServerException(
                'Start date must be before end date',
            );
        }

        // check if start date and end date is before today
        if (
            new Date(createCampaignDto.start_date) < new Date()
            || new Date(createCampaignDto.end_date) < new Date()
        ) {
            throw new InternalServerException(
                'Start date and end date must be after today',
            );
        }

        let createdCampaign;
        try {
            const data = { ...createCampaignDto, organization_id };

            createdCampaign = await this.repository.insert(data, trx);
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }

        trx.commit();
        return {
            message: MESSAGE.CREATE_CAMPAIGN_SUCCESS,
            id: createdCampaign[0].id,
        };
    }

    async updateOne(organization_id, campaign_id, createCampaignDto) {
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
            throw new InternalServerException(
                'Start date and end date must be after today',
            );
        }


        let data = { ...campaign, ...createCampaignDto };
        let updatedCampaign;
        try {
            updatedCampaign = await this.repository.updateOne(
                campaign_id,
                data,
                trx,
            );

        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }

        trx.commit();
        return {
            message: MESSAGE.UPDATE_CAMPAIGN_SUCCESS,
            id: updatedCampaign[0].id,
        };
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
    }

    async searchByName(name) {
        let campaigns;
        try {
            campaigns = await this.repository.searchByName(name);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }

        return campaigns;
    }

    async searchByCoordinate(lng, lat) {
        let campaigns;
        try {
            campaigns = await this.repository.searchByCoordinate(lng, lat);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }

        return campaigns;
    }

    async registerVolunteer(campaign_id, user_id) {
        const trx = await getTransaction();

        // check if campaign exist
        Optional.of(await this.findOneById(campaign_id))
            .throwIfNotPresent(new NotFoundException(MESSAGE.CAMPAIGN_NOT_FOUND_BY_CLIENT));

        // check if campaign_id is already registered by user_id
        Optional.of(await this.userCampaignRepository.findOneByCampaignIdAndVolunteerId(
            campaign_id,
            user_id,
        ))
            .throwIfPresent(new DuplicateException(MESSAGE.VOLUNTEER_ALREADY_REGISTERED));


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

        let data = { ...volunteer, ...updateUserStatusDto };
        try {
            await this.userCampaignRepository.updateVolunteerStatus(
                campaign_id,
                user_id,
                data,
                trx,
            );

        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }

        trx.commit();
        return {
            message: MESSAGE.UPDATE_VOLUNTEER_STATUS_SUCCESS,
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
        };
    }
}

export const CampaignService = new Service();
