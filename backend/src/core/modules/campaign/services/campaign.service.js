import { getTransaction } from 'core/database';
import { logger } from 'core/utils';
import { InternalServerException, NotFoundException } from 'packages/httpException';
import { MESSAGE } from './message.enum';
import { CampaignRepository } from '../campaign.repository';
import { FileSystemService, MediaService } from 'core/modules/document';

class Service {
    constructor() {
        this.repository = CampaignRepository;
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

        try {
            const data = {
                ...createCampaignDto,
                organization_id,
                coordinate: {
                    lat: parseFloat(createCampaignDto.coordinate.lat),
                    lng: parseFloat(createCampaignDto.coordinate.lng),
                }
            };

            const createdCampaign = await this.repository.insert(data);

            if (file) {
                await this.updateOne(organization_id, createdCampaign[0].id, data, file);
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
            throw new InternalServerException(
                'Start date and end date must be after today',
            );
        }

        try {
            const url = file ? (await this.MediaService.uploadOne(file, `organizations/${organization_id}/campaigns/${campaign_id}`, 'image', true)).url : null;

            const updatedCampaign = await this.repository.updateOne(
                campaign_id,
                {
                    ...createCampaignDto,
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

    async getAllCoordinates() {
        try {
            return this.repository.getAllCoordinates();
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }
}

export const CampaignService = new Service();
