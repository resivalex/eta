# Requirements

```
brew install rabbitmq # `export PATH=$PATH:/usr/local/sbin` in .profile
bundle install
```

# Launch

```
rabbitmq-server
ruby service.rb
ruby api.rb
```

# Using

```
# request
http://localhost:4567/eta?lat=55.762841&long=37.625285

# response
{"eta":0.6960132891508809}
```
