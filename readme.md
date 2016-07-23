# Requirements

```
brew install rabbitmq
bundle install
```

# Launch

```
rabbitmq-server
ruby eta_server.rb
ruby api.rb
```

# Using

```
# request
http://localhost:4567/eta?lat=55.762841&long=37.625285

# response
```
{"eta":86.78814385160678}
```
