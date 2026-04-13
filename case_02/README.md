# Exercise 2 

In the previous exercise data was represented using CSV and the schema was described using JSON(-schema).
However, the data could also be represented in a completely different way.
On the internet, you will find a plethora of different serialization format and technologies.
CorrLang aims to address this challenge by providing _adapters_ into different _technical spaces_ via a plugin mechanism.
As you might have guessed, there are builtin plugins for CSV and JSON.
But we are not limited to these, in this exercise we will look at data from two different systems (called `Crm` and `Pos`).
The schema for these systems are described using `GRAPH_QL`, the data itself is represented in JSON.

Can you modify the definitions in [`spec2.corr`](./spec2.corr) such that you get 
- one integrated GRAPH_QL schema 
- one integrated JSON schema
?
