FROM marcelocg/phoenix

COPY . /code/
RUN cd /code

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

# Setup DB and  run the server
# TODO: find a cleaner solution
CMD ["sh", "-c", "mix ecto.create; mix ecto.migrate; mix phoenix.server"]
 
EXPOSE 80
