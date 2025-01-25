from django.urls import path
from . import views

urlpatterns = [
    path("users/", views.list_users, name="list_users"),
    path("users/<int:user_id>/", views.user_detail, name="user_detail"),
    path("users/create/", views.create_user, name="create_user"),
    path("users/<int:user_id>/update/", views.update_user, name="update_user"),
    path("users/<int:user_id>/delete/", views.delete_user, name="delete_user"),
]
