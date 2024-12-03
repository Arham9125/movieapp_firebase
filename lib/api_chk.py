import requests

api_key_url = "https://api.themoviedb.org/3/movie/popular?api_key=77bf0076f474763e9d54868faee68576"

def check_apikey(api_url):
    try:
        response = requests.get(api_url)
        
        if response.status_code == 200:
            print("API key is valid!")
            return True
        else:
            print(f"Error: {response.status_code} - {response.reason}")
            return False
    except requests.RequestException as e:
        print(f"An error occurred: {e}")
        return False

# Check if the API key is valid
check_apikey(api_key_url)
