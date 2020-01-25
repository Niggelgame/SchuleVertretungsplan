from flask_restful import Resource
from flask import request, Response
from flask import render_template, make_response
from models import db, User
import random
import string
import time
import requests
import json





class LoadSecondData(Resource):
    def get(self):
        header = request.headers['Authorization']
        

        if not header:
            return  { 'message' : 'No Authorization data provided'}, 400
        else:
            print(header)
            user = User.query.filter_by(api_key = header).first()
            if user:
                #htmldata = self.getData()
                headers = {'Content-Type': 'text/html'}
                r = Response()
                r.headers = headers
                r.data = render_template("index2.html").encode("latin-1")
                r.status_code = 200
                
                
                return make_response(render_template("index2.html").encode("latin-1"),200,headers,)
                # return render_template("index.html")
            else:
                return  { 'message' : 'Something went wrong while receving the call'}, 401
                
        

    def getData(self):
        contents = ""
        f = open("resources/index.html", "r", encoding="latin-1")
        #contents = '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><meta http-equiv="X-UA-Compatible" content="ie=edge"><title>Document</title>ww</head>ww<body>ww    Testww</body>ww</html>'
        if f.mode == 'r':
            contents = f.read()
            print(contents)

        f.close()

        return contents

    def post(self):
        stringdataformat = request.get_data(as_text=True)
        stringdatasplit = stringdataformat.split("===")
        
        print("HELLO")
        stringdata =stringdatasplit[1]#request.get_data(as_text=True)
        stringdata.replace('<meta http-equiv="refresh" content="8; URL=subst_001.htm">', '<meta name="viewport" content="width=1000, initial-scale=0">')
        print(request.headers['Authorization'])
        f = open("templates/index2.html", "w+")
        f.write(stringdata)
        f.close()

        if stringdatasplit[0] == "true":
            header = {"Content-Type": "application/json; charset=utf-8",
            "Authorization": "Basic YWE4ZjczZmMtNjI4OS00YWY2LWEzNTEtZjU1YzIxNmViYmEw"}

            payload = {"app_id": "5c2db3b9-64d0-4c42-b2c9-2054484b4da3",
                    "included_segments": ["All"],
                    "contents": {"en": "Neuer Vertretungsplan verfügbar!"}}
            
            req = requests.post("https://onesignal.com/api/v1/notifications", headers=header, data=json.dumps(payload))
            
            print(req.status_code, req.reason)
        return {"status": "success"}, 201
    #def post(self):
        

        #return {"status": 'success', 'data': result}, 201

    
