package scuel

import "tool/file"

command: "tpch_gen": {

	output: file.Mkdir & {
			path: "output/"
	}

	for i, R in rendered {
		// make a unique name when comprehending
		"write-\(i+1)": file.Create & {
			$dep: output.$done
			filename: "\(output.path)tpch_q\(i+1).sql"
			contents: R.content
		}
	}
}
