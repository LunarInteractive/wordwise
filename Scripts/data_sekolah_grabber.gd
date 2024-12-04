extends Node

@onready var Api_Grabber : GDScript = preload("res://Scripts/Student_Data_Grabber.gd")  # Assuming Api_Grabber is your script for handling API requests

@onready var target_kode_sekolah : String = GlobalVariable.ClassCode  # Replace with the specific kode_sekolah you're searching for
@onready var filtered_data : Array = []  # This will store the filtered results

# Function to fetch data from the API
func fetch_data_from_api(base_url: String) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_fetch_completed)
	http_request.request(base_url)
	print("Fetching data from: ", base_url)

# Callback for handling the API response
func _on_fetch_completed(result, response_code, headers, body) -> void:
	if response_code == 200:
		var body_text = body.get_string_from_utf8()
		
		var json = JSON.new()
		var parse_result = json.parse(body_text)

		if parse_result == OK:
			var all_data = json.data["data"]  # Assuming the data is in the "data" key
			print("Data fetched successfully:", all_data)
			
			filter_data_by_kode_sekolah(all_data)  # Call the filter function
		else:
			print("Failed to parse JSON: ", json.error_message)
	else:
		print("Error: HTTP request failed with response code: ", response_code)

# Function to filter data based on "kode_sekolah"
func filter_data_by_kode_sekolah(all_data: Dictionary) -> void:
	for item in all_data:
		if item.has("kode_sekolah") and item["kode_sekolah"] == target_kode_sekolah:
			filtered_data.append(item)
	
	print("Filtered data for kode_sekolah ", target_kode_sekolah, ": ", filtered_data)

# Save filtered data (you can customize the save functionality)
func save_filtered_data() -> void:
	if filtered_data.size() > 0:
		var file = FileAccess.open("user://filtered_data.json", FileAccess.WRITE)
		if file:
			var json_string = JSON.stringify(filtered_data)
			file.store_string(json_string)
			file.close()
			print("Filtered data saved successfully!")
		else:
			print("Failed to save filtered data.")
	else:
		print("No data to save.")

# Call the function to fetch data
func _ready() -> void:
	fetch_data_from_api("https://lunarinteractive.net/api/v1/dialogues")  # Replace with your actual API URL
