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


Again start by running CorrLang on the specification for this excercise:
```
corrl apply -f case02/spec2.corr
```

You will see as output:
```
Wrote schema to '/home/coder/project/case_02/schema_visualization.puml' using 'PUML'.
Wrote schema to '/home/coder/project/case_02/result_schema.graphql' using 'GRAPH_QL'.
```
I.e. this time the specification was pre-configured to generate a presentation of the _global schema_ 
both using GRAPH_QL and also [PlantUML (short PUML)](https://www.plantuml.com/).
The latter is a popluar library to visualize data models, especially class diagrams.
You can turn the `.puml` file into something visually by running 

```bash
plantuml case_02/schema_visualization.puml
```

TODO:

In the end you GraphQl schema should look somethink like this...
```graphql 
# ...

type Address {
  city: String
  country: String
  houseNo: String
  lines: [String]
  postalCode: String
  street: String
}

type Customer {
  address: Address
  contacted: [ContactPoint]
  email: String!
  name: String!
  sales: [Sale]
}

# ...
```
