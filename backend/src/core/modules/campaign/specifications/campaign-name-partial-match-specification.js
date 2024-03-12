import { Specification } from 'core/common/specifications';

export class CampaignNamePartialMatchSpecification extends Specification {
    #name;
    
    constructor(name) {
        super();
        this.#name = `%${name.toLowerCase()}%`;
    }

    toSql() {
        return ['LOWER(campaigns.name) LIKE ?', this.#name];
    }
}
