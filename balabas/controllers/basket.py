from flask import (
	request,
	flash,
	url_for,
	redirect,
	abort,
	get_flashed_messages,
	session,
	jsonify
)

from balabas import app
from flask.ext.restful import Resource
from http.client import responses, OK
OK = responses[OK]

#--------------------------------------------------------

class Basket(Resource):

  def __init__(self):

    self.cart_model = {
		  'items':[],
		  'currency':app.config.get('SHOP_CURRENCY','$'),
		  'sum':0.00,
    }

  def product(self, id , qty):
	  #database.get(id)
	  return {
      "id":id,
      "name":"title"+ str(id),
      "qty":qty,
      "price":"{:10.2f}".format(10.10),
      "total":"{:10.2f}".format(
        qty * 10.10
      ),
		}

  def get(self,**kwargs):
    throw = request.args.get('throw', None)
    if throw:
      session['basket'] = self.cart_model
    basket = session.get("basket", self.cart_model)
    return jsonify(basket)

  def post(self, id):
    """/basket/<id>?qty=5"""
    basket = session.get('basket', self.cart_model)
    qty = request.args.get('qty')
    i = 0
    found = False
    for item in basket["items"]:
      if id==item['id']:
        item['qty'] += 1
        item['qty'] = int(qty or item['qty'])
        item['price'] = "{:10.2f}".format(
            float(item['price'])
        )
        item['total'] = "{:10.2f}".format(
          float(item['qty'] * float(item['price']))
        )
        basket["items"][i] = item
        found = True
        break
      i+=1

    if not found: # fetch from db
      basket["items"].append(self.product(id,int(qty)))



    sum_list = list(
      map(lambda x: float(x.get('total',0) ), basket['items'])
    )
    basket["sum"] =  "{:10.2f}".format(sum(sum_list))


    session["basket"] = basket
    flash('The cart was changed.')
    return OK



  def delete(self, id):

    basket = session.get('basket')

    i = 0
    _all = request.args.get('all')
    for item in basket["items"]:
      if id==item['id']:

        if _all: #remove all items
          basket['items'].remove(item)

        elif int(float(item['total'])) > 1: #remove only one
          item['qty'] -= 1
          item['price'] = "{:10.2f}".format(
            float(item['price'])
          )
          item['total'] = "{:10.2f}".format(
            float(item['qty'] * float(item['price']))
          )
          basket["items"][i] = basket["items"][i] = item
          found = True
        else: # remove remaining
          basket['items'].remove(item)

        break
      i+=1

    sum_list = list(
      map(lambda x: float(x.get('total',0) ), basket['items'])
    )
    basket["sum"] =  "{:10.2f}".format(sum(sum_list))

    session["basket"] = basket
    flash('The cart was changed.')

    return OK

