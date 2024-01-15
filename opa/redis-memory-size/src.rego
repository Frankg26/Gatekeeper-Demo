# METADATA
# title: RedisMemorySize
# description: |-
#   Controls the permitted memorySizeGb for a RedisInstance, set to either 8 or 16
# custom:
#   enforcement: deny
#   matchers:
#     kinds:
#     - apiGroups:
#       - redis.cnrm.cloud.google.com
#       kinds:
#       - RedisInstance
#     namespaces:
#     - frank
#   parameters:
#       memory:
#           type: array
#           items:
#             type: integer

# RedisInstance API & Reference
# https://cloud.google.com/config-connector/docs/reference/resource-docs/redis/redisinstance

package redis.memory.size

# Violation ensures RedisInstance contains a memorySizeGb
violation[{"msg": msg}] {
	# Perform a violation check
	not input.review.object.spec.memorySizeGb

	# Error Message
	msg := "The RedisInstance has no memorySizeGb; please provide a RedisInstance with a valid memorySizeGb."
}

# Violation ensures compliance with the RedisInstance memorySizeGb
violation[{"msg": msg}] {
	# Validates regardeless of version
	contains(input.review.object.apiVersion, "redis.cnrm.cloud.google.com")

	# Perform a violation check
	not ValidRedisInstanceMemorySizeGb(input.review.object.spec.memorySizeGb)

	#Error Message
	msg := sprintf("The RedisInstance %v has a memorySizeGb of %v which is not allowed. Allowed memorySizeGb: %v", [input.review.object.metadata.name, input.review.object.spec.memorySizeGb, input.parameters.memory])
}

# Function Rule returns true if memorySizeGb is valid
ValidRedisInstanceMemorySizeGb(mem) {
	# Ensure that the policy applies exclusively to RedisInstance
	input.review.object.kind == "RedisInstance"

	# Verify if it's a valid memorySizeGb
	mem == input.parameters.memory[_]
}