import { Specification } from 'core/common/specifications';

export class CampaignWardSpecification extends Specification {
    #ward;
    
    constructor(ward) {
        super();
        this.#ward = ward;
    }

    toSql() {
        return ['campaigns.ward = ?', this.#ward];
    }
}
