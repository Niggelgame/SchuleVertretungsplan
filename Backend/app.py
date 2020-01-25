from flask import Blueprint
from flask_restful import Api
from resources.Register import Register
from resources.Signin import Signin
from resources.LoadData import LoadData
from resources.DeleteAccount import DeleteAccount
from resources.MakeNotification import MakeNotification
from resources.LoadSecondData import LoadSecondData

api_bp = Blueprint('api', __name__)
api = Api(api_bp)



# Route
api.add_resource(Register, '/register')
api.add_resource(Signin, '/signin')
api.add_resource(LoadData, '/data')
api.add_resource(LoadSecondData, '/data2')
api.add_resource(DeleteAccount, '/delete')
api.add_resource(MakeNotification, '/notificate')