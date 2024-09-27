import json
import os
import sys
# Add the root project directory to the Python path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))
from database.database_loader import DatabaseManager

with open("../../config.json") as f:
    config = json.load(f)
db = DatabaseManager(config=config["database"])
db.run_sql("./create_table_fred_data.sql")
