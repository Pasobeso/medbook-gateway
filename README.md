# System architecture

This system uses the microservice architecture. This repo acts a gateway to the services, namely:

- **[Users microservice](https://github.com/Pasobeso/medbook-userservice)** - manages user use cases and authentication.

- **Booking microservice (not implemented)** - manages booking/appointment use cases.

- **Inventory microservice (not implemented)** - manages drug inventory, including retrieving/adding/removing drugs.

- **Order microservice (not implemented)** - manages order use cases.

- **Delivery microservice (not implemented)** - manages delivery lifecycle.

These services have their own dedicated databases. A service cannot directly access another service's database. However, services can directly communicate with each other (for now). Depending on the professor's advice, the communication scheme can be changed something that resembles orchestration-based architecture style.

Requests are sent to the gateway, which are redirected to their appropriate services.

## System diagram

**Note:** Since some services have yet to be implemented, this is not a 100%-accurate depiction of the current system.

# Video demonstration

# Installation

## 1. First steps

1. Ensure that Docker CLI and Docker Compose are installed.
2. Clone this repository.

```bash
git clone https://github.com/Pasobeso/medbook-gateway.git
```

## 2. Adding microservices

There are two ways to do add the microservices to the gateway.

### Through Makefile

Clone the services by executing:

```bash
make clone-services
```

This will clone the microservice repositories for you. You can update to the latest version of the repository by:

```bash
make update-services
```

### Manually

1. In the repository, change to the `./services` directory.

```bash
cd services
```

2. Clone the microservices into this directory.

```bash
git clone https://github.com/Pasobeso/medbook-userservice # Users microservice
```

## 3. Setting up .env files

.env files are required in order for each service to function properly. While the .env files are not provided for security reasons, examples (.env-example) are provided.

For example, `.users-service.env-example`

```bash
SERVER_PORT=3000
SERVER_BODY_LIMIT=2000
SERVER_TIMEOUT=2000

DATABASE_URL=postgres://postgres:example@users-db:5432/users_db

JWT_PATIENT_SECRET="patient"
JWT_PATIENT_REFRESH_SECRET="patientrefresh"
JWT_DOCTOR_SECRET="doctor"
JWT_DOCTOR_REFRESH_SECRET="doctorrefresh"

stage="local"
```

This contains all the keys and values needed for the Users service. You can use them out of the box as this reflects the Docker Compose configurations. To use this, create a file named `.users-service.env` and copy the contents above into the newly created file.

## 3. Running

Once you have all microservices set up, you can start running the system.

1. Ensure that you are in the repository's root directory.
2. Build the images and start the system by running:

```bash
make build-start
```

**Note:** You need to run this every time the source code in any of the services changes. If you do not want to rebuild the images, run this instead:

```bash
make start
```

3. Wait until the command finishes. When it does, it should look like this:

```
 ✔ Service users                 Built       4.4s
 ✔ Container medbook-adminer-1   Running     0.0s
 ✔ Container medbook-users-db-1  Healthy     11.7s
 ✔ Container gateway             Started     22.7s
 ✔ Container medbook-users-1     Healthy     22.1s
```

As long as there are no errors, the system should work just fine.

4. You can now try out the gateway and its services by following the next steps.

## 4. Try them out

### Gateway

Try going to `http://localhost:3000/health-check` on your web browser. It should return a mostly blank page with only:

```
ok
```

This means that the gateway is running properly.

### Users microservice

`http://localhost:3000/users/health-check` should return:

```
ok
```

### Adminer

[Adminer](https://www.adminer.org) is a lightweight frontend for managing databases. It supports PostgreSQL among other DBMSes. You can check this out by doing the following:

1. Go to `http://localhost:3000/adminer/`.
2. From the "System" dropdown, check `PostgreSQL`.
3. For "Server", enter the name of the service in `docker-compose.yml` that ends with `-db`. From the example below, enter `users-db`.

```yml
# in docker-compose.yml
users-db:
  image: postgres:alpine
  environment:
    POSTGRES_USER: postgres
    POSTGRES_PASSWORD: example
    POSTGRES_DB: users_db
```

4. For "Username", "Password" and "Database", refer to the `docker-compose.yml` example above and enter the values of `POSTGRES_USER`, `POSTGRES_PASSWORD` and `POSTGRES_DB`. For example, they should be `postgres`, `example` and `users_db` respectively.
5. Press `Login`. If successful, you should be able to view and manage the database this way.

## 5. Frontend

This system has a [frontend](https://github.com/Pasobeso/SA-Frontend.git) as well. Follow the steps in the repository on how to set it up.

# Contributors

### [1. Kanathip Pandee (6510503247)](https://github.com/KanathipP)

- Users service

### [2. Ittidet Namlao (6510503903)](https://github.com/tirenton)

- Frontend

### [3. Ittiwat Chuchoet (6510503913)](https://github.com/ciaabcdefg)

- Gateway setup
- Frontend revision
