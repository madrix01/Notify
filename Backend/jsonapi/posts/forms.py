from django import forms
from .models import *

class PostForm(forms.ModelForm):
    title = forms.CharField(max_length=20, widget = forms.TextInput())
    description = forms.CharField(max_length=69)

    class Meta:
        models = Post
        fields = ('title', 'description')