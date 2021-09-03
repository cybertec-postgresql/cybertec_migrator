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

[_CYBERTEC Migrator_](https://www.cybertec-postgresql.com/en/products/cybertec-migrator/) is an streamlined and user-friendly tool that helps you to organize and efficiently migrate multiple Oracle databases to PostgreSQL.  
In addition to migrating your data professionally and securely with minimum effort, _CYBERTEC Migrator_ allows you to visually monitor and track the whole process at any time.

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

  1. Extract the provided archive file
  2. Change directory to the directory created in the previous step
  3. Generate default configuration
  4. Import images (assumes that images are located in `./images`)

  <br/>

  ```sh
  tar xf cybertec_migrator-v3.0.0-beta.tar.gz
  cd cybertec_migrator
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
