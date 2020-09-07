import json

import requests
import pandas as pd

from transform import position


def transform_position_handler(event, context):
    print("Hello from Lambda!")
    position.do_transform()
    requests.get("http://www.python.org")
    return {"statusCode": 200, "body": json.dumps("Hello from Lambda H!")}


# transform_position_handler("", "")
