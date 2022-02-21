# CityTrees.Umbrella

- [Local setup](./docs/local.md)


docker run -t -i -v /home/raziel/MyProjects/city_trees_umbrella:/app builder /bin/bash
scp -r -i ./terraform/.ssh/deploy -P 2211 city_trees_web.zip devops@49.12.207.142:/home/devops/