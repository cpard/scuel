
     _____                 _      
    / ____|               | |     
    |(___   ___ _   _  ___| |     
    \___ \ / __| | | |/ _ \ |     
     ____) | (__| |_| |  __/ |____
    |_____/ \___|\__,_|\___|______|

## Generating (TPCH) SQL using CUE

This project is an experimentation in using [CUE](https://cuelang.org/) as a way to generate customized queries for TPCH.
For anyone familiar with [TPCH](https://www.tpc.org/tpch/) and the rest of the TPC work, will know that the specification defines a number of queries that can be 
parameterized under certain constraints. 

The combination of a very powerful templating engine borrowed from Golang, together with how good CUE is in expressing constraints,
makes it a very pleasant experience to approach the generation of these queries as a configuration problem managed by Cuelang.

To use scuel, you have to create configuration files that define the parameters of your queries. All the defaults defined by TPCH
have been used, so it's super easy to create all the queries with default parameters. To do that, you only have to execute: `cue cmd tpch_gen` on your terminal.

When done, a number of 22 .sql files will be created where each one contains one of the TPCH queries.

The beauty of CUE is that there's no way you can end up with queries that have parameters that are not accepted by the specification. If the parameters you pass
violate the constraints of the specification, you will get an error explaining why.

Going through the cue files is also a good way to get familiar with the constraints and the schema of the TPCH specification, that's another benefit of working with the clear syntax an semantics of CUE.

If you plan to create your custom configurations, you can edit the `scuel.cue` file and update the `database` definition to add database related information, e.g. schema and database name.

Then, for each one of the queries you can create a parameters object where you can set the values you want. The `tpch_model.cue` file is your friend here, 
it contains all the schema definitions for each query together with references to the specification document to find more information if you want.

## Future work
* Being able to generalize to other models and queries in an easy way would be a great next step for ScueL. 
* Being able to test the queries against a DB would also be extremely useful but this will be hard to implement with just
CUE and its toolset. It is possible to run commands with CUE but interpreting outputs from a sql CLI tool is not trivial.
* Can we use CUE to generate the complete workload for TPCH? Including the data for the database? This is more complex than templating queries, but it would be useful. The current tooling for TPCH is hard to use.


