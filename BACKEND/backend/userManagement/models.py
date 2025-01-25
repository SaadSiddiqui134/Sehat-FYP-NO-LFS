from django.db import models


class User(models.Model):
    UserID = models.AutoField(primary_key=True, unique=True)
    UserFirstName = models.CharField(max_length=200)
    UserLastName = models.CharField(max_length=200)
    UserEmail = models.EmailField(max_length=200)
    UserPassword = models.CharField(max_length=200)
    
    def __str__(self):
        return self.UserFirstName + " "+ self.UserLastName