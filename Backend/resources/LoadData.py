from flask_restful import Resource
from flask import request
from flask import render_template, make_response
from models import db, User
import random
import string
import time





class LoadData(Resource):
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
                
                return make_response(render_template("test.html"),200,headers)
                # return render_template("index.html")
            else:
                return  { 'message' : 'Something went wrong while receving the call'}, 401
                
        

    def getData(self):
        contents = ""
        f = open("resources/index.html", "r", encoding="utf8")
        #contents = '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><meta http-equiv="X-UA-Compatible" content="ie=edge"><title>Document</title>ww</head>ww<body>ww    Testww</body>ww</html>'
        if f.mode == 'r':
            contents = f.read()
            print(contents)

        f.close()

        return contents

    def post(self):
        print(request.data)
        print(request.headers['Authorization'])
        f = open("templates/test.html", "w+")
        f.write("".join(map(chr, request.data)))
        f.close()
        return {"status": "success"}, 201
    #def post(self):
        

        #return {"status": 'success', 'data': result}, 201

    