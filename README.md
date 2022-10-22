# codeminer42-backend-task

https://gist.github.com/talyssonoc/fa8094bc4f87ecee9f483f5fbc16862c You can find more details here.


## FINANCIAL TRANSACTIONS
 REFUELING TRANSACTION
```
 financial_transaction: {
     description: "Fuel refill at Calas",
     type: 2,
     amount: 123,
     origin_planet: "calas",
     ship: "USS Discovery",
     pilot: "199992"
 }
 ```
 
 TRANSPORT TRANSACTION
```
 financial_transaction: {
    description: "Transporting minerals to Andvari",
    transaction_type: 1,
    amount: 123,
    transaction_origin_planet: "calas",
    transaction_destination_planet: "andvari",
    ship_name: "Tempest",
    pilot_certification: 199992
}
 ```