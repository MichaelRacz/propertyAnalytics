(docker ps -qa -f network=property_analytics) | xargs docker stop | xargs docker rm

docker network rm property_analytics

docker rmi property_analytics/statistics
