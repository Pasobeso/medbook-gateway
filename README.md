# Installation

## 1. First steps

1. Ensure that Docker CLI and Docker Compose are installed.
2. Clone this repository.

```bash
git clone https://github.com/Pasobeso/medbook-gateway.git
```

## 2. Adding microservices

The gateway requires two microservices to function

- Users microservice
- Booking microservice

Add them by following these steps:

1. In the repository, change to the `./services` directory.

```bash
cd services
```

2. Clone the microservices into this directory.

```bash
git clone <microservice repository URL> # Users microservice
git clone <microservice repository URL> # Booking microservice
```

3. The cloned repositories will not contain `.env` files. Create a file named `.env` in each of the repositories, and follow the formats provided in the `.env-example` files.

## 3. Running

Once you have all microservices set up, you can start running the system.

1. Ensure that you are in the repository's root directory.
2. Start the system by running:

```bash
docker compose up -d --build
```

3. Wait until the command finishes. When it does, it should look like this:

```
 ✔ Service booking               Built       4.4s
 ✔ Service users                 Built       4.4s
 ✔ Container medbook-adminer-1   Running     0.0s
 ✔ Container medbook-users-db-1  Healthy     11.7s
 ✔ Container gateway             Started     22.7s
 ✔ Container medbook-users-1     Healthy     22.1s
 ✔ Container medbook-booking-1   Healthy     21.6s
```

4. You can now try out the gateway and its services by following the next steps.

## 4. Try them out

### Gateway

Try going to `http://localhost:3000/health` on your web browser. It should return a mostly blank page with only:

```
ok
```

This means that the gateway is running properly.

### Users microservice

`http://localhost:3000/users/health-check` should return:

```
ok
```

### Booking microservice

`http://localhost:3000/booking/health-check` should return:

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
