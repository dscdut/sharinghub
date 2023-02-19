# Authentication
## Before using
- We need to add an instance of SecurityFilter to global filter of application
- We need to add Rules to AuthorizationContainer
## Example
- Apply SecurityFilter to Express Global Filter
```javascript
    await AppBundle.builder()
        .applyAppContext(app)
        .init()
        .applyGlobalFilters([new SecurityFilter()])
        .run();
```

## Core feature
### Flow
  - Firstly, it will automatically get header['authorization'] from
  request.
  - Next, if it contains token it will apply to JwtAuthAdapter to validate
  it, else it will by pass the first step and get error whenever
  go to authorization.
  - Next, token will be decoded, if error occur here it 
  will response UnAuthorized error to user.
  - In case it validate successful, it will create a new
  instance of UserDetail or CustomUserDetail
  to req['user'] of application.
  - In controller we can retrieve it by decorator `getUserContext(req)`

### Turn on authentication
```javascript
export const UserResolver = Module.builder()
    .addPrefix({
        prefixPath: '/test',
        tag: 'test',
        module: 'TestModule'
    })
    .register([
        {
            route: '/',
            method: 'get',
            controller: UserController.findAll,
            // Turn it here, default will be false
            preAuthorization: true
        }
    ]);

```
### Custom
- We can create a custom UserDetail then it will apply to SecurityFilter like this:
```javascript
class CustomUserDetail extends UserDetail {
    // Override this
    // Below is default behavior of transferring to roles
    toRoles() {
        this.roles = this.payload?.roles ?? [];
    }

    // Override this
    // Below is default behavior of transferring to permissions
    toPermissions() {
        this.permissions = this.payload?.permissions ?? [];
    }
}

```
