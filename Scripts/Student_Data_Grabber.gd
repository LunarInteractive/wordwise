extends Node

# Encryption key for saving data
const ENCRYPTION_KEY = "KodePasswordGameWordwise"  # Use a strong key (16 bytes for AES-128, 24 bytes for AES-192, 32 bytes for AES-256)

# File path for saving the encrypted data
const FILE_PATH = "user://saved_data.enc"

# Save the given data to a file with encryption
func save_data(data: Dictionary) -> void:
	var json_string = JSON.stringify(data)
	var result = encrypt_string(json_string)
	var encrypted_data = result.encrypted_data
	var iv = result.iv

	var combined_data = iv + encrypted_data

	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_buffer(combined_data)
		file.close()
		print("Data saved successfully!")
	else:
		print("Failed to save data.")

# Load and decrypt data from the file
func load_data() -> Dictionary:
	if FileAccess.file_exists(FILE_PATH):
		var file = FileAccess.open(FILE_PATH, FileAccess.READ)
		if file:
			var combined_data = file.get_buffer(file.get_length())
			file.close()

			var iv = combined_data.subarray(0, 16)
			var encrypted_data = combined_data.subarray(16)

			var json_string = decrypt_string(encrypted_data, iv)
			var json = JSON.new()
			var parsed_data = json.parse(json_string)
			if parsed_data.error == OK:
				return parsed_data.result
			else:
				print("Failed to parse JSON:", parsed_data.error_string)
		else:
			print("Failed to open file.")
	else:
		print("File not found.")
	return {}

# Encrypt a string using AES with IV
func encrypt_string(text: String) -> Dictionary:
	var key = PackedByteArray(ENCRYPTION_KEY.to_utf8_buffer())
	var data = PackedByteArray(text.to_utf8_buffer())
	var aes = AESContext.new()
	var iv = RandomNumberGenerator.new().rand_bytes(16)
	aes.start(key, iv)
	var encrypted = aes.encrypt(data)
	aes.finish()

	return {"encrypted_data": encrypted, "iv": iv}

# Decrypt a string using AES with IV
func decrypt_string(encrypted_data: PackedByteArray, iv: PackedByteArray) -> String:
	var key = PackedByteArray(ENCRYPTION_KEY.to_utf8_buffer())
	var aes = AESContext.new()
	aes.start(key, iv)
	var decrypted = aes.decrypt(encrypted_data)
	aes.finish()
	return decrypted.get_string_from_utf8()

# Fetch all data from the database
func fetch_all_data(base_url: String, name: String) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_fetch_all_completed)
	http_request.request(base_url)

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
						print(filtered_data)
						break

				if filtered_data.empty():
					print("No data found for name containing:", target_name)
				else:
					print("Filtered data:", filtered_data)
					save_data(filtered_data)  # Save the filtered data to the file
			else:
				print("Unexpected data format. 'data' key is missing or not an array.")
		else:
			print("Failed to parse JSON:", parse_result.error_string)
	else:
		print("Failed to fetch data. HTTP Response Code:", response_code)




# Send data to an API (POST request)
func send_data_to_api(url: String, data: Dictionary) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	var headers = ["Content-Type: application/json"]
	var body = JSON.stringify(data)
	http_request.request(url, headers, HTTPClient.METHOD_POST, body)
	print("Data sent to API:", body)

# Entry point
func _ready() -> void:
	fetch_all_data("https://lunarinteractive.net/api/v1/students", "Broderick Bashirian")
