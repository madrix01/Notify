from django.shortcuts import render
from django.http import JsonResponse
import json


def home(request):
    message = {'message' : 'hello'}
    return JsonResponse(message, safe=False)