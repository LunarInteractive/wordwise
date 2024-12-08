class_name StudentDataHandler
extends Node
@onready var Nama_Siswa = ""

# Encryption key for saving data
var ENCRYPTION_KEY = "KodePasswordGameWordwise"

# File path for saving the encrypted data
const FILE_PATH = "user://saved_data.enc"

signal send_data_success
signal send_API

func save_game(data: Dictionary) -> void:
	var File = FileAccess.open_encrypted_with_pass("user://PlayerData.save", FileAccess.WRITE, ENCRYPTION_KEY)
	var json_string = JSON.stringify(data)
	
	if File:
		File.store_string(json_string)
		File.close()
		print("Data saved successfuly!")
		emit_signal("send_data_success")
	else:
		print("Failed to save data")

func load_game() -> Dictionary:
	if FileAccess.file_exists("user://PlayerData.save"):
		var File = FileAccess.open_encrypted_with_pass("user://PlayerData.save", FileAccess.READ, ENCRYPTION_KEY)
		
		while File.get_position() < File.get_length():
			var json_string = File.get_as_text()
			File.close()
			
			var json = JSON.new()
			var parse_result = json.parse(json_string)  # This returns an int (error code)

			if parse_result == OK:
				var data = json.data
				print("data : ", data)
				return data  # Return the parsed data from json
			else:
				print("Failed to parse JSON at line", json.get_error_line(), ":", json.get_error_message())
	else:
		print("no file detected")
	return {}


# Fetch all data from the database
func fetch_all_data(base_url: String, name: String) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	# Connect the request completion signal
	http_request.request_completed.connect(_on_fetch_all_completed)
	
	# Send the request
	var error = http_request.request(base_url)
	if error != OK:
		print("Failed to send HTTP request.")
		return  # Exit the function if the request couldn't be sent
	
	print("Request sent successfully.")
	
	# Store the name we are looking for
	self.target_name = name

# Callback for the API request
var target_name = ""

func _on_fetch_all_completed(result, response_code, headers, body):
	if response_code == 200:
		var body_text = body.get_string_from_utf8()

		var json = JSON.new()
		var parse_result = json.parse(body_text)

		if parse_result == OK:
			var response_data = json.data

			# Check if the response has the "data" key and if it's an array
			if response_data.has("data") and typeof(response_data["data"]) == TYPE_ARRAY:
				var all_data = response_data["data"]

				# Filter the data by name (substring match)
				var filtered_data = {}
				for item in all_data:
					if typeof(item) == TYPE_DICTIONARY and item["name"].find(target_name) != -1:
						filtered_data = item
						break

				if filtered_data == null:
					print("No data found for name containing:", target_name)
				else:
					print("Filtered data:", filtered_data)
					save_game(filtered_data)  # Save the filtered data to the file
			else:
				print("Unexpected data format. 'data' key is missing or not an array.")
		else:
			print("Failed to parse JSON:", parse_result.error_string)
	else:
		# Handle different HTTP error code
		print("error fetching")
		match response_code:
			404:
				print("Error: Resource not found (404).")
			500:
				print("Error: Server error (500).")
			_:
				print("Error: HTTP request failed with response code: ", response_code)


func send_data_api(data: Dictionary) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)

	var body = JSON.new().stringify(data)
	var header = ["Content-Type: application/json"]
	var error = http_request.request("https://lunarinteractive.net/api/v1/students", header, HTTPClient.METHOD_POST, body)
	
	http_request.request_completed.connect(self._http_send_completed)
	
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	if error == OK:
		print("data send succesfuly")


# Send data to an API (POST request)
func send_data_to_api(url: String, data: Dictionary) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	var body = JSON.new().stringify(data)
	var error = http_request.request(url, [], HTTPClient.METHOD_POST, body)
	http_request.request_completed.connect(self._http_send_completed)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	emit_signal("send_API")
	print("Data sent to API:", body)

func _http_send_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	
	print(response)
	if response_code == 201 :
		print("data created successfuly")
		emit_signal("send_API")
	else:
		print(response_code)

# Entry point
#func _ready() -> void:
	#load_data()
