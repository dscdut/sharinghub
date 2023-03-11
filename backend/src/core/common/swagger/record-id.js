import { SwaggerDocument } from '../../../packages/swagger';

export const RecordId = SwaggerDocument.ApiParams({
  name: 'id',
  paramsIn: 'path',
  type: 'integer',
  description: 'Record Id to find',
});
