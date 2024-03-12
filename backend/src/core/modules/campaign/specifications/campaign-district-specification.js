import { Specification } from 'core/common/specifications';

export class CampaignDistrictSpecification extends Specification {
    #district;
    
    constructor(district) {
        super();
        this.#district = district;
    }

    toSql() {
        return ['campaigns.district = ?', this.#district];
    }
}
