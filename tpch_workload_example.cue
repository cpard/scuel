package scuel

import "github.com/cpard/scuel/models/tpch"
import "github.com/cpard/scuel/queries/tpch_queries"

import "text/template"

database: tpch.#Database & {
	dbname: "benches"
	schema: "tpch"
}

seed: tpch.#Seed &{
	db: database
	params: tpch.#q22_params
}

contents: template.Execute(tpch_queries.q22_template, seed)