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