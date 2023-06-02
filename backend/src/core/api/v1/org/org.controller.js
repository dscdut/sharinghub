import { ValidHttpResponse } from '../../../../packages/handler/response/validHttp.response';
import { CreateOrgDto } from '../../../modules/org';
import { OrgService } from '../../../modules/org/service/org.service';

class Controller {
    constructor() {
        this.service = OrgService;
    }

    getAllOrgs = async req => {
        const data = await this.service.getAllOrgs();
        return ValidHttpResponse.toOkResponse(data);
    };

    createOrg = async req => {
        const data = await this.service.updateOrgTable(req.file, CreateOrgDto(req.body), req.user.payload);
        return ValidHttpResponse.toOkResponse(data);
    };

    getMyOrgs = async req => {
        const data = await this.service.getMyOrgs(req.user.payload);
        return ValidHttpResponse.toOkResponse(data);
    };

    getOrgById = async req => {
        const data = await this.service.getOrgById(req.user.payload, req.params.id);
        return ValidHttpResponse.toOkResponse(data);
    };

    putEditOrg = async req => {
        const data = await this.service.updateOrgTable(req.file, CreateOrgDto(req.body), req.user.payload, req.params.id);
        return ValidHttpResponse.toOkResponse(data);
    };

    deleteOrg = async req => {
        const data = await this.service.deleteOrg(req.user.payload, req.params.id);
        return ValidHttpResponse.toOkResponse(data);
    };
}

export const OrgController = new Controller();
