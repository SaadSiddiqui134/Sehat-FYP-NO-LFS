from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse
from django.contrib.auth.hashers import make_password
from .models import User

# List all users
def list_users(request):
    users = User.objects.all()
    user_list = [
        {
            "UserID": u.UserID,
            "UserFirstName": u.UserFirstName,
            "UserLastName": u.UserLastName,
            "UserEmail": u.UserEmail,
        }
        for u in users
    ]
    return JsonResponse({"users": user_list})

# Get details of a specific user
def user_detail(request, user_id):
    user_obj = get_object_or_404(User, UserID=user_id)
    user_data = {
        "UserID": user_obj.UserID,
        "UserFirstName": user_obj.UserFirstName,
        "UserLastName": user_obj.UserLastName,
        "UserEmail": user_obj.UserEmail,
    }
    return JsonResponse(user_data)

# Create a new user with hashed password
def create_user(request):
    if request.method == "POST":
        first_name = request.POST.get("UserFirstName")
        last_name = request.POST.get("UserLastName")
        email = request.POST.get("UserEmail")
        password = request.POST.get("UserPassword")

        # Hash the password
        hashed_password = make_password(password)

        # Save the new user
        user_obj = User.objects.create(
            UserFirstName=first_name,
            UserLastName=last_name,
            UserEmail=email,
            UserPassword=hashed_password,
        )
        return JsonResponse({"status": "success", "UserID": user_obj.UserID})
    return JsonResponse({"status": "error", "message": "Invalid request method"}, status=405)

# Update an existing user's details (excluding password updates here)
def update_user(request, user_id):
    user_obj = get_object_or_404(User, UserID=user_id)
    if request.method == "POST":
        user_obj.UserFirstName = request.POST.get("UserFirstName", user_obj.UserFirstName)
        user_obj.UserLastName = request.POST.get("UserLastName", user_obj.UserLastName)
        user_obj.UserEmail = request.POST.get("UserEmail", user_obj.UserEmail)
        user_obj.save()
        return JsonResponse({"status": "success", "message": "User updated successfully"})
    return JsonResponse({"status": "error", "message": "Invalid request method"}, status=405)

# Delete a user
def delete_user(request, user_id):
    user_obj = get_object_or_404(User, UserID=user_id)
    user_obj.delete()
    return JsonResponse({"status": "success", "message": "User deleted successfully"})
