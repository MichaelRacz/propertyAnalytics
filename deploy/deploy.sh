DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker network create property_analytics

# quick & dirty setup of the database without considering security since it is not necessary for this pet project
docker run --net property_analytics \
  --name statistics_db \
  --hostname statistics_db \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -d \
  postgres

docker run --link statistics_db:statistics_db \
  -e PGPASSWORD=postgres \
  -d \
  --rm \
  postgres psql -h statistics_db -U postgres -c 'CREATE DATABASE statistics_prod'

# create the image for the statistics application
docker build --tag property_analytics/statistics ${DIR}/../statistics
docker run --net property_analytics --link statistics_db:statistics_db -d property_analytics/statistics
