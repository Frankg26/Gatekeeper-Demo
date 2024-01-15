# METADATA
# title: PodNaming
# description: |-
#   This policy validates the naming convention for a Pod
#   Format: {org}-pod-{01~10}
# custom:
#   enforcement: deny
#   matchers:
#     kinds:
#     - apiGroups:
#       - ""
#       kinds:
#       - Pod
#     namespaces:
#     - frank

package pod.naming

# Violation ensures there is a Pod name
violation[{"msg": msg}] {
	# Perform a violation check
	not input.review.object.metadata.name

	# Error Message
	msg := "There is no Pod name; please provide a manifest with a valid Pod name."
}

# Violation ensures compliance with the Pod naming convention
violation[{"msg": msg}] {
	# Perform a violation check
	not ValidPodName

	# Error Message
	msg := sprintf("The Pod %v is not following the correct naming convention. The valid naming convention is: {org}-pod-{01~10}.", [input.review.object.metadata.name])
}

# Function Rule returns true if the Pod name is valid
ValidPodName {
	# Ensure that the policy applies exclusively to Pods
	input.review.object.kind == "Pod"

	# Retrieve the Pod name pieces and ensure the correct naming convention, which mandates two parts after the split
	pieces := split(input.review.object.metadata.name, "-pod-")
	count(pieces) == 2	

	# Validate the pieces of the Pod name
	org := pieces[0]
	id := pieces[1]
	re_match("[a-zA-Z]+", org)
	re_match("[0-9]", id)
}
