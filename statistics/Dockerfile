FROM marcelocg/phoenix

COPY . /code/
RUN cd /code

# set variables
ENV MIX_ENV prod
ENV PORT 80

# Initial setup
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --only prod
RUN mix compile

# Compile assets
RUN npm install -g brunch
RUN brunch build --production
RUN mix phoenix.digest

# Custom tasks (like DB migrations)
CMD mix ecto.migrate

# Finally run the server
CMD mix phoenix.server
 
EXPOSE 80
