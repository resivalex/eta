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

request `http://localhost:4567/eta?coord=46.055556%2014.508333`
response `{"eta":86.78814385160678}`
