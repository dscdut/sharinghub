# Swagger Documentation
## Swagger content:
- From json content should be built based on dto: SwaggerContentDto
```
{
    description,
    method,
    route,
    security,
    tags,
    model,
    body,
    params,
    consumes,
    errors
}
```
- Prefix should have this format:
```
{
    prefixPath,
    tag,
    module
}
```
- Then create swagger content creator like this:
```
SwaggerContentCreator
    .builder()
    .fromJson(jsonContent)
    .addPrefix(this.#prefix)
    .build()
```
## Swagger core:
- First we should initialize swagger builder with prefix config:
```
const options = {
    openapi: '3.0.1',
    info: {
        version: '1.0.0',
        title: 'APIs Document',
        description: 'API description',
        termsOfService: '',
        contact: {
            name: 'Backend S-group',
            email: 'laptrinh-sgroup@gmail.com',
        },
    },
    servers: [
        {
            url: `${HOST}/api`,
            description: 'Local server',
            variables: {
                env: {
                    default: 'app-dev',
                    description: 'DEV Environment',
                },
                port: {
                    enum: [
                        '8443',
                        '5000',
                        '443',
                    ],
                    default: PORT,
                },
                basePath: {
                    default: 'api',
                },
            },
        },
        {
            url: 'https://app-dev.herokuapp.com/api',
            description: 'DEV Env',
        },
    ],
    basePath: '/api',
    auth: true,
};
const ApiDocument = SwaggerBuilder.builder().addConfig(options)
```
- Then it will initial with some basic information
- addTag function to add tag of api to persistence server
- api function to create api compatible to swagger document:
```
    route,
    method,
    tags,
    description,
    security,
    model,
    body,
    params = [],
    consumes = [],
    errors = []
```
- addModel:
  - Will add model schema with specific name in to current swagger memory with the name of that then we can point out the model by the name reference.
  - Second parameter should be build with the supporting of SwaggerDocument
## Swagger document
- ApiProperty
  - Input of this function should be:
```
    type,
    required,
    readOnly,
    example,
```
  - Types:
    - With primitive types: string, int, bool, dateTime, file. In put should contains these fields:
```
- type, // type will define type of data which match to types above
- required = true, // If not required set to false, remember default would be true
- readOnly = false, // If not required set to true to make this field being read only, remember default would be false
- example, // Example data for that document which can be an array, string or number...
```
  - Generic type:
    - Including: array, model, enum
    - Input should be:
```
    type,
    model,
    required,
    readOnly,
    example,
```
    - With type is one of 'array', 'enum', 'model'
    - And the model field is required to be generated or else it will collect default generator is string
```
Example:
- Int:
    type: 'array',
    model: 'int',
    example: [1,2,3],
- String:
    type: 'array',
    example: ['test'],
- DateTime:
    type: 'array',
    model: 'dateTime',
- Boolean:
    type: 'array',
    model: 'bool',
- Enum:
    type: 'enum',
    model: {
        KEY: 'value'
    },
- Model:
    type: 'model',
    model: 'nameOfAModelYouDefineAbove'
```

- ApiParams
  - Input of this function should be:
```
    type,
    name,
    model,
    paramsIn = 'query',
    required = true,
    example,
```
  - Data types should be define as above
  - paramsIn can be 'query' or 'path'
