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
   