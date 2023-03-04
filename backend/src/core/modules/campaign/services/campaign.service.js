import { getTransaction } from 'core/database';
import { logger } from 'core/utils';
import { InternalServerException } from 'packages/httpException';
import { MESSAGE } from './message.enum';
import { CampaignRepository } from '../campaign.repository';

class Service {
    constructor() {
        this.repository = CampaignRepository;
    }

    async createOne(createCampaignDto) {
        const trx = await getTransaction();

        // check if start date is before end date
        if (
            new Date(createCampaignDto.start_date)
      > new Date(createCampaignDto.end_date)
        ) {
            throw new InternalServerException('Start date must be before end date');
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
            createdCampaign = await this.repository.insert(createCampaignDto, trx);
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
}

export const CampaignService = new Service();
