# First Exercise 


This first exercise is meant to give a gentle start into using [CorrLang](https://past.corrlang.io/corrlang-docs/).
The latter is a tool and eponymous _Domain Specific Language (DSL)_ for **semantic interoperability** developed at HVL.
Most likely, you haven't heard much of semantic interoperability before, even though it is an important issue.
The reason for this might be that, it is a quite subtle issue that arises here and there.

To get started let us assume that we wanto  _align_ two datasets (or in other words: we want to throw them together).

These two datasets are:

- A list of **customers** ([customers.csv](./customers.csv)), and 
- a list of (insurance) **contracts** ([constracts.csv](./contracts.csv)).

Maybe you have already experience such a taks in your career? In fact, it is a quite common task in _data science_ 
or related activities: You are given a bunch of sources / data sets and then are asked to create some visualizations, 
statistics or models from it. 
Since different data sets are mostly heterogeneous, you will spend a lot of time matching fields, adjusting formats, 
and copy data from A to B manually.
One use case for CorrLang is to help with such tasks and address them in a more _declarative_ manner.

## First steps

Without further lengthy explanations, Let us take our first steps in CorrLang by running it:
Open up a terminal window by clicking on the "Hamburger menu" in the top right, select "Terminal" and then "New Terminal" window 
(Shift-Ctrl-C on Windows/Linux or Shift-Cmd-C on MacOS).
Then, run the followng command.
```bash
corrl apply -f case_01/spec1.corr
```

As output, you will see something like:
```
Wrote data to '/home/coder/project/case_01/merged.csv' using 'CSV'.
```
Try opening the new `merged.csv` file that was just created: Can you make sense of what you see? Do you see any issues with this?
Obviosly both datasets are not thrown together, yet, their columns are completely disjoint!

This is where corrlang comes in: CorrLang allows you to semantically align _data models_.
You interact with it by first writing a "CorrLang specification" in a file (file name convention: `.corr`)
and then apply it through the CLI binary `corrl`, as we did above.
To get a glimpse of how the CorrLang DSL looks, open the [`spec1.corr`](./spec1.corr) file.
In general, a specification comprises the following three concepts:

1. Two or more `endpoint`-definitions, i.e. pre-existing data sets (or services), each having a representation `tech`(nology) and a `schema`.
2. One or more `correspondence`-definitions, where you are writing how concepts stemming from disparate endpoints semantically relate 
3. One or more `view`-definitions, referring to an existing correspondence and representing a _"global view"_ of the former.
Views are the thing that actually make things happen in CorrLang: You can assemble federated datasets, create super-schemas, spin up 
proxy-servers and more. In this excercise, we are creating a comprehensive dataset accumulating the existing two datasets.

As you can see, the `correspondence` with name `C2C` already contains a few declarative relationships.
In CorrLang, these are called _commonalities_, which represent a relationship between _entities_ from separate endpoints.
_Your goal_, is to write additional such commonalities such that the resulting `merged.csv`-dataset does not contain 
any column redundancies anymore.



## Writing CorrLang DSL

In order to learn how to write commonalities, we first have to talk about _schemas_.
The first and primary assumption of CorrLang is that each dataset comes with a description thereof.
Some people call this _metadata_ (i.e. data about data), software engineers may call it a _(data) model_ (i.e. abstract representation of reality),
in CorrLang, we call this _schema_ (e.g. like in relational databases).

>> [!NOTE] **Assumption 1**
> Every dataset must be described by a *schema*


In this case, both datasets are described using [JSON-schema](https://json-schema.org/).
Plase, open [customers.json](./customers.json) and [contracts.json](./contracts.json) and see if you can make sense of these documents.
A JSON-schema is basically a data description encoded in JSON, i.e. a description of the columns in each dataset 
and their meaning.
Both datasets comprise exactly one _entity_ (a.k.a. object type) with several _fields_ (a.k.a. attributes/columns).
In CorrLang, you define commonalities elements of the same type (i.e. between object types, between attributes, between references, etc.)

Let us have a look at our first example:
```
identify (Customers.Customer, Contracts.Contract) as Customer;
```
which illustrates the syntactical structure of a commonality rule.
First, you define the _type_ of commonality:
Technically, CorrLang support three different types of commonalities, but with will stick with **identification**, 
which is the easiest to understand and to explain (expressed using the keyword `identify` or `id` for short):
It means that in the global view of everything, both concepts represent _the same_.
For object types means that they are "thrown together" with all their attributes. 
Following, the commonality type comes a list of _elements_ in parantheses.
An element must be identified by a _fully qualified name (FQN)_, starting with the name of the containing `endpoint` 
and then the name of the object type itself.
If we would refer to the `firstname` attribute of that entity, we would have written `Customers.Customer.firstname` and so on.
The final component of the rule is a _new alias name_, i.e. the name under which the resulting merged element should be known 
in the global view.

Commonality rules can also be nestes as indicated with the `with` statement.
This means that these rules are applied _after_ the parent rules is applied.
This is, for example, important when you want to align attributes of object types:
They require that the owner types are already identified.


Okay, this was a lot of talking, time to get your "hands on"...


**Excercise:** Write nested identication rules within the `Customer`-commonality such that there
are no duplicated columns anymore (see the comment on line 21)
You can check the intermediate result by running `corrl apply ...` again.
Be aware that two columns  does not necessary have to have the same name to be considered identical, i.e. consider their semantics.

Once, you are done, proceed to [Excercise 2](../case_02/README.md)!
