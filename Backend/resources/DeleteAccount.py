from flask_restful import Resource
from flask import request
from models import db, User
import random
import string





class DeleteAccount(Resource):
    def post(self):
        print(request.data)
        json_data = request.get_json(force=True)
        
        header = request.headers["Authorization"]

        if not header:
            return {"status": 'Failed'}, 403
        else:
            print(header)
            if header == "HPU9mKF2A8J4MwyXqQmiuvdwXaxnFT2ASnOvWiIOrZ9X3qWkrp":
                user = db.session.query(User).filter_by(api_key = json_data["api_key"]).first()
                if user:
                    db.session.delete(user)
                    db.session.commit()
                else:
                    return {"status": 'Failed because no User was found'}, 401

                
            else:
                return {"status": 'Failed because theres the wrong authentication'}, 402

        return {"status": 'success'}, 201

