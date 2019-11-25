from flask_restful import Resource
from flask import request
from models import db, User
import random
import string





class Register(Resource):
    # def get(self):
    #     users = User.query.all()
    #     user_list = []
    #     for i in range(0,len(users)):
    #         user_list.append(users[i].serialize())
    #     return {"status" : str(user_list)}, 200
    def post(self):
        json_data = request.get_json(force=True)
        if not json_data:
            return  { 'message' : 'No input data provided'}, 401
        # data, errors = User.load(json_data)

        # if errors:
        #     return errors, 422

        user = User.query.filter_by(username=json_data['username']).first()
        if user:
            return {'message' : 'Username not available'}, 402

        # user = User.query.filter_by(emailadress=json_data['emailadress']).first()
        # if user:
        #     return {'message' : 'Email-Adress already under use'}, 403
        

        api_key = self.generate_key()
        user = User.query.filter_by(api_key=api_key).first()
        



        # check if username exists
        # check if the email exists
        # create a user
        # create api_key for user
        user = User(
            api_key = api_key,
            firstname = json_data['firstname'],
            lastname = json_data['lastname'],
            emailadress = json_data['emailadress'],
            password = json_data['password'],
            username = json_data['username'],
        )

        db.session.add(user)
        db.session.commit()

        result = User.serialize(user)

        return {"status": 'success', 'data': result}, 201

    def generate_key(self):
        return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(50))
        
        