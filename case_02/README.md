# Exercise 2 

In the previous exercise data was represented using CSV and the schema was described using JSON(-schema).
However, the data could also be represented in a completely different way.
On the internet, you will find a plethora of different serialization format and technologies.
CorrLang aims to address this challenge by providing _adapters_ into different _technical spaces_ via a plugin mechanism.
As you might have guessed, there are builtin plugins for CSV and JSON.
But we are not limited to these, in this exercise we will look at more complex schemas, 
which are encoded using [GRAPH_QL](https://graphql.org/), an alternative to REST-based web application interfaces,
originally developed by Facebook.
Even if you have not worked with GraphQL before, their _interface description language (IDL)_ should 
read pretty intuitively.
Go ahead, and have a look at [`crm.graphql`](./crm.graphql) and [`pos.graphql`](./pos.graphql). 
We could think that these schemas describe the interfaces of two different _systems_ and their underlying 
_domain models_.
The models in this scenario contain more than only one entity.
Hence, we will ignore any _data_ for the moment and want to like to only work on schema-level.
Again, our goal is to align both data models, match identical concepts and create an integrated "super-schema".


Let us start by running CorrLang again, this time, on the specification for this particular excercise:
```bash
corrl apply -f case_02/spec2.corr
```

You will see as output:
```
Wrote schema to '/home/coder/project/case_02/schema_visualization.puml' using 'PUML'.
Wrote schema to '/home/coder/project/case_02/result_schema.graphql' using 'GRAPH_QL'.
```

This means, that the `view`-definition was pre-configured to generate a presentation of the _global schema_
**two times**, one time using using GRAPH_QL and one time using [PlantUML (short PUML)](https://www.plantuml.com/).
The latter is a popluar library to visualize data models, especially class diagrams.
You can turn the `.puml` file into something visually by running 

```bash
plantuml case_02/schema_visualization.puml
```

The above visualization should provide you with a more clear idea what entities could be identified with each other.
Try adding the identifications to the specification in [`spec2.corr`](./spec2.corr) such that the resulting 
GraphQL specification does not contain any `_` underscores anymore (The latter 
are a symptom for "semantic duplicates" in GraphQL, since the latter does not allow
distinct schema elements with the same name, CorrLang will try to naively disambiguate
name clashes by namespace-prefixing using `_` as fill-character).


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

> [!WARNING]
> There may be chance that during this exercise, you may encounter a cryptic error message saying something 
> like "missing pre-image commonality". Don't panic! The weird terminology comes from CorrLangs theoretical
> foundation that uses a _graph_-based formalism to internally represent data models. 
> This requires that in order to identify two attributes or references (which are formally considered as 
> an edge between two nodes: the owner and target types) to already have their source and target ends 
> identified. This means that in order to identify a reference `f` between two types `A` and `B` in one schema 
> with a reference `g` between `X` and `Y` in another schema, you must have defined identification between 
> `A` and `X` (`B` and `Y`) respectively prior to this.
