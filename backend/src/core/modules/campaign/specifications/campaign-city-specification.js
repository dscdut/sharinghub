import { Specification } from 'core/common/specifications';

export class CampaignCitySpecification extends Specification {
    #city;
    
    constructor(city) {
        super();
        this.#city = city;
    }

    toSql() {
        return ['campaigns.city = ?', this.#city];
    }
}
