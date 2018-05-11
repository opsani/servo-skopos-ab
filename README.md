# Optune Servo with Skopos (adjust) and Apache-benhcmark (measure) drivers

## Update app descriptors
The following descriptors need to be updated:
 * `app-model.yaml` - Skopos model for your application, whre tunable parameters are exposed as variables
 * `app-env.yaml` - Skopos environment file, with initial values for the tunable variables
 * `app.yaml` - Optune descritor

## Build servo container
```
docker build . -t opsani/servo-skopos-ab
```    

## Create a docker secret with your authentication token
```
echo -n 'myToken'|docker secret create optune_auth_token -
```

## Run Servo (as a docker service)
```
docker service create -t --name optune-servo \
    --secret optune_auth_token \
    --network host opsani/servo-skopos-ab:latest \
    app1 --account myAccount
```    

If you named your docker secret anything other than `optune_auth_token`, then specify the path to it:
```
docker service create -t --name optune-servo \
    --secret acme-app1-auth \
    --network host opsani/servo-skopos-ab:latest \
    app1 --account myAccount --auth-token /run/secrets/acme-app1-auth
```    

