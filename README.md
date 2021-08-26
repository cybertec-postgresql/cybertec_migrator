<p align="center">
  <img alt="CYBERTEC Migrator" width="300px" src="https://www.cybertec-postgresql.com/wp-content/uploads/2018/03/Migrator_neu-300x79.png"/>
  <br/><br/>
  <i>Streamlined Oracle to PostgreSQL migration</i>
</p>

<hr/>

<p align="center">
  <a href="#getting-started">Getting Started</a> •
  <a href="#running">Running</a> •
  <a href="#contact">Contact</a>
</p>

## Getting Started

### Requirements

_CYBERTEC Migrator_ is distributed as a set of [Docker](https://www.docker.com/) images that are brought up by [Docker Compose](https://docs.docker.com/compose/).

- Install [`docker`](https://docs.docker.com/get-docker/)
- Install [`docker-compose`](https://docs.docker.com/compose/install/)

### Obtaining Images

_CYBERTEC Migrator_ images can be obtained through Docker Hub.  
An offline installation package is also avaliable for environments in which networking restrictions are imposed.

- Docker Hub
  Please [get in touch](#contact) if your account has not been granted access to the respective images.

  ```sh
  cat ~/password.txt | docker login --username <username> --password-stdin
  ```

- Offline installation package  
  Please [get in touch](#contact) to request download credentials.

### Setup

- Online installation

  1. Clone the repository
  2. Change directory into cloned repository
  3. Generate default configuration
  4. Download images

  <br/>

  ```sh
  git clone https://github.com/cybertec-postgresql/cybertec_migrator
  cd cybertec_migrator
  ./migrator setup
  docker-compose pull
  ```

- Offline installation

  1. Generate default configuration
  2. Import images (assumes that images are located in `./images`)

  <br/>

  ```sh
  ./migrator setup
  ./migrator import
  ```

## Running

```sh
./migrator up
```

## Contact

- [Sales](https://www.cybertec-postgresql.com/en/contact/)
- [Report Bug](https://cybertec.atlassian.net/servicedesk/customer/portal/3/group/4/create/23)
