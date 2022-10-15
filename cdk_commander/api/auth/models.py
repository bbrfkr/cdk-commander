from django.db import models

# Create your models here.
class User(models.Model):
    name = models.CharField(max_length=255)
    password = models.CharField(max_length=255)

    def __str__(self):
        return self.name

class Group(models.Model):
    name = models.CharField(max_length=255)
    users = models.ManyToManyField(User, blank=True, null=True)

    def __str__(self):
        return self.name
