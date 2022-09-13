package scuel

import "github.com/cpard/scuel/models/tpch"
import "github.com/cpard/scuel/queries/tpch_queries"
import "list"
import "text/template"

_#Scuel: {
	template: string
	seed: tpch.#Seed
}

_#Scuels: list.Repeat([_#Scuel], 22)

database: tpch.#Database & {
	dbname: "benches"
	schema: "tpch"
}

_tpch_squels: _#Scuels & [
	{
		template: tpch_queries.q1_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q1_params
		}
	},
	{
		template: tpch_queries.q2_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q2_params
		}
	},
	{
		template: tpch_queries.q3_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q3_params
		}
	},
	{
		template: tpch_queries.q4_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q4_params
		}
	},
	{
		template: tpch_queries.q5_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q5_params
		}
	},
	{
		template: tpch_queries.q6_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q6_params
		}
	},
	{
		template: tpch_queries.q7_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q7_params
		}
	},
	{
		template: tpch_queries.q8_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q8_params
		}
	},
	{
		template: tpch_queries.q9_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q9_params
		}
	},
	{
		template: tpch_queries.q10_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q10_params
		}
	},
	{
		template: tpch_queries.q11_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q11_params
		}
	},
	{
		template: tpch_queries.q12_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q12_params
		}
	},
		{
		template: tpch_queries.q13_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q13_params
		}
	},
		{
		template: tpch_queries.q14_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q14_params
		}
	},
		{
		template: tpch_queries.q15_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q15_params
		}
	},
		{
		template: tpch_queries.q16_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q16_params
		}
	},
		{
		template: tpch_queries.q17_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q17_params
		}
	},
		{
		template: tpch_queries.q18_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q18_params
		}
	},
		{
		template: tpch_queries.q19_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q19_params
		}
	},
		{
		template: tpch_queries.q20_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q20_params
		}
	},
			{
		template: tpch_queries.q21_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q21_params
		}
	},
			{
		template: tpch_queries.q22_template
		seed: tpch.#Seed & {
			db: database
			params: tpch.#q22_params
		}
	}
]

rendered: [for sc in _tpch_squels{
	content: template.Execute(sc.template, sc.seed)
}]