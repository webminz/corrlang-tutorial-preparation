# Excercise 3 

So far we have been working with _static data_ stored in files and schemas without data.
Time to work with something more realistic!
CorrLang is not limited to static data and schema files, it can also work with  dynamic _services_.
Upon inspecting, the pre-defined specification in [`spec3.corr`](./spec3.corr), you may 
spot that the endpoints here are of type `SERVICE`.
Services differ from `DATA` in the sense that they appear as some sort of "black box":
We cannot look into them and retrieve the data, instead we have to interact with them using their 
API, i.e. by sending them messages and interpreting the result.

## GraphQL 

Before we can start with this final excercise, we need to explain some GraphQL concepts.
In the previous excersie, we have already seen GraphQL schemas, which are defined in a friendly IDL.
The schema defines the existing entity types but it also defines the admissable _operations_ or _actions_.
This is facilitated by a special interpretation of entity types with names `Query` and `Mutation`.
Instead of representing a structural field, the members of these types represent operations, 
which can be though of as the entry point to the whole application data, which can be thought 
of as an inter-connected graph (hence the name).

The best way to try this out, is by exploring the existing GraphQl endpoints that come shipped with this excerise.
Behind the scenes, there are three GraphQL endpoint running on ports `4011`, `4012`, and `4013`.
You can start to interact with them by sending them requests.
The most user-friendly way is to use the built-in Bruno plugin (look for the Dog icon on the extension bar on the left).
Here, you will find a pre-made request for each of the three endpoints.
You can download the schema via an "_introspection query_" and explore it.
Try, to modify the `query` in each request, also by adding queires for nested elements to explore the data model.


## Global View Server

The idea of this exercise is to create a _proxy federation_ GraphQL endpoint.
This federation shall be some sort of "one-stop-shop" for the existing individual endpoints.
Thus, instead of letting users work with individual endpoints, we want to create a single unified interface,
think API gateway that user can interact with.
Moreover, this unified endpoint will provide us with the opportunity to align heterogenous data.
When inspecting the domain models of these endpoints you will see that there is a `Address` concept 
in two of the three endpoints and also the `Customer`, `Client`, and `Employee` concepts are quite similar.
Again, your task is to identify concepts but this time you can also try to **identify operations as well**.
Since, GraphQL already exposes them as structural features it should be easy to identify just like everything else.

In the end your schema should comprise some rules like:
```graphql
# ...
identify (Sales.Query.customers, Invoices.Query.clients, HR.Query.employees) as partners;
# ...
identify (Sales.Customer, Invoices.Client, HR.Employee) as Partner;
# ...
```

Start, by running 
```bash
corrl apply -f case_03/spec3.corr
```
and then add identifations one by one, re-run `corrl` and check the results.
Eventually, you shall uncomment the `#` in line 31 in [`spec3.corr`](./spec3.corr)
to trigger the generation of the comprehensive GraphQL.

Finally, if the latter looks alright (and also only then, otherwise you may experience errors),
you can uncomment line 32.
The latter will cause CorrLang to open up a GraphQL endpoint on port `7070`.
Try, sending a GraphQL request to this endpoint via bruno by writing a query that uses the new 
`partners`-query as entry point: Can you see that you receive data from all three endpoint simultaneously?
