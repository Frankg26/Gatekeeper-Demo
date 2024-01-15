package redis.memory.size

test_allowed_input {
	input := {
		"kind": "RedisInstance",
		"parameters": {"memory": [8, 16]},
		"review": {
			"kind": {"kind": "RedisInstance"},
			"object": {
				"apiVersion": "redis.cnrm.cloud.google.com/v1beta1",
				"kind": "RedisInstance",
				"metadata": {"name": "frank-redis-01"},
                "spec": {"memorySizeGb": 16},
			},
		},
	}

	results := violation with input as input
	count(results) == 0
}

test_unallowed_input {
	input := {
		"kind": "RedisInstance",
		"parameters": {"memory": [8, 16]},
		"review": {
			"kind": {"kind": "RedisInstance"},
			"object": {
				"apiVersion": "redis.cnrm.cloud.google.com/v1beta1",
				"kind": "RedisInstance",
				"metadata": {"name": "frank-redis-02"},
                "spec": {"memorySizeGb": 4},
			},
		},
	}

	results := violation with input as input
	count(results) > 0
}

test_redis_missing_memory {
	input := {
		"kind": "RedisInstance",
		"parameters": {"memory": [8, 16]},
		"review": {
			"kind": {"kind": "RedisInstance"},
			"object": {
				"apiVersion": "redis.cnrm.cloud.google.com/v1beta1",
				"kind": "RedisInstance",
				"metadata": {"name": "frank-redis-03"},
			},
		},
	}

	results := violation with input as input
	count(results) > 0
}