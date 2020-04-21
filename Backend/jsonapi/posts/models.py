from django.db import models
from django.contrib.auth import get_user_model


User = get_user_model()


class Post(models.Model):
    title = models.TextField(max_length=20)
    description = models.TextField(max_length=69    )
    user_id = models.ForeignKey(User, on_delete=models.CASCADE, null=True, default=1)
    timepost = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title