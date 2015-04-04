## Sinatra Tutorial

- Introductory project in Sinatra - simple Ruby DSL for web applications
- Originated from RailsGirls [Sinatra Guide](http://guides.railsgirls.com/sinatra-app/)

------

## Sinatra webapp for consuming public APIs
- Sinatra makes it easy to quickly build simple web applications to consume public APIs
- To access the Meetup API, generate an API key at [www.meetup.com](http://www.meetup.com/meetup_api/) and store it into `keys.yml` file in the following format:

```
---
keys:
  meetup_api_key: $YOUR_MEETUP_API_KEY

```

- Although the `keys.yml` file will not be tracked via source control, it is still better to store API keys as environment variables
- Original tutorial [here](https://blog.engineyard.com/2014/rails-vs-sinatra)
