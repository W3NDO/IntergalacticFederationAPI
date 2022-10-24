# Intergalactic Federation API endpoint. 
This API is used to manage information about pilots, tehir ships, and the cargo they transport across the known stretches of intergalactic federation space. 

This documentation is meant to help you understand how best to utilise our system.

valid planets = ["andvari", "aqua", "calas", "demeter"]
**Note** Anytime you need to pass a planet by name, it has to be lowercase
 - Examples of valid pilot ceritifications that pass Luhn validations [1996512, 1996521, 1996530, 1996549. 1996558, 1996567, 1996576, 1996585, 1996594, 1999939, 1999948, 1999957, 1999966, 1999975, 1999984. 1999993]

 ## FEAT 1: Add pilots and ships to the system
 ### POST request to `/pilots` to create a new pilot
 - endpoint:  `POST /pilots`

 - accepts a JSON object format: 
   ```
   "pilot":{
      "name": string, 
      "age": number, #integer greater than 18 less than 120
      "location_planet": string, #lowercase, within the valid planets
      "credits_cents": non negative integer,
      "certification": integer # Valid in that it passes the Luhn Validations
   }
   ```
- returns an object with the new pilots data:
   ```
   {
      "id": 1,
      "certification": 199992,
      "name": "Jean Luc Piccard",
      "age": 33,
      "location_planet": "calas",
      "created_at": "2022-10-22T19:53:28.507Z",
      "updated_at": "2022-10-22T19:53:28.507Z",
      "credits_cents": 109,
      "credits_currency": "USD"
   }
   ```

### GET request to `/pilots` to return all pilots
- endpoint `GET /pilots`
- returns an array of all pilots within the system, for instance:
   ```
   [
      {
         "id": 1,
         "certification": 199992,
         "name": "Jean Luc Piccard",
         "age": 33,
         "location_planet": "calas",
         "created_at": "2022-10-22T19:53:28.507Z",
         "updated_at": "2022-10-22T19:53:28.507Z",
         "credits_cents": 109,
         "credits_currency": "USD"
      },
      {
         "id": 1,
         "certification": 199992,
         "name": "Jean Luc Piccard",
         "age": 33,
         "location_planet": "calas",
         "created_at": "2022-10-22T19:53:28.507Z",
         "updated_at": "2022-10-22T19:53:28.507Z",
         "credits_cents": 109,
         "credits_currency": "USD"
      },
   ]
   ```

### GET request to `/pilots/:id` will return the a pilots data or a 404 if the pilot does not exist
- endpoint `GET /pilots/:id` (eg: `/pilots/1)
- returns: 
   ```
   {
      "id": 1,
      "certification": 199992,
      "name": "Jean Luc Piccard",
      "age": 33,
      "location_planet": "calas",
      "created_at": "2022-10-22T19:53:28.507Z",
      "updated_at": "2022-10-22T19:53:28.507Z",
      "credits_cents": 109,
      "credits_currency": "USD"
   }
   ```


### PUT/PATCH request to `/pilots/:id` will update the pilots data
- endpoint ` PUT /pilots/:id`
- accepts a JSON object format: 
   ```
   "pilot":{
      "name": string, 
      "age": number, #integer greater than 18 less than 120
      "location_planet": string, #lowercase, within the valid planets
      "credits_cents": non negative integer,
      "certification": integer # Valid in that it passes the Luhn Validations
   }
   ```

- returns a JSON object with the updated parameters
   ```
   {
      "id": 1,
      "certification": 199992,
      "name": "Jean Luc Piccard",
      "age": 33,
      "location_planet": "calas",
      "created_at": "2022-10-22T19:53:28.507Z",
      "updated_at": "2022-10-22T19:53:28.507Z",
      "credits_cents": 109,
      "credits_currency": "USD"
   }
   ```

### DELETE request to `/pilots/:id` will remove the pilot from the system.
- endpoint `DELETE /pilots/:id`
- returns a JSON message
   ```
   {
    "message": "Pilot successfully deleted"
   }
   ```

2. SHIPS
 ### POST request to `/ships` to create a new ship
 - endpoint:  `POST /ships`
 - ships require there to be a pilot for them to be valid. A ship is invalid without a pilot id attached to it. 
 - accepts a JSON object format: 
   ```
   "ship":{
      "name": string, 
      "weigh_capacity": non-negative number,
      "fuel_capacity": non-negative number,
      "fuel_level": non-negative number,
      "pilot_id": a valid pilot ID
   }
   ```
- returns an object with the new pilots data:
   ```
   {
      "name": "Normandy", 
      "weigh_capacity": 700,
      "fuel_capacity": 600,
      "fuel_level": 400,
      "pilot_id": 1
   }
   ```

### GET request to `/ships` to return all pilots
- endpoint `GET /ships`
- returns an array of all pilots within the system, for instance:
   ```
   [
      {
         "id": 1
         "name": "Normandy", 
         "weigh_capacity": 700,
         "fuel_capacity": 600,
         "fuel_level": 400,
         "pilot_id": 1
      },
      {
         "id": 2
         "name": "Normandy", 
         "weigh_capacity": 700,
         "fuel_capacity": 600,
         "fuel_level": 400,
         "pilot_id": 1
      },
   ]
   ```

### GET request to `/ships/:id` will return the ships data or a 404 if the ship does not exist
- endpoint `GET /ships/:id` (eg: `/ships/1)
- returns: 
   ```
   {
      "id": 1
      "name": "Normandy", 
      "weigh_capacity": 700,
      "fuel_capacity": 600,
      "fuel_level": 400,
      "pilot_id": 1
   }
   ```


### PUT/PATCH request to `/ships/:id` will update the pilots data
- endpoint ` PUT /ships/:id`
- accepts a JSON object format: 
   ```
   "ship":{
      "name": string, 
      "weigh_capacity": non-negative number,
      "fuel_capacity": non-negative number,
      "fuel_level": non-negative number,
      "pilot_id": a valid pilot ID
   }
   ```

- returns a JSON object with the updated parameters
   ```
   {
      "id": 1
      "name": "Normandy", 
      "weigh_capacity": 700,
      "fuel_capacity": 600,
      "fuel_level": 400,
      "pilot_id": 1
   }
   ```

### DELETE request to `/pilots/:id` will remove the pilot from the system.
- endpoint `DELETE /pilots/:id`
- returns a JSON message
   ```
   {
    "message": "Ship successfully deleted"
   }
   ```

## FEAT 2: Publish transport contracts
To get all transport contracts, you send  GET request to `/contracts`
- endpoint `GET /contracts`
- returns a list of all contracts that looks like this
   ```
    "data": [
        {
            "id": 2,
            "description": "Jean Luc Piccard transported food from andvari to calas ",
            "payload": "food",
            "origin_planet": "andvari",
            "destination_planet": "calas",
            "created_at": "2022-10-22T19:53:28.555Z",
            "updated_at": "2022-10-22T19:53:28.555Z",
            "value_cents": 289,
            "value_currency": "USD",
            "status": "closed"
        },
        {
            "id": 3,
            "description": "Jack Sparrow transported food from calas to aqua ",
            "payload": "food",
            "origin_planet": "calas",
            "destination_planet": "aqua",
            "created_at": "2022-10-22T19:53:28.557Z",
            "updated_at": "2022-10-22T19:53:28.557Z",
            "value_cents": 282,
            "value_currency": "USD",
            "status": "closed"
        },
        {
            "id": 4,
            "description": "Jean Luc Piccard transported minerals from calas to demeter ",
            "payload": "minerals",
            "origin_planet": "calas",
            "destination_planet": "demeter",
            "created_at": "2022-10-22T19:53:28.559Z",
            "updated_at": "2022-10-22T19:53:28.559Z",
            "value_cents": 332,
            "value_currency": "USD",
            "status": "closed"
        }
    ]
   ```

### Creating a new contract
A contract requires that you nest in an object of the associated resources being transported. 
- endpoint `POST /contracts`
- accepts
```
   {
      "contract": {
         "description": string,
         "payload": string, # type of resource
         "origin_planet": string, # planet name in lowercase
         "destination_planet": string, # planet name in lowercase
         "value_cents": integer,
         "status": string, # either open or closed
         "resources_attributes": {
               "name": string, type of resource, either minerals, water or food
               "weight": integer
         }
      }
   }
```

## FEAT 3: List Open Contracts
- endpoint `GET /contracts?status=open`
- will return a list of open contracts, that looks like this
   ```
   "data": [
        {
            "id": 1,
            "description": "Jane Shephard transported water from calas to andvari ",
            "payload": "water",
            "origin_planet": "calas",
            "destination_planet": "andvari",
            "created_at": "2022-10-22T19:53:28.552Z",
            "updated_at": "2022-10-22T19:53:28.552Z",
            "value_cents": 290,
            "value_currency": "USD",
            "status": "open"
        }
    ]
   ```

## FEAT 4 travel between planets
- requires a ship ID, origin planet ID and destination planet name. 
- if the ship's current location is not the same as the destination planet, it will have to travel from its current location to the origin planet, then the destination planet. If this will consume more fuel than the ship has, then the system deems travel impossible. 

- endpoint `POST /travel`
- accepts a JSON Object with the following fields
```
{
   "travel": {
      "ship_id": integer,
      "origin_planet_id": integer,
      "destination_planet_id": integer
   }
}
```

- if successfull, return 200 success and a JSON object specifying where you traveled from and where you travelled to and onboard what ship
```
{
    "message": "Successfully flew from calas to andvari aboard the USS Orville"
}
```

- if not successfull it will specify why you could not travel
```
{
    "error": "Travel between demeter and andvari is not possible"
}
```

### FEAT 5 Register a refill of fuel `POST /refill`
- requires the following fields in the POST request
   - a ship
   - planet of refill
   - units of fuel

   ```
   {
      "refill": {
         "ship_id": 1,
         "planet_id": 2,
         "units_of_fuel": 10
      }
   }
   ```
- Returns a transaction object in JSON format
```
{
    "data": {
        "id": 8,
        "description": "The ship USS Orville refuelled at aqua",
        "transaction_hash": "3f9c3ab33de9cd0d96f67f9f1beef48b",
        "amount": 10,
        "ship_name": "USS Orville",
        "pilot_certification": "199992",
        "created_at": "2022-10-23T02:01:58.236Z",
        "updated_at": "2022-10-23T02:01:58.236Z",
        "value_cents": 70,
        "value_currency": "USD",
        "pilot_id": 1,
        "ship_id": 1,
        "origin_planet_id": 2,
        "destination_planet_id": null,
        "transaction_type": "fuel_refill",
        "transaction_origin_planet": "aqua",
        "transaction_destination_planet": null
    }
}
```
It will also return a variety of errors if the ship or planet doesn't exist or if the value you passed into units of fuel can not be cast into a float

### FEAT 6 Accept transport contracts
Has 2 endpoints that would work for it 
1. `POST /contracts/accept` which requires the contract id to be specified in the body of the request. 
2. `POST /contracts/:id/accept` which has the contract id specified in the endpoint
- requires a pilot who accepts the contract
- requires a contract
- will determine if the pilot is able to accept the contract

- accepts
```
   {
      "contract": {
         "pilot_id": integer,
         "contract_id": integer,
      }
   }
```

- returns
```
{
    "message": "Contract accepted by Jean Luc Piccard of the USS Orville",
    "transaction": {
        "id": 5,
        "description": "Jean Luc Piccard is transporting water from calas to aqua",
        "transaction_hash": "a69c2617d4451561b24facf24b562ae1",
        "amount": 200,
        "ship_name": "USS Orville",
        "pilot_certification": "1999939",
        "created_at": "2022-10-23T18:42:10.419Z",
        "updated_at": "2022-10-23T18:42:10.419Z",
        "value_cents": 393,
        "value_currency": "USD",
        "pilot_id": 1,
        "ship_id": 1,
        "origin_planet_id": 3,
        "destination_planet_id": 2,
        "transaction_type": "resource_transport",
        "transaction_origin_planet": "calas",
        "transaction_destination_planet": "aqua"
    }
}
```


### FEAT 7 Grant credits to pilot after fulfilling a contract
Has 2 endpoints that would work for it 
1. `POST /contracts/fulfill` which requires the contract id to be specified in the body of the request. 
2. `POST /contracts/:id/fulfill` which has the contract id specified in the endpoint
- requires a pilot who fulfilled the contract
- requires a contract

- accepts
```
   {
      "contract": {
         "pilot_id": integer,
         "contract_id": integer,
      }
   }
```
- returns
```
{
   "message": "Contract accepted by Jean Luc Piccard of the USS Orville",
   "transaction": {
      "id": 5,
      "description": "Jean Luc Piccard successfully transported water from calas to aqua",
      "transaction_hash": "a69c2617d4451561b24facf24b562ae1",
      "amount": 200,
      "ship_name": "USS Orville",
      "pilot_certification": "1999939",
      "created_at": "2022-10-23T18:42:10.419Z",
      "updated_at": "2022-10-23T18:42:10.419Z",
      "value_cents": 393,
      "value_currency": "USD",
      "pilot_id": 1,
      "ship_id": 1,
      "origin_planet_id": 3,
      "destination_planet_id": 2,
      "transaction_type": "resource_transport",
      "transaction_origin_planet": "calas",
      "transaction_destination_planet": "aqua"
   }
}
```

## FEAT 8 Reports
### Transaction Ledger
- endpoint `GET /reports`
- returns a list of all transactions recorded on the system. 
```
{
    "data": [
        "Contract 1 paid: 356 ",
        "Contract 2 paid: 307 ",
        "Contract 3 paid: 351 ",
        "Jack Sparrow bought fuel: 641",
        "Jack Sparrow bought fuel: 402",
        "Jane Shephard bought fuel: 619",
        "Jean Luc Piccard bought fuel: 572"
    ]
}
```

### Total weight of resources sent and received by each planet
- endpoint `GET /reports/planets`
- returns a list of all planets and the resources they sent and received
```
[
    {
        "andvari": {
            "sent": {
                "food": 0,
                "water": 0,
                "minerals": 0
            },
            "received": {
                "food": 0,
                "water": 0,
                "minerals": 0
            }
        }
    },
    {
        "aqua": {
            "sent": {
                "food": 0,
                "water": 0,
                "minerals": 0
            },
            "received": {
                "food": 0,
                "water": 0,
                "minerals": 0
            }
        }
    },
]
```

### Resources transported by the pilots
- endpoint `GET /reports/pilots`
- returns a list of all pilots and the resources they transported
```
   [
    {
        "Jean Luc Piccard": {
            "food": 12,
            "water": 130,
            "minerals": 14
        }
    },
    {
        "Jane Shephard": {
            "food": 1,
            "water": 30,
            "minerals": 4
        }
    },
    {
        "Jack Sparrow": {
            "food": 19,
            "water": 3,
            "minerals": 45
        }
    }
]
```