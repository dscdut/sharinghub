export const SwaggerContentDto = rawContent => ({
    description: rawContent.description,
    method: rawContent.method.toLowerCase(),
    route: rawContent.route,
    security: rawContent.preAuthorization,
    tags: rawContent.tag,
    model: rawContent.model,
    body: rawContent.body,
    params: rawContent.params,
    consumes: rawContent.consumes,
    errors: rawContent.errors
});
