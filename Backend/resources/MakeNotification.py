from flask_restful import Resource
from flask import request, Response
import requests
import json

class MakeNotification(Resource):
    def post(self):
        header = request.headers["Authorization"]
        if header == "HPU9mKF2A8J4MwyXqQmiuvdwXaxnFT2ASnOvWiIOrZ9X3qWkrp":
            json_data = request.get_json(force=True)
            if not json_data:
                return { 'message' : 'No Input data provided'}, 401
            
            message_title = json_data['title']
            message_subtitle = json_data['subtitle']
            message_content = json_data['content']

            if not message_content:
                return { 'message' : 'No Input data provided'}, 401
            
            header = {"Content-Type": "application/json; charset=utf-8",
            "Authorization": "Basic YWE4ZjczZmMtNjI4OS00YWY2LWEzNTEtZjU1YzIxNmViYmEw"}

            payload = {"app_id": "5c2db3b9-64d0-4c42-b2c9-2054484b4da3",
                    "included_segments": ["All"],
                    "contents": {"en": "" +message_content +  ""},
                    "headings": {"en": "" + message_title + ""},
                    "subtitle": {"en": "" + message_subtitle + ""}}
            
            req = requests.post("https://onesignal.com/api/v1/notifications", headers=header, data=json.dumps(payload))
            
            print(req.status_code, req.reason)

            return "", 200
        return "", 401