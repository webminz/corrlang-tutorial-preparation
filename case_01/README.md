# First Exercise 


This first exercise is meant to give a gentle start into using [CorrLang](https://past.corrlang.io/corrlang-docs/).
The goal is to _align_ two datasets (or in other words: we want to throw them together):

- A list of **customers** ([customers.csv](./customers.csv)), and 
- a list of (insurance) **contracts** ([constracts.csv](./contracts.csv))

Both datasets are described using JSON-schema, see [customers.json](./customers.json) and [contracts.json](./contracts.json)
respectively.

Upon inspecting both datasets, you will see that they share a similar structure, yet they are two separe 
Your goal is to create an integrated dataset combining records form both sources using CorrLang.

Let us start by running CorrLang the first time, open up a terminal window (Shift-Ctrl-C on Windows/Linux or Shift-Cmd-C on MacOS)
and type 
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
Even though, there are many ways to align data models, one of the most common and also the easiest to understand is **identification**.
In the CorrLang DSL you can express identification of concepts using the following _Domain Specific Language (DSL)_:

```
identify (Customers.Customer, Contracts.Contract) as CustContract;
```

TODO:

This will instruct CorrLang to read the specification in [`spec1.corr`](./spec1.corr) and act on it.
Technically, the `file`-directive in the `view` definition will ask CorrLang to assemble alls dataset files 
from all `DATA`-type endpoints int the correspondence behind the view into a new file `merged.csv` using CSV as the output format.

**Your task:** Write identication rules such that there are no duplicated columns anymore (be aware that two columns 
does not necessary have to have the same name to be considered identical, i.e. consider their semantics).
Once, you are done, proceed to [Excercise 2](../case_02/README.md)!
