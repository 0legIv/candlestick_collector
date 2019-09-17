# CandlestickCollector

## To start the application in prod:

  * `docker build -t candlestick_collector .`
  * `docker-compose up`

## To start the application in dev:

**You need to have mongodb installed or you can simply run it in the docker container.**
The default mongodb connection string in dev config: `mongodb://127.0.0.1:27017/candlestick_collector`

  * `docker run -d -p 27017:27017 -v ~/data:/data/db mongo`
  * `iex -S mix`

## To run the tests:

**You need to have mongodb installed or run it in the docker container.**

  * `docker run -d -p 27017:27017 -v ~/data:/data/db mongo`
  * `mix test`

Environment Variables:

  * `MONGODB` - specifies the mongodb connection string
