from django.urls import path, include
from . import views
from rest_framework import routers


app_name = 'posts'
urlpatterns = [
    path('allpost/api/', views.PostList.as_view()),
    path('mypost/api/', views.MyPost.as_view()),
]   