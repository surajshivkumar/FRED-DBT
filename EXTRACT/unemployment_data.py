import os
import sys

# Add the root project directory to the Python path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

import pandas as pd  # type: ignore
import json
from FREDDataFetcher import FREDDataFetcher
from database.database_loader import DatabaseManager

with open("../config.json") as f:
    config = json.load(f)
    API_KEY = config["api_keys"]["fred_api_key"]

FRED = FREDDataFetcher(API_KEY=API_KEY, state_codes="state_codes.json")

# search for IDS
search_params = {
    "search_text": f"*UR",
    "search_type": "series_id",
    "tag_names": "state;monthly",
    "file_type": "json",
    "limit": 50,
    "api_key": API_KEY,
}

search_data = FRED.search(params=search_params)


search_ids = pd.DataFrame(pd.DataFrame(search_data).seriess.values.tolist()).id.values
data = pd.DataFrame()
for series in search_ids:
    try:
        params_obs = {
            "observation_start": "2010-01-01",
            "observation_end": "2024-01-01",
            "api_key": API_KEY,
            "series_id": series,
        }
        data_obs = FRED.get_observations(params_obs)
        data_obs = pd.DataFrame(data_obs["observations"])
        data_obs["state"] = FRED.state_codes[series[:2]]
        data_obs["state_code"] = series[:2]
        data_obs = data_obs[["date", "value", "state", "state_code"]]
        data_obs["metric"] = "unemployment_rate"
        data = pd.concat([data, data_obs], axis=0)
    except:
        print(f"Data Not Found For {series}")

db = DatabaseManager(config=config["database"])
db.insert_data(table="raw_fred_data", data=data.values)
