import { SwaggerDocument } from '../../../packages/swagger';

export const QueryCriteriaDocument = {
    page: (desc = 'Max page: 100000. Default: 1') => SwaggerDocument.ApiParams({
        name: 'page',
        paramsIn: 'query',
        required: false,
        type: 'int',
        description: desc
    }),
    size: (desc = 'Max size: 100. Default: 50') => SwaggerDocument.ApiParams({
        name: 'size',
        paramsIn: 'query',
        required: false,
        type: 'int',
        description: desc
    }),
    sort: desc => SwaggerDocument.ApiParams({
        name: 'sort',
        paramsIn: 'query',
        required: false,
        type: 'array',
        description: desc
    }),
    filter: desc => SwaggerDocument.ApiParams({
        name: 'filter',
        paramsIn: 'query',
        required: false,
        type: 'array',
        description: desc
    }),
    search: desc => SwaggerDocument.ApiParams({
        name: 'search',
        paramsIn: 'query',
        required: false,
        type: 'string',
        description: desc
    })
};

export const DefaultQueryCriteriaDocument = [...Object.values(QueryCriteriaDocument).map(exec => exec())];

export const generateDocBasedOnSchema = schema => {
    if (!schema?.locks?.filters) {
        throw new Error('locks.filters are not existed in schema file. Should be an array');
    }

    if (!schema?.locks?.sorts) {
        throw new Error('locks.sorts are not existed in schema file. Should be an array');
    }

    if (!schema?.searchCriteria) {
        throw new Error('searchCriteria are not existed in schema file. Should be an array');
    }

    return [
        QueryCriteriaDocument.page(),
        QueryCriteriaDocument.size(),
        QueryCriteriaDocument.filter(`Support filter: ${schema.locks.filters.toString()}`),
        QueryCriteriaDocument.sort(`Support sort fields: ${schema.locks.sorts.toString()}`),
        QueryCriteriaDocument.search(`Support search fields: ${schema.searchCriteria.toString()}`)
    ];
};
