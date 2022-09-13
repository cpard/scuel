package scuel

import "tool/file"

command: "tpch_gen": {

	for i, R in rendered {
		// make a unique name when comprehending
		"write-\(i+1)": file.Create & {
			filename: "output/tpch_q\(i+1).sql"
			contents: R.content
		}
	}
}