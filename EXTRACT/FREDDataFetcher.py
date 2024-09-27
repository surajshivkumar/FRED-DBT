import requests

import json


class FREDDataFetcher:
    def __init__(self, API_KEY, state_codes) -> None:
        self.base_url_search = "https://api.stlouisfed.org/fred/series/search?"
        self.base_url_observations = (
            "https://api.stlouisfed.org/fred/series/observations?"
        )
        self.API_KEY = API_KEY
        with open(state_codes) as f:
            self.state_codes = json.load(f)

    def search(self, params):
        params["file_type"] = "json"
        try:
            data = requests.get(self.base_url_search, params=params)
            data.raise_for_status()
            return data.json()
        except requests.RequestException as e:
            print(f"Error fetching search data: {e}")
            return None

    def get_observations(self, params):
        params["file_type"] = "json"
        try:
            data = requests.get(self.base_url_observations, params=params)
            data.raise_for_status()
            return data.json()
        except requests.RequestException as e:
            print(f"Error fetching observation data: {e}")
            return None
