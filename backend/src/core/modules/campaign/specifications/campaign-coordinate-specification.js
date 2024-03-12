import { Specification } from 'core/common/specifications';

export class CampaignCoordinateSpecification extends Specification {
    #lat;
    #lng;
    
    constructor(lat, lng) {
        super();
        this.#lat = lat;
        this.#lng = lng;
    }

    toSql() {
        return ['coordinate->> \'lat\' = ? AND coordinate->> \'lng\' = ?', [this.#lat, this.#lng]];
    }
}
