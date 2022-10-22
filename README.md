# codeminer42-backend-task

https://gist.github.com/talyssonoc/fa8094bc4f87ecee9f483f5fbc16862c You can find more details here.


## FINANCIAL TRANSACTIONS
 REFUELING TRANSACTION
```
 financial_transaction: {
    description: "Fuel refill at Calas",
    transaction_type: 2,
    amount: 123,
    pilot_id: 1,
    origin_planet_id: 2,
    ship_id: 1    
 }
 ```
 
 TRANSPORT TRANSACTION
```
 financial_transaction: {
    description: "Transporting minerals to Andvari",
    transaction_type: 1,
    amount: 123,
    pilot_id: 1,
    destination_planet_id: 1,
    origin_planet_id: 2,
    ship_id: 1    
}
 ```

 valid planets = ["andvari", "aqua", "calas", "demeter"]

 ## FEAT 1: Add pilots and ships to the system
 1. PILOTS
 ### POST request to `/pilots` to create a new pilot
 - endpoint:  `POST /pilots`
 - some valid ceritification that pass Luhn validations [1999939, 1999948, 1999957, 1999966, 1999975, 1999984. 1999993]
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
