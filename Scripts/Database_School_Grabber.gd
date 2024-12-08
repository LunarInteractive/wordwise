extends Node

func _ready():
	# Create a new HTTPRequest instance
	var http_request = HTTPRequest.new()
	add_child(http_request)

	# Connect the request_completed signal to handle the response
	http_request.request_completed.connect(_on_request_completed)

	# Make the API request
	var url = "https://lunarinteractive.net/api/v1/dialogues"
	var headers = []  # No Authorization header

	# Start the request
	var error = http_request.request(url, headers, HTTPClient.METHOD_GET)
	if error != OK:
		print("Failed to make the request: ", error)

func _on_request_completed(result, response_code, headers, body):
	# Decode the body from raw bytes to a string
	var body_text = body.get_string_from_utf8()

	# Parse the JSON
	var json = JSON.new()
	var parse_result = json.parse(body_text)

	if parse_result == OK:
		var data = json.data
		print("Request completed with response code: ", response_code)

		# Store only the dialogue_data in GlobalVariable
		if data.has("data") and typeof(data["data"]) == TYPE_ARRAY:
			GlobalVariable.set_all_dialogue_data_spesific(data["data"])
			print("Dialogue data has been stored.")
		else:
			print("Data is not in the expected format.")
	else:
		print("Failed to parse JSON: ", json.error_message)


# Function to retrieve specific dialogue based on search_text
func get_dialogue_by_search_text(search_text: String) -> String:
	var dialogue_data = GlobalVariable.get_dialogue_by_key(search_text)
	if dialogue_data:
		return dialogue_data
	else:
		return "Dialogue not found for: " + search_text
