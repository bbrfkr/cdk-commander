from django.urls import include, path
from api.auth import views
from rest_framework import routers

router = routers.SimpleRouter()
router.register(r'users', views.UserViewSet)
router.register(r'groups', views.GroupViewSet)

urlpatterns = [
    path('', include(router.urls))
]
