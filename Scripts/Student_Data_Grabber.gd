class_name StudentDataHandler
extends Node
@onready var Nama_Siswa = ""

# Encryption key for saving data
var ENCRYPTION_KEY = "KodePasswordGameWordwise"  # Use a strong key (16 bytes for AES-128, 24 bytes for AES-192, 32 bytes for AES-256)

# File path for saving the encrypted data
const FILE_PATH = "user://saved_data.enc"

signal send_data_success
signal send_API

# Save the given data to a file with encryption
func save_data(data: Dictionary) -> void:
	var json_string = JSON.stringify(data)
	var result = encrypt_string(json_string)
	print("result : ", result)
	var encrypted_data = result.encrypted_data
	var iv = result.iv

	var combined_data = iv + encrypted_data


	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_buffer(combined_data)
		file.close()
		print("Data saved successfully!")
		emit_signal("send_data_success")
	else:
		print("Failed to save data.")

# Load and decrypt data from the file
func load_data() -> Dictionary:
	if FileAccess.file_exists(FILE_PATH):
		var file = FileAccess.open(FILE_PATH, FileAccess.READ)
		if file:
			var combined_data = file.get_buffer(file.get_length())
			print(combined_data)
			file.close()

			var iv = combined_data.slice(0, 16)  # Extract the first 16 bytes as IV
			var encrypted_data = combined_data.slice(16, combined_data.size())  # Extract the rest as encrypted data
			
			var json_string = decrypt_string(encrypted_data, iv)
			var json = JSON.new()
			print("JSON String:", json_string)
			var parse_result = json.parse(json_string)  # This returns an int (error code)
			
			print(parse_result)
			if parse_result == OK:
				print("bisa dapetin file")
				var data = json.data
				return data  # Return the parsed data from json
			else:
				print("Failed to parse JSON at line", json.get_error_line(), ":", json.get_error_message())
		else:
			print("Failed to open file.")
	else:
		print("File not found.")
	return {}




# Encrypt a string using AES with IV
func encrypt_string(text: String) -> Dictionary:
	var key = ENCRYPTION_KEY
	var data = text
	print("data : ", data)
	var aes = AESContext.new()
	var iv = generate_random_iv()  # Generate random IV for encryption
	aes.start(AESContext.MODE_ECB_ENCRYPT, key.to_utf8_buffer())
	var encrypted = aes.update(data.to_utf8_buffer())
	aes.finish()

	return {"encrypted_data": encrypted, "iv": iv}

# Decrypt a string using AES with IV
func decrypt_string(encrypted_data: PackedByteArray, iv: PackedByteArray) -> String:
	var key = ENCRYPTION_KEY
	var aes = AESContext.new()
	aes.start(AESContext.MODE_ECB_DECRYPT, key.to_utf8_buffer())
	var decrypted = aes.update(encrypted_data)
	aes.finish()
	return decrypted.get_string_from_utf8()

# Generate a random 16-byte initialization vector (IV)
func generate_random_iv() -> PackedByteArray:
	var iv = PackedByteArray()
	for i in range(16):
		iv.append(randi() % 256)  # Generate random byte (0-255)
	return iv

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
		print("trying to fetch")
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
						print(filtered_data)
						break

				if filtered_data == null:
					print("No data found for name containing:", target_name)
				else:
					print("Filtered data:", filtered_data)
					save_data(filtered_data)  # Save the filtered data to the file
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
