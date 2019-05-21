Sidekiq Web

[sidekiq](https://github.com/mperham/sidekiq)

### Build

```
docker build -t sidekiq-web .
```

### Run

```
docker run -e "RAILS_ENV=development" -e "AZ_APP_2_REDIS_URL=redis://<IP>:<PORT>" -e "RACK_ENV=development" -p80:8080 -it sidekiq-web bash
```
Open web browser on http://localhost:8080
