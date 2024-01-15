package pod.naming

test_access_pod_name_ok {
	input := {
		"kind": "Pod",
		"review": {
			"kind": {"kind": "Pod"},
			"object": {
				"apiVersion": "v1",
				"kind": "Pod",
				"metadata": {"name": "frank-pod-01"},
			},
		},
	}

	results := violation with input as input
	count(results) == 0
}

test_access_pod_name_many_components {
	input := {
		"kind": "Pod",
		"review": {
			"kind": {"kind": "Pod"},
			"object": {
				"apiVersion": "v1",
				"kind": "Pod",
				"metadata": {"name": "frank-01"},
			},
		},
	}

	results := violation with input as input
	count(results) > 0
}

test_access_pod_name_bad_first_component {
	input := {
		"kind": "Pod",
		"review": {
			"kind": {"kind": "Pod"},
			"object": {
				"apiVersion": "v1",
				"kind": "Pod",
				"metadata": {"name": "09-pod-01"},
			},
		},
	}

	results := violation with input as input
	count(results) > 0
}

test_access_pod_name_bad_second_component {
	input := {
		"kind": "Pod",
		"review": {
			"kind": {"kind": "Pod"},
			"object": {
				"apiVersion": "v1",
				"kind": "Pod",
				"metadata": {"name": "frank-pod-nope"},
			},
		},
	}

	results := violation with input as input
	count(results) > 0
}

test_access_pod_name_missing {
	input := {
		"kind": "Pod",
		"review": {
			"kind": {"kind": "Pod"},
			"object": {
				"apiVersion": "v1",
				"kind": "Pod",
			},
		},
	}

	results := violation with input as input
	count(results) > 0
}
