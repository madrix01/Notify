from django.shortcuts import render
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework import status, generics, filters, viewsets
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import *
from .serializers import *
from django.http import JsonResponse


@permission_classes([IsAuthenticated])
class PostList(generics.ListCreateAPIView):
    queryset = Post.objects.all()
    serializer_class = PostSerializers


@permission_classes([IsAuthenticated])
class MyPost(generics.ListCreateAPIView):
    serializer_class = PostSerializers
    def get_queryset(self):
        user = self.request.user
        print(user)
        return Post.objects.filter(user_id = user)