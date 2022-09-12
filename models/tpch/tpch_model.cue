package tpch

import "list"
import "time"

// Database contains the information needed to connect to a database and configure the generated queries, for example
// schema and dbname are needed for that.
#Database: {
	dbname: !=""
	schema?: string
}

//database: #Database & {
//	dbname: "benches"
//	schema: "tpch"
//}

// we want to make sure that each table definition is at least defining a table name, we need that for the query templates
#Table: {
	table_name: !=""
	...
}

// This is the actual TPCH schema as it is defined in https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// #1.2 (pp 13), #1.4 (pp 14)
#Schema: {
	lineitem: #Lineitem
	part: #Part
	supplier: #Supplier
	partsupp: #Partsupp
	customer: #Customer
	orders: #Orders
	nation: #Nation
	region: #Region
}

// See https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf #1.4 (pp 16-17) for LINEITEM table layout
#Lineitem: #Table & {
		table_name: "lineitem"
    orderkey: string | *"l_orderkey" 
    partkey: string | *"l_partkey"
    suppkey: string | *"l_suppkey"
    linenumber: string | *"l_linenumber"
    quantity: string | *"l_quantity"
    extendedprice: string | *"l_extendedprice"
    discount: string | *"l_discount"
    tax: string | *"l_tax"
    returnflag: string | *"l_returnflag"
    linestatus: string | *"l_linestatus"
    shipdate: string | *"l_shipdate"
    commitdate: string | *"l_commitdate"
    receiptdate: string | *"l_receiptdate"
    shipinstruct: string | *"l_shipinstruct"
    shipmode: string | *"l_shipmode"
    comment: string | *"l_comment"
}

// See https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf #1.4 (pp 14-15) for PART table layout
#Part: #Table & {
	table_name: "part"
	partkey: string | *"p_partkey"
	name: string | *"p_name"
	mfgr: string | *"p_mfgr"
	brand: string | *"p_brand"
	type: string | *"p_type"
	size: string | *"p_size"
	container: string | *"p_container"
	retailprice: string | *"p_retailprice"
	comment: string | *"p_comment"
}

// See https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf #1.4 (p 15) for SUPPLIER table layout
#Supplier: #Table & {
	table_name: "supplier"
	suppkey: string | *"s_suppkey"
	name: string | *"s_name"
	address: string | *"s_address"
	nationkey: string | *"s_nationkey"
	phone: string | *"s_phone"
	acctbal: string | *"s_acctbal"
	comment: string | *"s_comment"
}

// See https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf #1.4 (p 15) for PARTSUPP table layout
#Partsupp: #Table & {
	table_name: "partsupp"
	partkey: string | *"ps_partkey"
	suppkey: string | *"ps_suppkey"
	availqty: string | *"ps_availqty"
	supplycost: string | *"ps_supplycost"
	comment: string | *"ps_comment"
}

// See https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf #1.4 (pp 15-16) for CUSTOMER table layout
#Customer: #Table & {
	table_name: "customer"
	custkey: string | *"c_custkey"
	name: string | *"c_name"
	address: string | *"c_address"
	nationkey: string | *"c_nationkey"
	phone: string | *"c_phone"
	acctbal: string | *"c_acctbal"
	mktsegment: string | *"c_mktsegment"
	comment: string | *"c_comment"
}

// See https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf #1.4 (p 16) for ORDERS table layout
#Orders: #Table & {
	table_name: "orders"
	orderkey: string | *"o_orderkey"
	custkey: string | *"o_custkey"
	orderstatus: string | *"o_orderstatus"
	totalprice: string | *"o_totalprice"
	orderdate: string | *"o_orderdate"
	orderpriority: string | *"o_orderpriority"
	clerk: string | *"o_clerk"
	shippriority: string | *"o_shippriority"
	comment: string | *"o_comment"
}

// See https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf #1.4 (p 17) for NATION table layout
#Nation: #Table & {
	table_name: "nation"
	nationkey: string | *"n_nationkey"
	name: string | *"n_name"
	regionkey: string | *"n_regionkey"
	comment: string | *"n_comment"
}

// See https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf #1.4 (p 17) for REGION table layout
#Region: #Table & {
	table_name: "region"
	regionkey: string | *"r_regionkey"
	name: string | *"r_name"
	comment: string | *"r_comment"
}

// Seed is the information that is needed to parametarize correctly the query that will be generated, this is its schema
// It requires a schema (the logical table layout of the database that will be used) the parameters for the query to be
// generated and the database connection information.
#Seed: {
	schema: #Schema
	params: #Parameters
	db: #Database
}

///////////// CONSTRAINTS SECTION /////////////
// This is the section where the constraints for query parameters are defined
// Each query is having a set of constraints with allowed values and defaults
// as defined in https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// in Section 2.4 (pp 29-67)
/////////////////////////////////////////////

// This is the schema of a parameters set for a query, it pretty much can include anything
#Parameters: {...}

// Parameter constraints and defaults for Pricing Summary Report Query (Q1)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.1.3 p 29
#q1_params: #Parameters & {
	delta: (uint8 & <= 120 & >= 60) | *90
}

// Parameter constraints and defaults for Minimum Cost Supplier Query (Q2)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.2.3 p 32
#q2_params: #Parameters & {
	size: (>=1 & <= 50) | *15
	type: or(_syllable_3) | *"%BRASS"
	region: or(_regions) | *"EUROPE"
}

// Syllable 1,2 & 3 allowed values as defined in https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 4.2.2.13 p 81
_syllable_3: ["TIN", "NICKEL", "BRASS", "STEEL", "COPPER"]
_syllable_1: ["STANDARD", "SMALL", "MEDIUM", "LARGE", "ECONOMY", "PROMO"]
_syllable_2: ["ANODIZED", "BURNISHED", "PLATED", "POLISHED", "BRUSHED"]

// Region allowed values as defined in https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 4.2.3 p 87
_regions: ["EUROPE", "AFRICA", "AMERICA", "ASIA", "MIDDLE EAST"]


// Parameter constraints and defaults for Shipping Priority Query (Q3)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.3.3 p 33
#q3_params: #Parameters & {
	segment: or(_segments)| *"BUILDING"
	date: time.Format(time.RFC3339Date) & >= "1995-03-01" & <= "1995-03-31" | *"1995-03-15"
}

// Segments allowed values as defined in https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 4.2.2.13 p 82
_segments: ["AUTOMOBILE", "BUILDING", "FURNITURE", "MACHINERY", "HOUSEHOLD"]

// Parameter constraints and defaults for Order Priority Checking Query (Q4)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.4.3 p 35
#q4_params: #Parameters & {
	date: time.Format(time.RFC3339Date) | *"1997-07-01"
	_i: list.Contains(_#q4_valid_dates, date)
	#valid: true & _i //not the best error messaging possible but this is the way to test if valid by existing in the list
}

// Generating the appropriate list of valid dates as they are defined in Section 2.4.4.3 p 35
// Then Cue can validate if the date provided is valid based on that (see #q4_params schema definition)
_#q4_years: [1993, 1994, 1995, 1996, 1997]
_#q4_months: [1,2,3,4,5,6,7,8,9,10,11,12]

_#q4_valid_dates: list.FlattenN([for year in _#q4_years if year != 1997{
    [for month in _#q4_months if month < 10{
        "\(year)-0\(month)-01"
    }, for month in _#q4_months if month >= 10{
        "\(year)-\(month)-01"
    }]
}, for month in _#q4_months if month < 10 {"1997-0\(month)-01"}, "1997-10-01"], -1)

// Parameter constraints and defaults for Local Supplier Volume Query (Q5)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.5.3 p 36
#q5_params: #Parameters & {
	date:  *"1994-01-01" | "1993-01-01" | "1995-01-01" | "1996-01-01" | "1997-01-01"
	region: or(_regions) | *"ASIA"
}

// Parameter constraints and defaults for Forecasting Revenue Change Query (Q6)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.6.3 p 38
#q6_params: #Parameters & {
	date:  *"1994-01-01" | "1993-01-01" | "1995-01-01" | "1996-01-01" | "1997-01-01"
	discount: float & >= 0.02 & <= 0.09 | *0.06
	quantity: int & >= 24 & <= 25 | *24
}

// Parameter constraints and defaults for Volume Shipping Query (Q7)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.7.3 p 39
#q7_params: #Parameters & {
	nation1: or(_nations) | *"FRANCE"
	nation2: != nation1 & ( or(_nations)  | *"GERMANY")
}

// Nations allowed values as defined in https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 4.2.3 p 87
_nations: ["ALGERIA", "ARGENTINA", "BRAZIL", "CANADA", "EGYPT", "ETHIOPIA", "FRANCE", "GERMANY", "INDIA", "INDONESIA",
						"IRAN", "IRAQ", "JAPAN", "JORDAN", "KENYA", "MOROCCO", "MOZAMBIQUE", "PERU", "CHINA", "ROMANIA",
						"SAUDI ARABIA", "VIETNAM", "RUSSIA", "UNITED KINGDOM", "UNITED STATES"]


// Parameter constraints and defaults for National Market Share Query (Q8)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.8.3 p 41
#q8_params: #Parameters & {
	nation: or(_nations) | *"BRAZIL"
	region: or(_regions) | *"AMERICA"
	syllable1: or(_syllable_1) | *"ECONOMY"
	syllable2: or(_syllable_2) | *"ANODIZED"
	syllable3: or(_syllable_3) | *"STEEL"
}


// Parameter constraints and defaults for Product Type Profit Measure Query (Q9)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.9.3 p 43
#q9_params: #Parameters & {
	color: or(_colors) | *"green"
}

// Colors allowed values as defined in https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 4.2.3 p 86
_colors: ["almond", "antique", "aquamarine", "azure", "beige", "bisque", "black", "blanched", "blue", "blush",
              "brown", "burlywood", "burnished", "chartreuse", "chiffon", "chocolate", "coral", "cornflower",
              "cornsilk", "cream", "cyan", "dark", "deep", "dim", "dodger", "drab", "firebrick", "floral", "forest",
              "frosted", "gainsboro", "ghost", "goldenrod", "green", "grey", "honeydew", "hot", "indian", "ivory",
              "khaki", "lace", "lavender", "lawn", "lemon", "light", "lime", "linen", "magenta", "maroon", "medium",
              "metallic", "midnight", "mint", "misty", "moccasin", "navajo", "navy", "olive", "orange", "orchid",
              "pale", "papaya", "peach", "peru", "pink", "plum", "powder", "puff", "purple", "red", "rose", "rosy",
              "royal", "saddle", "salmon", "sandy", "seashell", "sienna", "sky", "slate", "smoke", "snow", "spring",
              "steel", "tan", "thistle", "tomato", "turquoise", "violet", "wheat", "white", "yellow"]


// Parameter constraints and defaults for Product Type Returned Item Reporting Query (Q10)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.10.3 p 45
#q10_params: #Parameters & {
	date: or(_#q10_valid_dates) | *"1993-10-01"
}

// Generating the appropriate list of valid dates as they are defined in Section 2.4.10.3 p 45
// Then Cue can validate if the date provided is valid based on that (see #q4_params schema definition)
_#q10_years: [1993, 1994]
_#q10_months: [1,2,3,4,5,6,7,8,9,10,11,12]
_#q10_tmp_dates: list.FlattenN([for year in _#q10_years{
    [for month in _#q10_months if month < 10{
        "\(year)-0\(month)-01"
    }, for month in _#q10_months if month >= 10{
        "\(year)-\(month)-01"
    }]
}, "1995-01-01"], -1)
_#q10_valid_dates: list.Slice(_#q10_tmp_dates,1, len(_#q10_tmp_dates))

// Scale factors are defined in https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 4.1.3.1 p 79
_#scale_factors: [1,10,30,100,300,1000,3000,10000,30000,100000]

// Parameter constraints and defaults for Important Stock Identification Query (Q11)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.11.3 p 47
#q11_params: #Parameters & {
	nation: or(_nations) | *"GERMANY"
	fraction: or(0.0001 / _#scale_factors) | *0.0001
}

// Modes allowed values as defined in https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 4.2.2.13 p 82
_#modes: ["REG AIR", "AIR", "RAIL", "SHIP", "TRUCK", "MAIL", "FOB"]

// Parameter constraints and defaults for Shipping Modes and Order Priority Query (Q12)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.12.3 p 49
#q12_params: #Parameters & {
	mode1: or(_#modes) | *"MAIL"
	mode2: != mode1 & (or(_#modes) | *"SHIP")
	date: "1993-01-01" | *"1994-01-01" | "1995-01-01" | "1996-01-01" | "1997-01-01"
}

// Allowed values for Word1 and Word2 for Query 13 as defined in
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.13.3 p 51
_#words1: ["special", "pending", "unusual", "express"]
_#words2: ["packages", "requests", "accounts", "deposits"]

// Parameter constraints and defaults for Customer Distribution Query (Q13)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.13.3 p 51
#q13_params: #Parameters & {
	word1: or(_#words1) | *"special"
	word2: or(_#words2) | *"requests"
}

// Generation of valid dates for Q14 based on Section 2.4.14.3 p 52
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
_#q14_years: [1993, 1994, 1995, 1996, 1997]
_#q14_months: [1,2,3,4,5,6,7,8,9,10,11,12]
_#valid_dates_q14:  list.FlattenN([for year in _#q14_years{
    [for month in _#q14_months if month < 10{
        "\(year)-0\(month)-01"
    }, for month in _#q14_months if month >= 10{
        "\(year)-\(month)-01"
    }]
}], -1)

// Parameter constraints and defaults for Promotion Effect Query (Q14)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.14.3 p 52
#q14_params: #Parameters & {
	date: or(_#valid_dates_q14) | *"1995-09-01"
}

// Generation of valid dates for Q14 based on Section 2.4.15.3 p 53
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
_#q15_years: [1993, 1994, 1995, 1996, 1997]
_#q15_months: [1,2,3,4,5,6,7,8,9,10,11,12]
_#valid_dates_q15: list.FlattenN([for year in _#q15_years if year != 1997{
    [for month in _#q15_months if month < 10{
        "\(year)-0\(month)-01"
    }, for month in _#q15_months if month >= 10{
        "\(year)-\(month)-01"
    }]
}, for month in _#q15_months if month < 10 {"1997-0\(month)-01"}, "1997-10-01"], -1)

// Parameter constraints and defaults for Top Supplier Query (Q15)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.15.3 p 53
#q15_params: #Parameters & {
	date: or(_#valid_dates_q15) | *"1996-01-01"
}


// Parameter constraints and defaults for Parts/Supplier Relationship Query (Q16)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.16.3 p 55
#q16_params: #Parameters & {
	brand: =~ "Brand#[1-5][1-5]" | *"Brand#45"
	type_part1: or(_syllable_1) | *"MEDIUM"
	type_part2: or(_syllable_2) | *"POLISHED"
	size1: (> 0 & <= 50) | *49
	size2: (!= size1 & > 0 & <= 50) | *14
	size3: (!= size1 & != size2 & > 0 & <= 50) | *23
	size4: (!= size1 & != size2 & != size3 & > 0 & <= 50) | *45
	size5: (!= size1 & != size2 & != size3 & != size4 & > 0 & <= 50) | *19
	size6: (!= size1 & != size2 & != size3 & != size4 & != size5 & > 0 & <= 50) | *3
	size7: (!= size1 & != size2 & != size3 & != size4 & != size5 & != size6 & > 0 & <= 50) | *36
	size8: (!= size1 & != size2 & != size3 & != size4 & != size5 & != size6 & != size7 & > 0 & <= 50) | *9
}

// Container allowed values as defined in https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 4.2.2.13 pp 81-82
_container_syllable_one: ['SM', 'LG', 'MED', 'JUMBO', 'WRAP']
_container_syllable_two: ['CASE', 'BOX', 'BAG', 'JAR', 'PKG', 'PACK', 'CAN', 'DRUM']

// Parameter constraints and defaults for Small-Quantity-Order Revenue Query (Q17)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.17.3 p 57
#q17_params: #Parameters & {
	brand: =~ "Brand#[1-5][1-5]" | *"Brand#45"
	container_part1: or(_container_syllable_one) | *"MED"
	container_part2: or(_container_syllable_two) | *"BOX"
}

// Parameter constraints and defaults for Large Volume Customer Query (Q18)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.18.3 p 58
#q18_params: #Parameters & {
	quantity: (>= 312 & <= 315) | *300
}

// Parameter constraints and defaults for Discounted Revenue Query (Q19)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.19.3 p 60
#q19_params: #Parameters & {
	quantity1: ( >= 1 & <= 10) | *1
	quantity2: ( >= 10 & <= 20) | *10
	quantity3: ( >= 20 & <= 30) | *20
	brand1: =~ "Brand#[1-5][1-5]" | *"Brand#12"
	brand2: =~ "Brand#[1-5][1-5]" | *"Brand#23"
	brand3: =~ "Brand#[1-5][1-5]" | *"Brand#34"
}

// Allowed dates for Q20
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.20.3 p 62
_q20_allowed_dates: ["1993-01-01","1994-01-01","1995-01-01", "1996-01-01", "1997-01-01"]

// Parameter constraints and defaults for Potential Part Promotion Query (Q20)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.20.3 p 62
#q20_params: #Parameters & {
	nation: or(_nations) | *"CANADA"
	color: or(_colors) | *"forest"
	date: or(_q20_allowed_dates) | *"1994-01-01"
}

// Parameter constraints and defaults for Suppliers Who Kept Orders Waiting Query (Q21)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.21.3 p 64
#q21_params: #Parameters & {
	nation: or(_nations) | *"SAUDI ARABIA"
}

// Parameter constraints and defaults for Global Sales Opportunity Query (Q22)
// https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
// Section 2.4.21.3 p 64 & Section 4.2.2.9 p 81
#q22_params: #Parameters & {
	i1: (> 10 & <= 34) | *13
	i2: (!= i1 & > 10 & <= 34) | *31
	i3: (!= i1 & != i2 & > 10 & <= 34) | *23
	i4: (!= i1 & != i2 & != i3 & > 10 & <= 34) | *29
	i5: (!= i1 & != i2 & != i3 & != i4 & > 10 & <= 34) | *30
	i6: (!= i1 & != i2 & != i3 & != i4 & != i5 & > 10 & <= 34) | *18
	i7: (!= i1 & != i2 & != i3 & != i4 & != i5 & != i6 & > 10 & <= 34) | *17
}


//seed: #Seed &{
//	db: database
//	params: #q1_params
//}


//input: data & lineitem
//contents: template.Execute(_q1_template, seed)