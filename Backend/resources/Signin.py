from flask_restful import Resource
from flask import request
from models import db, User
import random
import string





class Signin(Resource):
    def get(self):
        users = User.query.all()
        user_list = []
        for i in range(0,len(users)):
            user_list.append(users[i].serialize())
        return {"status" : str(user_list)}, 200
    def post(self):
        result = ""
        json_data = request.get_json(force=True)
        
        header = request.headers["Authorization"]

        if not header:
            return self.user_and_password_signin(json_data)
        else:
            print(header)
            user = User.query.filter_by(api_key = header).first()
            if user:
                result = User.serialize(user)
            else:
                return self.user_and_password_signin(json_data)

        return {"status": 'success', 'data': result}, 201

    def user_and_password_signin(self, json_data):
        if not json_data:
                return  { 'message' : 'No input data provided'}, 400
            # data, errors = User.load(json_data)

            # if errors:
            #     return errors, 422

        user = User.query.filter_by(username=json_data['username']).first()
        if not user:
            return {'message' : 'Username not available'}, 400

        if user.password != json_data['password']:
            return {'message': 'Password incorrect'}, 400
            
        return {'message': 'success', 'data': User.serialize(user)}, 201


        
        