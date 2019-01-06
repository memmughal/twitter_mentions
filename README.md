# TwitterMentions

This application saves twitter mention related data for a given `screen_name` of a twitter user.

 ## Setup
1. Install docker
2. Edit `docker-compose.yml` to set environment vars
3. Run docker image: `docker-compose run --rm application init migrate bash`
4. Inside the bash console, run `iex -S mix`

 ## Setup by shell script
 To run docker container with shell script, navigate to project folder and run `sh run.sh <args>`
 You can provide all necessary env vars to this command, to get help, please run `sh run.sh -h`
The complete command looks like:
`sh run.sh <SCREEN_NAME> <CONSUMER_KEY> <CONSUMER_SECRET> <ACCESS_TOKEN> <ACCESS_TOKEN_SECRET>`
 Inside the bash console, run `iex -S mix`

 ## Environment vars
The application depends on the following env variables:
1. `<SCREEN_NAME>` The screen name for whom you want to get mentions for. The format must be `@josevalim`
2. `<CONSUMER_KEY>` The twitter api consumer key
3. `<CONSUMER_SECRET>` The twitter api consumer secret
4. `<ACCESS_TOKEN>` The twitter api access token
5. `<ACCESS_TOKEN_SECRET>` The twitter api access token secret

## Functionality
```
					TwitterMentions.fetch()
```
This fetches twitter mentions for the screen_name set in environment variables and saves related details into the database.


```
					TwitterMentions.get_all()
```
This shows list of twitter mentions details saved in the database.

 ## Run tests
1. Install docker
2. Run docker command: `docker-compose run --rm application init migrate test`